/*
************************************************************************************************************************
*                                                      uC/OS-III
*                                                 The Real-Time Kernel
*
*                                  (c) Copyright 2009-2015; Micrium, Inc.; Weston, FL
*                           All rights reserved.  Protected by international copyright laws.
*
*                                                 PRIORITY MANAGEMENT
*
* File    : OS_PRIO.C
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
const  CPU_CHAR  *os_prio__c = "$Id: $";
#endif


CPU_DATA   OSPrioTbl[OS_PRIO_TBL_SIZE];                         /* Declare the array local to this file to allow for  ...*/
                                                                /* ... optimization.  In other words, this allows the ...*/
                                                                /* ... table to be located in fast memory                */

/*
************************************************************************************************************************
*                                               INITIALIZE THE PRIORITY LIST
*
* Description: This function is called by uC/OS-III to initialize the list of ready priorities.
*
* Arguments  : none
*
* Returns    : none
*
* Note       : This function is INTERNAL to uC/OS-III and your application should not call it.
************************************************************************************************************************
*/

void  OS_PrioInit (void)
{
    CPU_DATA  i;


                                                                /* Clear the bitmap table ... no task is ready          */
    for (i = 0u; i < OS_PRIO_TBL_SIZE; i++) {
         OSPrioTbl[i] = 0u;
    }

#if (OS_CFG_TASK_IDLE_EN == DEF_DISABLED)
    OS_PrioInsert ((OS_CFG_PRIO_MAX - 1u));                     /* Insert what would be the idle task                   */
#endif
}

/*
************************************************************************************************************************
*                                           GET HIGHEST PRIORITY TASK WAITING
*
* Description: This function is called by other uC/OS-III services to determine the highest priority task
*              waiting on the event.
*
* Arguments  : none
*
* Returns    : The priority of the Highest Priority Task (HPT) waiting for the event
*
* Note(s)    : 1) This function is INTERNAL to uC/OS-III and your application MUST NOT call it.
************************************************************************************************************************
*/

OS_PRIO  OS_PrioGetHighest (void)
{
    CPU_DATA  *p_tbl;
    OS_PRIO    prio;


    prio  = 0u;
    p_tbl = &OSPrioTbl[0];
#if (OS_CFG_PRIO_MAX > DEF_INT_CPU_NBR_BITS)
    while (*p_tbl == 0u) {                                      /* Search the bitmap table for the highest priority     */
        prio += DEF_INT_CPU_NBR_BITS;                           /* Compute the step of each CPU_DATA entry              */
        p_tbl++;
    }
#endif
    prio += (OS_PRIO)CPU_CntLeadZeros(*p_tbl);                  /* Find the position of the first bit set at the entry  */

    return (prio);
}

/*
************************************************************************************************************************
*                                                  INSERT PRIORITY
*
* Description: This function is called to insert a priority in the priority table.
*
* Arguments  : prio     is the priority to insert
*
* Returns    : none
*
* Note(s)    : 1) This function is INTERNAL to uC/OS-III and your application MUST NOT call it.
************************************************************************************************************************
*/

void  OS_PrioInsert (OS_PRIO  prio)
{
    CPU_DATA  bit;
    CPU_DATA  bit_nbr;
    OS_PRIO   ix;

#if (OS_CFG_PRIO_MAX > DEF_INT_CPU_NBR_BITS)
    ix             = prio / DEF_INT_CPU_NBR_BITS;
    bit_nbr        = (CPU_DATA)prio & (DEF_INT_CPU_NBR_BITS - 1u);
#else
    ix             = 0u;
    bit_nbr        = prio;
#endif
    bit            = 1u;
    bit          <<= (DEF_INT_CPU_NBR_BITS - 1u) - bit_nbr;
    OSPrioTbl[ix] |= bit;
}

/*
************************************************************************************************************************
*                                                   REMOVE PRIORITY
*
* Description: This function is called to remove a priority in the priority table.
*
* Arguments  : prio     is the priority to remove
*
* Returns    : none
*
* Note(s)    : 1) This function is INTERNAL to uC/OS-III and your application MUST NOT call it.
************************************************************************************************************************
*/

void  OS_PrioRemove (OS_PRIO  prio)
{
    CPU_DATA  bit;
    CPU_DATA  bit_nbr;
    OS_PRIO   ix;

#if (OS_CFG_PRIO_MAX > DEF_INT_CPU_NBR_BITS)
    ix             = prio / DEF_INT_CPU_NBR_BITS;
    bit_nbr        = (CPU_DATA)prio & (DEF_INT_CPU_NBR_BITS - 1u);
#else
    ix             = 0u;
    bit_nbr        = prio;
#endif
    bit            = 1u;
    bit          <<= (DEF_INT_CPU_NBR_BITS - 1u) - bit_nbr;
    OSPrioTbl[ix] &= ~bit;
}
