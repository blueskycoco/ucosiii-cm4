################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/Users/jonathan/Desktop/imx6solox_final/OS3/Software/uC-CPU/ARM-Cortex-M4/RealView/cpu_c.c 

ASM_SRCS += \
C:/Users/jonathan/Desktop/imx6solox_final/OS3/Software/uC-CPU/ARM-Cortex-M4/RealView/cpu_a.asm 

OBJS += \
./uC-CPU/ARM-Cortex-M4/RealView/cpu_a.o \
./uC-CPU/ARM-Cortex-M4/RealView/cpu_c.o 

ASM_DEPS += \
./uC-CPU/ARM-Cortex-M4/RealView/cpu_a.d 

C_DEPS += \
./uC-CPU/ARM-Cortex-M4/RealView/cpu_c.d 


# Each subdirectory must supply rules for building sources it contributes
uC-CPU/ARM-Cortex-M4/RealView/cpu_a.o: C:/Users/jonathan/Desktop/imx6solox_final/OS3/Software/uC-CPU/ARM-Cortex-M4/RealView/cpu_a.asm
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Assembler 5'
	armasm --cpu=Cortex-M4.fp --no_unaligned_access -g --md --depend_format=unix_escaped -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

uC-CPU/ARM-Cortex-M4/RealView/cpu_c.o: C:/Users/jonathan/Desktop/imx6solox_final/OS3/Software/uC-CPU/ARM-Cortex-M4/RealView/cpu_c.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM C Compiler 5'
	armcc --cpu=Cortex-M4.fp --no_unaligned_access -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_M4/ARM_DS5/../" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_M4/ARM_DS5/../../BSP_M4" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_M4/ARM_DS5/../../BSP_M4/uCOS-III" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_M4/ARM_DS5/../../../../../Software/uC-CPU" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_M4/ARM_DS5/../../../../../Software/uC-CPU/ARM-Cortex-M4/RealView" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_M4/ARM_DS5/../../../../../Software/uC-LIB" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_M4/ARM_DS5/../../../../../Software/uCOS-III" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_M4/ARM_DS5/../../../../../Software/uCOS-III/Source" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_M4/ARM_DS5/../../../../../Software/uCOS-III/Ports/ARM-Cortex-M4/Generic/RealView" -O0 -g --md --depend_format=unix_escaped -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


