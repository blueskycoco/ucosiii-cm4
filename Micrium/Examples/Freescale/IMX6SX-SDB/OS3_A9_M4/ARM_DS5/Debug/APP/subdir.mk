################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_M4/ARM_DS5/Debug/IMX6SX-SDB-uCOSIII_M4.c \
C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9_M4/app.c 

OBJS += \
./APP/IMX6SX-SDB-uCOSIII_M4.o \
./APP/app.o 

C_DEPS += \
./APP/IMX6SX-SDB-uCOSIII_M4.d \
./APP/app.d 


# Each subdirectory must supply rules for building sources it contributes
APP/IMX6SX-SDB-uCOSIII_M4.o: C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_M4/ARM_DS5/Debug/IMX6SX-SDB-uCOSIII_M4.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM C Compiler 5'
	armcc --cpu=Cortex-A9 --no_unaligned_access -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9_M4/ARM_DS5/../" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9_M4/ARM_DS5/../../BSP_A9" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9_M4/ARM_DS5/../../BSP_A9/uCOS-III" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9_M4/ARM_DS5/../../../../../Software/uC-CPU" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9_M4/ARM_DS5/../../../../../Software/uC-CPU/ARM-Cortex-A/RealView" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9_M4/ARM_DS5/../../../../../Software/uC-LIB" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9_M4/ARM_DS5/../../../../../Software/uCOS-III" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9_M4/ARM_DS5/../../../../../Software/uCOS-III/Source" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9_M4/ARM_DS5/../../../../../Software/uCOS-III/Ports/ARM-Cortex-A/Generic/RealView" -O0 -g --md --depend_format=unix_escaped -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

APP/app.o: C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9_M4/app.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM C Compiler 5'
	armcc --cpu=Cortex-A9 --no_unaligned_access -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9_M4/ARM_DS5/../" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9_M4/ARM_DS5/../../BSP_A9" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9_M4/ARM_DS5/../../BSP_A9/uCOS-III" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9_M4/ARM_DS5/../../../../../Software/uC-CPU" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9_M4/ARM_DS5/../../../../../Software/uC-CPU/ARM-Cortex-A/RealView" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9_M4/ARM_DS5/../../../../../Software/uC-LIB" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9_M4/ARM_DS5/../../../../../Software/uCOS-III" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9_M4/ARM_DS5/../../../../../Software/uCOS-III/Source" -I"C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9_M4/ARM_DS5/../../../../../Software/uCOS-III/Ports/ARM-Cortex-A/Generic/RealView" -O0 -g --md --depend_format=unix_escaped -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


