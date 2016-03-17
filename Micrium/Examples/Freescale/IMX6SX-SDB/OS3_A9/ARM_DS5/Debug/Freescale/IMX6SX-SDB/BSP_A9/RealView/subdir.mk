################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/BSP_A9/RealView/armv7a_tthelp.s \
C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/BSP_A9/RealView/bsp_cache.s \
C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/BSP_A9/RealView/startup.s 

OBJS += \
./Freescale/IMX6SX-SDB/BSP_A9/RealView/armv7a_tthelp.o \
./Freescale/IMX6SX-SDB/BSP_A9/RealView/bsp_cache.o \
./Freescale/IMX6SX-SDB/BSP_A9/RealView/startup.o 

S_DEPS += \
./Freescale/IMX6SX-SDB/BSP_A9/RealView/armv7a_tthelp.d \
./Freescale/IMX6SX-SDB/BSP_A9/RealView/bsp_cache.d \
./Freescale/IMX6SX-SDB/BSP_A9/RealView/startup.d 


# Each subdirectory must supply rules for building sources it contributes
Freescale/IMX6SX-SDB/BSP_A9/RealView/armv7a_tthelp.o: C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/BSP_A9/RealView/armv7a_tthelp.s
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Assembler 5'
	armasm --cpu=Cortex-A9 --no_unaligned_access -g --md --depend_format=unix_escaped -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

Freescale/IMX6SX-SDB/BSP_A9/RealView/bsp_cache.o: C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/BSP_A9/RealView/bsp_cache.s
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Assembler 5'
	armasm --cpu=Cortex-A9 --no_unaligned_access -g --md --depend_format=unix_escaped -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

Freescale/IMX6SX-SDB/BSP_A9/RealView/startup.o: C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/BSP_A9/RealView/startup.s
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Assembler 5'
	armasm --cpu=Cortex-A9 --no_unaligned_access -g --md --depend_format=unix_escaped -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


