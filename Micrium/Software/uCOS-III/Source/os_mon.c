/*
************************************************************************************************************************
*                                                      uC/OS-III
*                                                 The Real-Time Kernel
*
*                                  (c) Copyright 2009-2015; Micrium, Inc.; Weston, FL
*                           All rights reserved.  Protected by international copyright laws.
*
*                                                 MONITOR MANAGEMENT
*
* File    : OS_MON.C
* By      : JJL
* Version : V3.04.04
*
* LICENSING TERMS:
* ---------------
*           uC/OS-III is provided in source form for FREE short-term evaluation, for educational use or
*           for peaceful research.  If you plan or intend to use uC/OS-III in a commercial application/
*           product then, you need to contact Micrium to properly license uC/OS-III for its use in your
*           application/product.   We provide ALL the source code for your convenience and to help you
*           experience uC/OS-III.  The fact that the source is provided does NOT mean that you can use
*           it commercially without paying a licensing fee.
*
*           Knowledge of the source code may NOT be used to develop a similar product.
*
*           Please help us continue to provide the embedded community with the finest software available.
*           Your honesty is greatly appreciated.
*
*           You can find our product's user manual, API reference, release notes and
*           more information at https://doc.micrium.com.
*           You can contact us at www.micrium.com.
************************************************************************************************************************
*/

#define  MICRIUM_SOURCE
#include "os.h"

#ifdef VSC_INCLUDE_SOURCE_FILE_NAMES
const  CPU_CHAR  *os_mon__c = "$Id: $";
#endif

#if (OS_CFG_MON_EN == DEF_ENABLED)
/*
************************************************************************************************************************
*                                                  CREATE A MONITOR
*
* Description: This function creates a monitor.
*
* Arguments  : p_mon         Pointer to the semaphore to initialize.  Your application is responsible for
*                            allocating storage for the monitor.
*
*              p_name        Pointer to the name you would like to give the monitor.
*
*              p_mon_data    Pointer to the monitor global data.
*
*              p_err         Pointer to a variable that will contain an error code returned by this function.
*
*                                OS_ERR_NONE                    if the call was successful
*                                OS_ERR_CREATE_ISR              if you called this function from an ISR
*                                OS_ERR_ILLEGAL_CREATE_RUN_TIME if you are trying to create the semaphore after you
*                                                                 called OSSafetyCriticalStart().
*                                OS_ERR_NAME                    if 'p_name' is a NULL pointer
*                                OS_ERR_OBJ_CREATED             if the semaphore has already been created
*                                OS_ERR_OBJ_PTR_NULL            if 'p_mon'  is a NULL pointer
*                                OS_ERR_OBJ_TYPE                if 'p_mon' has already been initialized to a different
*                                                               object type
*
* Returns    : none
*
************************************************************************************************************************
*/

void  OSMonCreate (OS_MON   *p_mon,
                   CPU_CHAR *p_name,
                   void     *p_mon_data,
                   OS_ERR   *p_err)
{
    CPU_SR_ALLOC();


#ifdef OS_SAFETY_CRITICAL
    if (p_err == DEF_NULL) {
        OS_SAFETY_CRITICAL_EXCEPTION();
        return;
    }
#endif

#ifdef OS_SAFETY_CRITICAL_IEC61508
    if (OSSafetyCriticalStartFlag == DEF_TRUE) {
       *p_err = OS_ERR_ILLEGAL_CREATE_RUN_TIME;
        return;
    }
#endif

#if (OS_CFG_CALLED_FROM_ISR_CHK_EN == DEF_ENABLED)
    if (OSIntNestingCtr > 0u) {                                 /* Not allowed to be called from an ISR                 */
       *p_err = OS_ERR_CREATE_ISR;
        return;
    }
#endif

#if (OS_CFG_ARG_CHK_EN == DEF_ENABLED)
    if (p_mon == DEF_NULL) {                                    /* Validate 'p_mon'                                     */
       *p_err = OS_ERR_OBJ_PTR_NULL;
        return;
    }
#endif

    OS_CRITICAL_ENTER();
#if (OS_OBJ_TYPE_REQ == DEF_ENABLED)
    p_mon->Type    = OS_OBJ_TYPE_MON;                           /* Mark the data structure as a monitor                 */
#endif

#if (OS_CFG_DBG_EN == DEF_ENABLED)
    p_mon->NamePtr = p_name;                                    /* Save the name of the monitor                         */
#else
    (void)&p_name;
#endif

    OS_PendListInit(&p_mon->PendList);

#if (OS_CFG_DBG_EN == DEF_ENABLED)
    OS_MonDbgListAdd(p_mon);
    OSMonQty++;
#endif

    if (p_mon_data != DEF_NULL) {
        p_mon->MonDataPtr = p_mon_data;
    }

    OS_CRITICAL_EXIT_NO_SCHED();

   *p_err = OS_ERR_NONE;
}


/*
************************************************************************************************************************
*                                               PERFORM AND OPERATION ON A MONITOR
*
* Description: This function performs an operation on a monitor.
*
* Arguments  : p_mon      Pointer to the monitor
*
*              timeout    Optional timeout to be applied if the monitor blocks (pend).
*
*              p_arg      Argument of the monitor.
*
*              p_on_enter Callback called at the entry of the OSMonOp.
*
*              p_on_eval  Callback to be registered as the monitor's evaluation function.
*
*              p_mon_ctx  Monitor context. Unused should be DEF_NULL.
*
*              opt        Possible options are :
*                           OS_OPT_POST_NO_SCHED     Do not call the scheduler
*
*              p_err      Pointer to a variable that will contain an error code returned by this function.
*
*                           OS_ERR_NONE          The call was successful and the semaphore was signaled.
*                           OS_ERR_OBJ_PTR_NULL  If 'p_sem' is a NULL pointer.
*                           OS_ERR_OBJ_TYPE      If 'p_sem' is not pointing at a semaphore
*
* Returns    : none.
*
* Note(s)    : none.
************************************************************************************************************************
*/

void  OSMonOp (OS_MON               *p_mon,
               OS_TICK               timeout,
               void                 *p_arg,
               OS_MON_ON_ENTER_PTR   p_on_enter,
               OS_MON_ON_EVAL_PTR    p_on_eval,
               OS_MON_CTX           *p_mon_ctx,
               OS_OPT                opt,
               OS_ERR               *p_err)
{
    CPU_INT32U        op_res;
    CPU_INT32U        mon_res;
    OS_PEND_LIST     *p_pend_list;
    OS_PEND_DATA     *p_pend_data;
    OS_PEND_DATA     *p_pend_data_next;
    OS_PEND_DATA      pend_data;
    OS_MON_DATA       mon_data;
    OS_MON_DATA      *p_data;
    void             *p_eval_data;
    CPU_BOOLEAN       sched;
    CPU_INT08U        list_it_ctr;
    CPU_SR_ALLOC();


#ifdef OS_SAFETY_CRITICAL
    if (p_err == DEF_NULL) {
        OS_SAFETY_CRITICAL_EXCEPTION();
        return;
    }
#endif

#if (OS_CFG_INVALID_OS_CALLS_CHK_EN == DEF_ENABLED)             /* Is the kernel running?                               */
    if (OSRunning != OS_STATE_OS_RUNNING) {
       *p_err = OS_ERR_OS_NOT_RUNNING;
        return;
    }
#endif

#if (OS_CFG_ARG_CHK_EN == DEF_ENABLED)
    if (p_mon == DEF_NULL) {                                    /* Validate 'p_mon'                                     */
       *p_err  = OS_ERR_OBJ_PTR_NULL;
        return;
    }
#endif

    (void)&p_mon_ctx;

    sched = DEF_NO;

    OS_CRITICAL_ENTER();

    if (p_on_enter != DEF_NULL) {
        op_res = (*p_on_enter)(p_mon, p_arg);
    } else {
        op_res = OS_MON_RES_BLOCK | OS_MON_RES_STOP_EVAL;
    }

    if (DEF_BIT_IS_SET(op_res, OS_MON_RES_BLOCK) == DEF_YES) {
        OS_Pend(&pend_data,                                     /* Block task pending on Condition Variable             */
                (OS_PEND_OBJ *)(p_mon),
                OS_TASK_PEND_ON_COND_VAR,
                timeout);

        sched = DEF_YES;
    }


    pend_data.RdyMsgPtr  = &mon_data;
    mon_data.p_eval_data = p_arg;
    mon_data.p_on_eval   = p_on_eval;

    if (DEF_BIT_IS_CLR(op_res, OS_MON_RES_STOP_EVAL) == DEF_YES) {
        p_pend_list = &p_mon->PendList;
        if (p_pend_list->HeadPtr != DEF_NULL) {
            for (list_it_ctr = 0u ; list_it_ctr < 2u; list_it_ctr++) {
                p_pend_data = p_pend_list->HeadPtr;
                while (p_pend_data != DEF_NULL) {
                    p_pend_data_next = p_pend_data->NextPtr;

                    p_data = (OS_MON_DATA *)p_pend_data->RdyMsgPtr;
                    p_on_eval = p_data->p_on_eval;
                    p_eval_data = p_data->p_eval_data;

                    if (p_on_eval != DEF_NULL) {
                        mon_res = (*p_on_eval)(p_mon, p_eval_data, p_arg, list_it_ctr);
                    } else {
                        mon_res = OS_MON_RES_STOP_EVAL;
                    }

                    if (DEF_BIT_IS_CLR(mon_res, OS_MON_RES_BLOCK) == DEF_YES) {
                        OS_Post((OS_PEND_OBJ *)(p_mon), p_pend_data->TCBPtr, DEF_NULL, 0u, 0u);
                        if (DEF_BIT_IS_CLR(opt, OS_OPT_POST_NO_SCHED) == DEF_YES) {
                            sched = DEF_YES;
                        }
                    }

                    if (DEF_BIT_IS_SET(mon_res, OS_MON_RES_STOP_EVAL) == DEF_YES) {
                        goto exit_pend_eval;
                    }

                    p_pend_data = p_pend_data_next;
                }
            }

        }

    }

exit_pend_eval:

    OS_CRITICAL_EXIT_NO_SCHED();

    if (sched == DEF_YES) {
        OSSched();                                              /* Find the next highest priority task ready to run     */
    }

    if (DEF_BIT_IS_SET(op_res, OS_MON_RES_BLOCK) == DEF_YES) {
    CPU_CRITICAL_ENTER();
        switch (OSTCBCurPtr->PendStatus) {
            case OS_STATUS_PEND_OK:                             /* We got the semaphore                                 */
                *p_err = OS_ERR_NONE;
                 break;

            case OS_STATUS_PEND_ABORT:                          /* Indicate that we aborted                             */
                *p_err = OS_ERR_PEND_ABORT;
                 break;

            case OS_STATUS_PEND_TIMEOUT:                        /* Indicate that we didn't get semaphore within timeout */
                *p_err = OS_ERR_TIMEOUT;
                 break;

            case OS_STATUS_PEND_DEL:                            /* Indicate that object pended on has been deleted      */
                *p_err = OS_ERR_OBJ_DEL;
                 break;

            default:
                *p_err = OS_ERR_STATUS_INVALID;
        }
    CPU_CRITICAL_EXIT();
    } else {
       *p_err = OS_ERR_NONE;
    }
}

/*
************************************************************************************************************************
*                                        ADD/REMOVE MONITOR TO/FROM DEBUG LIST
*
* Description: These functions are called by uC/OS-III to add or remove a monitor to/from the debug list.
*
* Arguments  : p_mon     is a pointer to the monitor to add/remove
*
* Returns    : none
*
* Note(s)    : These functions are INTERNAL to uC/OS-III and your application should not call it.
************************************************************************************************************************
*/


#if (OS_CFG_DBG_EN == DEF_ENABLED)
void  OS_MonDbgListAdd (OS_MON  *p_mon)
{
    p_mon->DbgNamePtr               = (CPU_CHAR *)((void *)" ");
    p_mon->DbgPrevPtr               = DEF_NULL;
    if (OSMonDbgListPtr == DEF_NULL) {
        p_mon->DbgNextPtr           = DEF_NULL;
    } else {
        p_mon->DbgNextPtr           =  OSMonDbgListPtr;
        OSMonDbgListPtr->DbgPrevPtr =  p_mon;
    }
    OSMonDbgListPtr                 =  p_mon;
}



void  OS_MonDbgListRemove (OS_MON  *p_mon)
{
    OS_MON  *p_mon_next;
    OS_MON  *p_mon_prev;


    p_mon_prev = p_mon->DbgPrevPtr;
    p_mon_next = p_mon->DbgNextPtr;

    if (p_mon_prev == DEF_NULL) {
        OSMonDbgListPtr = p_mon_next;
        if (p_mon_next != DEF_NULL) {
            p_mon_next->DbgPrevPtr = DEF_NULL;
        }
        p_mon->DbgNextPtr = DEF_NULL;

    } else if (p_mon_next == DEF_NULL) {
        p_mon_prev->DbgNextPtr = DEF_NULL;
        p_mon->DbgPrevPtr      = DEF_NULL;

    } else {
        p_mon_prev->DbgNextPtr =  p_mon_next;
        p_mon_next->DbgPrevPtr =  p_mon_prev;
        p_mon->DbgNextPtr      = DEF_NULL;
        p_mon->DbgPrevPtr      = DEF_NULL;
    }
}
#endif

#endif
