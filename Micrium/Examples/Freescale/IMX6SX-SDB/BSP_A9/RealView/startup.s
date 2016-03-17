;
;********************************************************************************************************
;                                    EXCEPTION VECTORS & STARTUP CODE
;
; File      : startup.s
; For       : Cortex A9 on the IMX6SX
; Toolchain : ARMCC
;
; Notes : none
;********************************************************************************************************
;

;********************************************************************************************************
;                                           MACROS AND DEFINIITIONS
;********************************************************************************************************

                                ; Mode, correspords to bits 0-5 in CPSR
MODE_BITS   EQU  0x1F           ; Bit mask for mode bits in CPSR
USR_MODE    EQU  0x10           ; User mode
FIQ_MODE    EQU  0x11           ; Fast Interrupt Request mode
IRQ_MODE    EQU  0x12           ; Interrupt Request mode
SVC_MODE    EQU  0x13           ; Supervisor mode
ABT_MODE    EQU  0x17           ; Abort mode
UND_MODE    EQU  0x1B           ; Undefined Instruction mode
SYS_MODE    EQU  0x1F           ; System mode


                                ; Control register C1
CTRL_C1_M    EQU  0x0001
CTRL_C1_A    EQU  0x0002
CTRL_C1_C    EQU  0x0004
CTRL_C1_W    EQU  0x0008
CTRL_C1_S    EQU  0x0100
CTRL_C1_R    EQU  0x0200
CTRL_C1_Z    EQU  0x0800
CTRL_C1_I    EQU  0x1000
CTRL_C1_V    EQU  0x2000
CTRL_C1_RR   EQU  0x4000
CTRL_C1_TRE  EQU  0x10000000

                               ; Auxiliary control register C1
AUX_C1_FW    EQU  0x0001
AUX_C1_SMP   EQU  0x0040


                               ; Level 1 page table descriptor templates
TTB_ENTRY_SUPERSEC_FAULT  EQU  0x50006
TTB_ENTRY_SUPERSEC_STRONG EQU  0x50C02
TTB_ENTRY_SUPERSEC_DEV  EQU    0x50C06
TTB_ENTRY_SUPERSEC_NORM EQU    0x55C06


    IMPORT OS_CPU_ARM_ExceptUndefInstrHndlr
    IMPORT OS_CPU_ARM_ExceptSwiHndlr
    IMPORT OS_CPU_ARM_ExceptPrefetchAbortHndlr
    IMPORT OS_CPU_ARM_ExceptDataAbortHndlr
    IMPORT OS_CPU_ARM_ExceptIrqHndlr
    IMPORT OS_CPU_ARM_ExceptFiqHndlr


    IMPORT BSP_DCacheInvalidateAll
    IMPORT BSP_SCUEn
    IMPORT BSP_SCUInvalidateAll



    PRESERVE8

    AREA  StartUp,CODE,READONLY

    ENTRY

    EXPORT Start

Start


Vectors

    LDR     PC, [PC,#24]    ; Absolute jump can reach 4 GByte
    LDR     PC, [PC,#24]    ; Branch to undef_handler
    LDR     PC, [PC,#24]    ; Branch to swi_handler
    LDR     PC, [PC,#24]    ; Branch to prefetch_handler
    LDR     PC, [PC,#24]    ; Branch to data_handler
    DCD     0
    LDR     PC, [PC,#24]    ; Branch to irq_handler
    LDR     PC, [PC,#24]    ; Branch to fiq_handler


    DCD    Reset_Handler
    DCD    OS_CPU_ARM_ExceptUndefInstrHndlr
    DCD    OS_CPU_ARM_ExceptSwiHndlr
    DCD    OS_CPU_ARM_ExceptPrefetchAbortHndlr
    DCD    OS_CPU_ARM_ExceptDataAbortHndlr
    DCD    0
    DCD    OS_CPU_ARM_ExceptIrqHndlr
    DCD    OS_CPU_ARM_ExceptFiqHndlr


    EXPORT Reset_Handler
Reset_Handler   FUNCTION {}

    MRC     p15, 0, r0, c1, c0, 0                    ; Read control register
    BIC     r0, r0, #CTRL_C1_M                       ; Disable MMU
    BIC     r0, r0, #CTRL_C1_C                       ; Disable data cache
    BIC     r0, r0, #CTRL_C1_Z                       ; Disable branch prediction
    BIC     r0, r0, #CTRL_C1_I                       ; Disable instruction cache
    BIC     r0, r0, #CTRL_C1_V                       ; Set low vectors mode
    BIC     r0, r0, #CTRL_C1_TRE                     ; Disable TEX remap
    MCR     p15, 0, r0, c1, c0, 0                    ; Write control register

    DSB

    IMPORT  BSP_L2C310Dis
    BL      BSP_L2C310Dis                            ; Dis. L2C cache controller if it was left enabled earlier

    IMPORT  ||Image$$IRQ_STACK$$ZI$$Limit||
    MRS     r0, cpsr
    BIC     r0, r0, #MODE_BITS                       ; Clear the mode bits
    ORR     r0, r0, #IRQ_MODE                        ; Set IRQ mode bits
    MSR     cpsr_c, r0                               ; Change the mode
    LDR     sp, =||Image$$IRQ_STACK$$ZI$$Limit||     ; End of IRQ_STACK


    IMPORT  ||Image$$FIQ_STACK$$ZI$$Limit||
    BIC     r0, r0, #MODE_BITS                       ; Clear the mode bits
    ORR     r0, r0, #FIQ_MODE                        ; Set FIQ mode bits
    MSR     cpsr_c, r0                               ; Change the mode
    LDR     sp, =||Image$$FIQ_STACK$$ZI$$Limit||     ; End of FIQ_STACK


    IMPORT  ||Image$$ABT_STACK$$ZI$$Limit||
    BIC     r0, r0, #MODE_BITS                       ; Clear the mode bits
    ORR     r0, r0, #ABT_MODE                        ; Set ABT mode bits
    MSR     cpsr_c, r0                               ; Change the mode
    LDR     sp, =||Image$$ABT_STACK$$ZI$$Limit||     ; End of ABT_STACK


    IMPORT  ||Image$$UND_STACK$$ZI$$Limit||
    BIC     r0, r0, #MODE_BITS                       ; Clear the mode bits
    ORR     r0, r0, #UND_MODE                        ; Set UND mode bits
    MSR     cpsr_c, r0                               ; Change the mode
    LDR     sp, =||Image$$UND_STACK$$ZI$$Limit||     ; End of UND_STACK

    IMPORT  ||Image$$SYS_STACK$$ZI$$Limit||
    BIC     r0, r0, #MODE_BITS                       ; Clear the mode bits
    ORR     r0, r0, #SYS_MODE                        ; Set SYS mode bits
    MSR     cpsr_c, r0                               ; Change the mode
    LDR     sp, =||Image$$SYS_STACK$$ZI$$Limit||     ; End of SYS_STACK

    IMPORT  ||Image$$SVC_STACK$$ZI$$Limit||
    MRS     r0, cpsr                                 ; Original PSR value
    BIC     r0, r0, #MODE_BITS                       ; Clear the mode bits
    ORR     r0, r0, #SVC_MODE                        ; Set SVC mode bits
    MSR     cpsr_c, r0                               ; Change the mode
    LDR     sp, =||Image$$SVC_STACK$$ZI$$Limit||     ; End of SVC_STACK


    LDR     r0, =Vectors                             ; Set vector table location
    MCR     p15, 0, r0, c12, c0, 0
    MRC     p15, 0, r0, c1, c0, 0
    BIC     r0, r0, #CTRL_C1_V                       ; Disable high vector
    MCR     p15, 0, r0, c1, c0, 0



    MOV     r0, #0x0
    MCR     p15, 0, r0, c7, c5, 6                    ; Invalidate branch predictor

    MOV     r0, #0x0
    MCR     p15, 0, r0, c8, c7, 0                    ; Invalidate TLB

    MOV     r0, #0
    MCR     p15, 0, r0, c7, c5, 0                    ; Invalidate instruction cache


    BL BSP_DCacheInvalidateAll

                                                     ; Set domain access
    MRC     p15, 0, r0, c3, c0, 0
    LDR     r0, =0x55555555
    MCR     p15, 0, r0, c3, c0, 0

                                                     ; Set access permission for VFP & NEON
    MRC     p15, 0, r0, c1, c0, 2
    ORR     r0, r0, #(0xF << 20)
    MCR     p15, 0, r0, c1, c0, 2
    ISB

                                                     ; Start the VFP and NEON engine
    MOV     r0, #0x40000000
    VMSR    FPEXC, r0



; MMU CONFIGURATION

                                                     ; Setup page table.
    IMPORT ||Image$$PAGE_TABLE$$ZI$$Base||
    LDR     r0, =||Image$$PAGE_TABLE$$ZI$$Base||     ; Load page table base address



    IMPORT ARMv7Attbl_SuperSecMap

    LDR     r4, =||Image$$PAGE_TABLE$$ZI$$Base||

                                                     ; Map the entire memory as device by default
    MOV     r0, r4
    MOV32   r1, #TTB_ENTRY_SUPERSEC_DEV
    MOV32   r2, #0x00000000
    MOV32   r3, #0x00000000
    BL      ARMv7Attbl_SuperSecMap


    MOV     r0, r4                                   ; Map DDR region as normal memory
    MOV32   r1, #TTB_ENTRY_SUPERSEC_NORM
    MOV32   r2, 0x80000000
    MOV32   r3, 0x20000000
    BL      ARMv7Attbl_SuperSecMap

                                                     ; Set L1 page table location
    MCR     p15, 0, r4, c2, c0, 0

    DSB


    MRC     p15,  0, r0, c1, c0, 0                   ; Read  control register
    ORR     r0,  r0, #CTRL_C1_M                      ; Enable MMU
    MCR     p15,  0, r0, c1, c0, 0                   ; Write control register

    DSB


                                                     ; Join SMP & enable maintenance broadcasts
    MRC     p15, 0, r0, c1, c0, 1
    ORR     r0, r0, #AUX_C1_SMP
    MCR     p15, 0, r0, c1, c0, 1

    DSB

    DSB

    WFE


    IMPORT  __main

    LDR     r12,=__main                              ; Jump to main
    BX      r12

    ENDFUNC


    END



