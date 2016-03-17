################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/Users/jonathan/Desktop/imx6solox_final/OS3/Software/uC-CPU/Cache/ARM/armv7_generic_l1_l2c310_l2/cpu_cache_armv7_generic_l1_l2c310_l2.c 

OBJS += \
./uC-CPU/Cache/ARM/armv7_generic_l1_l2c310_l2/cpu_cache_armv7_generic_l1_l2c310_l2.o 

C_DEPS += \
./uC-CPU/Cache/ARM/armv7_generic_l1_l2c310_l2/cpu_cache_armv7_generic_l1_l2c310_l2.d 


# Each subdirectory must supply rules for building sources it contributes
uC-CPU/Cache/ARM/armv7_generic_l1_l2c310_l2/cpu_cache_armv7_generic_l1_l2c310_l2.o: C:/Users/jonathan/Desktop/imx6solox_final/OS3/Software/uC-CPU/Cache/ARM/armv7_generic_l1_l2c310_l2/cpu_cache_armv7_generic_l1_l2c310_l2.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM C Compiler 5'
	armcc --cpu=Cortex-A9 --no_unaligned_access -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9/ARM_DS5/../" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9/ARM_DS5/../../BSP_A9" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9/ARM_DS5/../../BSP_A9/uCOS-III" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9/ARM_DS5/../../../../../Software/uC-CPU" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9/ARM_DS5/../../../../../Software/uC-CPU/ARM-Cortex-A/RealView" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9/ARM_DS5/../../../../../Software/uC-LIB" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9/ARM_DS5/../../../../../Software/uCOS-III" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9/ARM_DS5/../../../../../Software/uCOS-III/Source" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9/ARM_DS5/../../../../../Software/uCOS-III/Ports/ARM-Cortex-A/Generic/RealView" -O0 -g --md --depend_format=unix_escaped -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


