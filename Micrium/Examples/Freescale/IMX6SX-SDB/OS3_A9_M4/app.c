/*
*********************************************************************************************************
*                                            EXAMPLE CODE
*
*                          (c) Copyright 2009-2015; Micrium, Inc.; Weston, FL
*
*               All rights reserved.  Protected by international copyright laws.
*
*               Please feel free to use any application code labeled as 'EXAMPLE CODE' in
*               your application products.  Example code may be used as is, in whole or in
*               part, or may be used as a reference only.
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
*                                          APPLICATION CODE
*
*                                             IMX6SX-SDB
*
* Filename      : app.c
* Version       : V1.00
* Programmer(s) : JBL
*********************************************************************************************************
* Note(s)       : none.
*********************************************************************************************************
*/


/*
*********************************************************************************************************
*                                            INCLUDE FILES
*********************************************************************************************************
*/


#include  <stdio.h>
#include  <string.h>

#include  <app_cfg.h>
#include  <lib_mem.h>

#include  <bsp.h>
#include  <bsp_int.h>
#include  <bsp_os.h>
#include  <bsp_cache.h>
#include  <bsp_ser.h>

#include  <cpu.h>
#include  <cpu_core.h>
#include  <cpu_cache.h>

#include  <os.h>


/*
*********************************************************************************************************
*                                       LOCAL GLOBAL VARIABLES
*********************************************************************************************************
*/

static  OS_TCB        AppTaskStartTCB;
static  CPU_STK       AppTaskStartStk[4096u];


/*
*********************************************************************************************************
*                                      LOCAL FUNCTION PROTOTYPES
*********************************************************************************************************
*/

static  void  AppTaskStart              (void        *p_arg);


/*
*********************************************************************************************************
*                                               main()
*
* Description : Entry point for C code.
*
* Arguments   : none.
*
* Returns     : none.
*********************************************************************************************************
*/

int main ()
{
    OS_ERR  os_err;

    BSP_BranchPredictorEn();                                    /* Enable branch prediction.                            */
    BSP_L2C310Config();                                         /* Configure the L2 cache controller.                   */
    BSP_CachesEn();                                             /* Enable L1 I&D caches + L2 unified cache.             */

    CPU_Init();

    Mem_Init();

    BSP_Init();

    OSInit(&os_err);


    OSTaskCreate((OS_TCB     *)&AppTaskStartTCB,                /* Create the start task                                    */
                 (CPU_CHAR   *)"App Task Start",
                 (OS_TASK_PTR ) AppTaskStart,
                 (void       *) 0,
                 (OS_PRIO     ) 5,
                 (CPU_STK    *)&AppTaskStartStk[0],
                 (CPU_STK     )(4096u / 10u),
                 (CPU_STK_SIZE) 4096u,
                 (OS_MSG_QTY  ) 0,
                 (OS_TICK     ) 0,
                 (void       *) 0,
                 (OS_OPT      )(OS_OPT_TASK_STK_CHK | OS_OPT_TASK_STK_CLR),
                 (OS_ERR     *)&os_err);


    if(os_err != OS_ERR_NONE) {
    }


    OSStart(&os_err);


    if(os_err != OS_ERR_NONE) {
    }


    return 0;
}


/*
*********************************************************************************************************
*                                           App_TaskStart()
*
* Description : Startup task example code.
*
* Arguments   : p_arg       Argument passed by 'OSTaskCreate()'.
*
* Returns     : none.
*
* Created by  : main().
*
* Notes       : (1) The ticker MUST be initialised AFTER multitasking has started.
*********************************************************************************************************
*/

#define  SRC  (*((CPU_REG32 *)0x20D8000))                       /* System reset control.                                */

static  void  AppTaskStart (void *p_arg)
{
    OS_ERR       os_err;

    BSP_OS_TmrTickInit(OS_CFG_TICK_RATE_HZ);

    BSP_Ser_Init();

    APP_TRACE_INFO(("\r\n"));
    APP_TRACE_INFO(("Application start on the Cortex-A9!\r\n"));


    /* Enable and start the Cortex-M4                       */
    APP_TRACE_INFO(("Starting the Cortex-M4\r\n"));
    DEF_BIT_SET(SRC, DEF_BIT_22);
    CPU_MB();
    DEF_BIT_CLR(SRC, DEF_BIT_04);
    CPU_MB();

    for(;;) {
        OSTimeDlyHMSM((CPU_INT16U) 0,
                      (CPU_INT16U) 0,
                      (CPU_INT16U) 5,
                      (CPU_INT32U) 0,
                      (OS_OPT    ) OS_OPT_TIME_HMSM_STRICT,
                      (OS_ERR   *)&os_err);
        APP_TRACE_INFO(("Periodic output from the Cortex-A9\r\n"));
    }

}
