@*
@********************************************************************************************************
@                                    EXCEPTION VECTORS & STARTUP CODE
@
@ File      : startup.s
@ For       : ARMv7M Cortex-M4
@ Mode      : Thumb2
@ Toolchain : Atollic TrueSTUDIO(R)
@ Notes     : This module performs:
@                 - Set the initial SP
@                 - Set the initial PC == Reset_Handler,
@                 - Set the vector table entries with the exceptions ISR address
@                 - Branches to main in the C library (which eventually
@                   calls main()).
@              After Reset the Cortex-M4 processor is in Thread mode,
@              priority is Privileged, and the Stack is set to Main.
@********************************************************************************************************
@


@********************************************************************************************************
@                                      CODE GENERATION DIRECTIVES
@********************************************************************************************************
    .syntax unified
    .cpu cortex-m4
    .fpu softvfp
    .thumb


@********************************************************************************************************
@                                           PUBLIC FUNCTIONS
@********************************************************************************************************

    .global  g_pfnVectors


@********************************************************************************************************
@                                       LINKER SCRIPT DEFINITIONS
@********************************************************************************************************

    .word  _sidata                          @ start addr for the init values of the .data section.
    .word  _sdata                           @ start addr for the .data section.
    .word  _edata                           @ end address for the .data section.
    .word  _sbss                            @ start address for the .bss section.
    .word  _ebss                            @ end address for the .bss section.


@********************************************************************************************************
@                                               EQUATES
@********************************************************************************************************


@********************************************************************************************************
@                                      void Reset_Handler (void)
@
@ Note(s) : 1) This code gets called after a reset event.
@
@           2) Reset_Handler() MUST:
@              a) Copy .data section from ROM to RAM.
@              b) Clear .bss section (Zero init).
@              c) Call low level initialzation routine.
@              d) Run static constructors.
@              e) Enter main.
@              f) Loop forever if returning from main.
@********************************************************************************************************

    .section  .text.Reset_Handler
    .weak  Reset_Handler
    .type  Reset_Handler, %function
Reset_Handler:
    ldr sp, =_estack                        @ set stack pointer.

	MOVS	r0,	g_pfnVectors
	LDR.W	r1,	=0xE000ED08
	STR		r0,	[r1]
                                            @ Enable Floating Point Support at reset for FPU
    LDR.W   R0, =0xE000ED88                 @ Load address of CPACR register
    LDR     R1, [R0]                        @ Read value at CPACR
    ORR     R1,  R1, #(0xF <<20)            @ Set bits 20-23 to enable CP10 and CP11 coprocessors
                                            @ Write back the modified CPACR value
    STR     R1, [R0]                        @ Wait for store to complete
    DSB

                                            @ Disable automatic FP register content
                                            @ Disable lazy context switch
    LDR.W   R0, =0xE000EF34                 @ Load address to FPCCR register
    LDR     R1, [R0]
    BIC     R1,  R1, #(0x80000000)          @ Clear the LSPEN and ASPEN bits
    BIC     R1,  R1, #(0x40000000)          @ Clear the LSPEN and ASPEN bits
    STR     R1, [R0]
    ISB                                     @ Reset pipeline now the FPU is enabled
                                            @ Call the application's entry point.
    bl  main
    bx  lr

.size	Reset_Handler, .-Reset_Handler


@/*
@*********************************************************************************************************
@*                                  EXCEPTION / INTERRUPT VECTOR TABLE
@*
@* Note(s) : (1) The Cortex-M4 may have up to 256 external interrupts, which are the final entries in the
@*               vector table.  The STM32F4xx has 81 external interrupt vectors.
@*
@*           (2) Interrupts vector 2-13 are implemented in this file as infinite loop for debuging
@*               purposes only. The application might implement a recover procedure if it is needed.
@*
@*           (3) OS_CPU_PendSVHandler() and OS_CPU_SysTickHandler() are implemented in the generic OS
@*               port.
@*********************************************************************************************************
@*/

    .section  .isr_vector,"a",%progbits
    .type  g_pfnVectors, %object
    .size  g_pfnVectors, .-g_pfnVectors

                                            @ Vector Table Mapped to Address 0 at Reset
	.extern void  BSP_DefaultISRHandler
	.extern void  BSP_DefaultNMIHandler
	.extern void  BSP_DefaultHardFaultHandler
	.extern void  BSP_DefaultDebugMonHandler
	.extern void  BSP_DefaultMemManageFaultHandler
	.extern void  BSP_DefaultBusFaultHandler
	.extern void  BSP_DefaultUsageFaultHandler

g_pfnVectors:
                                                    @ Processor exception vectors
    .word     _estack                               @ Top of Stack
    .word     Reset_Handler                         @ Reset Handler
    .word     BSP_DefaultNMIHandler                           @ NMI Handler
    .word     BSP_DefaultHardFaultHandler                         @ Hard Fault Handler
    .word     BSP_DefaultDebugMonHandler                      @ MPU Fault Handler
    .word     BSP_DefaultMemManageFaultHandler                      @ Bus Fault Handler
    .word     BSP_DefaultBusFaultHandler                    @ Usage Fault Handler
    .word     BSP_DefaultUsageFaultHandler                      @ Reserved
    .word     App_Spurious_ISR                      @ Reserved
    .word     App_Spurious_ISR                      @ Reserved
    .word     App_Spurious_ISR                      @ Reserved
    .word     App_Spurious_ISR                      @ SVCall Handler
    .word     App_Spurious_ISR                      @ Debug Monitor Handler
    .word     App_Spurious_ISR                      @ Reserved
    .word     OS_CPU_PendSVHandler                  @ PendSV Handler
    .word     OS_CPU_SysTickHandler                 @ SysTick Handler

                                                    @  External Interrupts
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler
	.word BSP_DefaultISRHandler


@ Dummy Exception Handlers (infinite loops which can be modified)

    .section	.text.App_Spurious_ISR
App_Spurious_ISR:
	b	App_Spurious_ISR
	.size	App_Spurious_ISR, .-App_Spurious_ISR
