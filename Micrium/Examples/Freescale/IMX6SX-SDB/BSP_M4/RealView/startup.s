;
;********************************************************************************************************
;                                            STARTUP CODE
;
; File      : startup.s
; For       : Cortex M4 on the i.MX6 SoloX
; Toolchain : ARMCC
;
;********************************************************************************************************
;

    AREA  StartUp,CODE,READONLY

    EXPORT Start

Start

    CPSID   I

    IMPORT ||Image$$STACK$$ZI$$Limit||
    MOV32  r0, ||Image$$STACK$$ZI$$Limit||           ; Load stack pointer
    MOV    sp, r0

    IMPORT VectorTable
    MOV32  r0, VectorTable
    MOV32  r1, #0xE000ED08                           ; Set vector location
    STR    R0, [R1]

    MOV32   R0, #0xE000ED88                          ; Enable CP10,CP11
    LDR     R1,[R0]
    ORR     R1,R1,#(0xF << 20)
    STR     R1,[R0]

    MOV32   R0, #0xE000EF34
    LDR     R1, [R0]
    BIC     R1, R1,#0x80000000                       ; Disable FP registers save
    BIC     R1, R1,#0x40000000                       ; Disable lazy stacking
    STR     R1,[R0]

    IMPORT  __main
    MOV32   r12, __main                              ; Jump to main
    BX      r12

    END
