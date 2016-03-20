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

	.extern VectorTable
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
    ldr sp, =__SRAM_POOL_START                        @ set stack pointer.
                                            @ Call the application's entry point.
                                            
    LDR.W  r0, =VectorTable
    LDR.W  r1, =#0xE000ED08                           @ Set vector location
    STR    R0, [R1]

    LDR.W   R0, =#0xE000ED88                          @ Enable CP10,CP11
    LDR     R1,[R0]
    ORR     R1,R1,#(0xF << 20)
    STR     R1,[R0]

    LDR.W   R0, =#0xE000EF34
    LDR     R1, [R0]
    BIC     R1, R1,#0x80000000                       @ Disable FP registers save
    BIC     R1, R1,#0x40000000                       @ Disable lazy stacking
    STR     R1,[R0]
    bl  main
    bx  lr

.size	Reset_Handler, .-Reset_Handler

