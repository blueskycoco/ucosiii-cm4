/*
*********************************************************************************************************
*
*                                    MICRIUM BOARD SUPPORT PACKAGE
*
*                          (c) Copyright 2003-2013; Micrium, Inc.; Weston, FL
*
*               All rights reserved.  Protected by international copyright laws.
*
*               This BSP is provided in source form to registered licensees ONLY.  It is
*               illegal to distribute this source code to any third party unless you receive
*               written permission by an authorized Micrium representative.  Knowledge of
*               the source code may NOT be used to develop a similar product.
*
*               Please help us continue to provide the Embedded community with the finest
*               software available.  Your honesty is greatly appreciated.
*
*               You can contact us at www.micrium.com.
*********************************************************************************************************
*/

/*
*********************************************************************************************************
*
*                                    MICRIUM BOARD SUPPORT PACKAGE
*                                  CORTEX A9 OS BOARD SUPORT PACKAGE
*
* Filename      : bsp_os.c
* Version       : V1.00
* Programmer(s) : JBL
*********************************************************************************************************
*/


/*
*********************************************************************************************************
*                                             INCLUDE FILES
*********************************************************************************************************
*/

#include  <lib_def.h>
#include  <cpu.h>

#include  <os_cpu.h>

#include  <bsp.h>
#include  <bsp_os.h>
#include  <bsp_int.h>



/*
*********************************************************************************************************
*                                            LOCAL DEFINES
*********************************************************************************************************
*/

#define  ARM_PTMR_REG_PTLR     (*((CPU_REG32 *)(ARM_PRIV_PERIPH_BASE + 0x0600))) /* Private timer load register.        */
#define  ARM_PTMR_REG_PTCTRR   (*((CPU_REG32 *)(ARM_PRIV_PERIPH_BASE + 0x0604))) /* Private timer counter register.     */
#define  ARM_PTMR_REG_PTCTLR   (*((CPU_REG32 *)(ARM_PRIV_PERIPH_BASE + 0x0608))) /* Private timer control register.     */
#define  ARM_PTMR_REG_PTISR    (*((CPU_REG32 *)(ARM_PRIV_PERIPH_BASE + 0x060C))) /* Private timer interrupt status register.*/


/*
*********************************************************************************************************
*                                      BSP_OS_SemCreate()
*
* Description : Creates a sempahore to lock/unlock
*
* Argument(s) : p_sem        Pointer to a BSP_OS_SEM structure
*
*               sem_val      Initial value of the semaphore.
*
*               p_sem_name   Pointer to the semaphore name.
*
* Return(s)   : DEF_OK        if the semaphore was created.
*               DEF_FAIL      if the sempahore could not be created.
*
* Caller(s)   : Application.
*
* Note(s)     : none.
*
*********************************************************************************************************
*/

CPU_BOOLEAN  BSP_OS_SemCreate (BSP_OS_SEM       *p_sem,
                               BSP_OS_SEM_VAL    sem_val,
                               CPU_CHAR         *p_sem_name)
{
    OS_EVENT    *p_event;

#if (OS_EVENT_NAME_EN > 0)
    CPU_INT08U  err;
#endif

    p_event = OSSemCreate(sem_val);

    if (p_event == (OS_EVENT *)0) {
        return (DEF_FAIL);
    }

    *p_sem = (BSP_OS_SEM)(p_event);

#if (OS_EVENT_NAME_EN > 0)
    OSEventNameSet((OS_EVENT *)p_event,
                   (INT8U    *)p_sem_name,
                   (INT8U    *)&err);
#endif


    return (DEF_OK);
}


/*
*********************************************************************************************************
*                                     BSP_OS_SemWait()
*
* Description : Wait on a semaphore to become available
*
* Argument(s) : p_sem        Pointer to the sempahore handler.
*
*               dly_ms       delay in miliseconds to wait on the semaphore
*
* Return(s)   : error code return     DEF_OK       if the semaphore was acquire
*                                     DEF_FAIL     if the sempahore could not be acquire
*
* Caller(s)   : Application.
*
* Note(s)     : none.
*********************************************************************************************************
*/

CPU_BOOLEAN  BSP_OS_SemWait (BSP_OS_SEM *p_sem,
                             CPU_INT32U  dly_ms)
{
    CPU_INT08U  err;
    CPU_INT32U  dly_ticks;


    dly_ticks  = ((dly_ms * DEF_TIME_NBR_mS_PER_SEC) / OS_TICKS_PER_SEC);

    OSSemPend((OS_EVENT   *)*p_sem,
              (CPU_INT32U  )dly_ticks,
              (CPU_INT08U *)&err);

    if (err != OS_ERR_NONE) {
       return (DEF_FAIL);
    }

    return (DEF_OK);
}

/*
*********************************************************************************************************
*                                      BSP_OS_SemCreate()
*
* Description : Post a semaphore
*
* Argument(s) : p_sem                 Pointer to the Semaphore handler.
*
* Return(s)   : error code return     DEF_OK     if the semaphore was posted.
*                                     DEF_FAIL   if the sempahore could not be posted.
*
* Caller(s)   : Application.
*
* Note(s)     : none.
*********************************************************************************************************
*/

CPU_BOOLEAN  BSP_OS_SemPost (BSP_OS_SEM * p_sem)
{
    CPU_INT08U  err;


    err = OSSemPost((OS_EVENT *)*p_sem);

    if (err != OS_ERR_NONE) {
        return (DEF_FAIL);
    }

    return (DEF_OK);
}
