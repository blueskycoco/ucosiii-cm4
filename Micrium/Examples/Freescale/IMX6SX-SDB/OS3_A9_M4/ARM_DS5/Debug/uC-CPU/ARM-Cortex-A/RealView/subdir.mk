################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
C:/Users/jonathan/Desktop/imx6solox_final/OS3/Software/uC-CPU/ARM-Cortex-A/RealView/cpu_a.s 

OBJS += \
./uC-CPU/ARM-Cortex-A/RealView/cpu_a.o 

S_DEPS += \
./uC-CPU/ARM-Cortex-A/RealView/cpu_a.d 


# Each subdirectory must supply rules for building sources it contributes
uC-CPU/ARM-Cortex-A/RealView/cpu_a.o: C:/Users/jonathan/Desktop/imx6solox_final/OS3/Software/uC-CPU/ARM-Cortex-A/RealView/cpu_a.s
	@echo 'Building file: $<'
	@echo 'Invoking: ARM Assembler 5'
	armasm --cpu=Cortex-A9 --no_unaligned_access -g --md --depend_format=unix_escaped -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


