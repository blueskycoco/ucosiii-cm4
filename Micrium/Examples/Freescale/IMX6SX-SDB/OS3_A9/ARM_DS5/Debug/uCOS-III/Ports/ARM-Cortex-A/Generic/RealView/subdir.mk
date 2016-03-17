################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/Users/jonathan/Desktop/imx6solox_final/OS3/Software/uCOS-III/Ports/ARM-Cortex-A/Generic/RealView/os_cpu_c.c 

S_SRCS += \
C:/Users/jonathan/Desktop/imx6solox_final/OS3/Software/uCOS-III/Ports/ARM-Cortex-A/Generic/RealView/os_cpu_a_vfp-d32.s 

OBJS += \
./uCOS-III/Ports/ARM-Cortex-A/Generic/RealView/os_cpu_a_vfp-d32.o \
./uCOS-III/Ports/ARM-Cortex-A/Generic/RealView/os_cpu_c.o 

C_DEPS += \
./uCOS-III/Ports/ARM-Cortex-A/Generic/RealView/os_cpu_c.d 

S_DEPS += \
./uCOS-III/Ports/ARM-Cortex-A/Generic/RealView/os_cpu_a_vfp-d32.d 


# Each subdirectory must supply rules for building sources it contributes
uCOS-III/Ports/ARM-Cortex-A/Generic/RealView/os_cpu_a_vfp-d32.o: C:/Users/jonathan/Desktop/imx6solox_final/OS3/Software/uCOS-III/Ports/ARM-Cortex-A/Generic/RealView/os_cpu_a_vfp-d32.s
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Assembler 5'
	armasm --cpu=Cortex-A9 --no_unaligned_access -g --md --depend_format=unix_escaped -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

uCOS-III/Ports/ARM-Cortex-A/Generic/RealView/os_cpu_c.o: C:/Users/jonathan/Desktop/imx6solox_final/OS3/Software/uCOS-III/Ports/ARM-Cortex-A/Generic/RealView/os_cpu_c.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM C Compiler 5'
	armcc --cpu=Cortex-A9 --no_unaligned_access -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9/ARM_DS5/../" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9/ARM_DS5/../../BSP_A9" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9/ARM_DS5/../../BSP_A9/uCOS-III" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9/ARM_DS5/../../../../../Software/uC-CPU" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9/ARM_DS5/../../../../../Software/uC-CPU/ARM-Cortex-A/RealView" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9/ARM_DS5/../../../../../Software/uC-LIB" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9/ARM_DS5/../../../../../Software/uCOS-III" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9/ARM_DS5/../../../../../Software/uCOS-III/Source" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9/ARM_DS5/../../../../../Software/uCOS-III/Ports/ARM-Cortex-A/Generic/RealView" -O0 -g --md --depend_format=unix_escaped -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


