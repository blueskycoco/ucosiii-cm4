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

#include  <cpu.h>
#include  <lib_mem.h>
#include  <Source/os.h>
#include  <os_cfg_app.h>

#include  <app_cfg.h>
#include  <bsp.h>
#include  <bsp_ser.h>

/*
*********************************************************************************************************
*                                       LOCAL GLOBAL VARIABLES
*********************************************************************************************************
*/

static  OS_TCB        AppTaskStartTCB;
static  CPU_STK       AppTaskStartStk[1024u];


/*
*********************************************************************************************************
*                                      LOCAL FUNCTION PROTOTYPES
*********************************************************************************************************
*/

static void AppTaskStart(void *p_arg);


int main ()
{
    OS_ERR  os_err;

    BSP_Init();

    CPU_Init();

    Mem_Init();

    OSInit(&os_err);

    OSTaskCreate((OS_TCB     *)&AppTaskStartTCB,
                 (CPU_CHAR   *)"App Task Start",
                 (OS_TASK_PTR ) AppTaskStart,
                 (void       *) 0,
                 (OS_PRIO     ) 5,
                 (CPU_STK    *)&AppTaskStartStk[0],
                 (CPU_STK     )(1024u / 10u),
                 (CPU_STK_SIZE) 1024u,
                 (OS_MSG_QTY  ) 0,
                 (OS_TICK     ) 0,
                 (void       *) 0,
                 (OS_OPT      )(OS_OPT_TASK_STK_CHK | OS_OPT_TASK_STK_CLR),
                 (OS_ERR     *)&os_err);

    OSStart(&os_err);

    return 0;
}


/*
*********************************************************************************************************
*                                             AppTaskStart()
*
* Description : Example task.
*
* Arguments   : none.
*
* Returns     : none.
*
* Note(s)     : none.
*********************************************************************************************************
*/

static void AppTaskStart(void *p_arg)
{
    CPU_INT32U cpu_clk_freq;
    CPU_INT32U cnts;
    OS_ERR os_err;

    cpu_clk_freq = M4_FREQ;
    cnts = cpu_clk_freq / (CPU_INT32U) OS_CFG_TICK_RATE_HZ;
    OS_CPU_SysTickInit(cnts);

    BSP_Ser_Init();

    APP_TRACE_INFO(("Application start on the Cortex-M4!\r\n"));


    for(;;) {
        OSTimeDlyHMSM(0, 0, 5, 0, OS_OPT_TIME_HMSM_STRICT, &os_err);
        APP_TRACE_INFO(("Periodic output from the Cortex-M4\r\n"));
    }
}
