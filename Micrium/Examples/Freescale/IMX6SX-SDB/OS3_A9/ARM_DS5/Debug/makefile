################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := clean

# All of the sources participating in the build are defined here
-include sources.mk
-include uCOS-III/Source/subdir.mk
-include uCOS-III/Ports/ARM-Cortex-A/Generic/RealView/subdir.mk
-include uC-LIB/subdir.mk
-include uC-CPU/Cache/ARM/armv7_generic_l1_l2c310_l2/RealView/subdir.mk
-include uC-CPU/Cache/ARM/armv7_generic_l1_l2c310_l2/subdir.mk
-include uC-CPU/ARM-Cortex-A/RealView/subdir.mk
-include uC-CPU/subdir.mk
-include Freescale/IMX6SX-SDB/BSP_A9/uCOS-III/subdir.mk
-include Freescale/IMX6SX-SDB/BSP_A9/RealView/subdir.mk
-include Freescale/IMX6SX-SDB/BSP_A9/subdir.mk
-include APP/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C++_DEPS)),)
-include $(C++_DEPS)
endif
ifneq ($(strip $(ASM_DEPS)),)
-include $(ASM_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
ifneq ($(strip $(CC_DEPS)),)
-include $(CC_DEPS)
endif
ifneq ($(strip $(ASM_UPPER_DEPS)),)
-include $(ASM_UPPER_DEPS)
endif
ifneq ($(strip $(CPP_DEPS)),)
-include $(CPP_DEPS)
endif
ifneq ($(strip $(S_DEPS)),)
-include $(S_DEPS)
endif
ifneq ($(strip $(CXX_DEPS)),)
-include $(CXX_DEPS)
endif
ifneq ($(strip $(C_UPPER_DEPS)),)
-include $(C_UPPER_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 

# All Target
all: IMX6SX-SDB-OS3_A9.axf

# Tool invocations
IMX6SX-SDB-OS3_A9.axf: $(OBJS) C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9/ARM_DS5/../scatter.scat $(USER_OBJS) $(LIBS)
	@echo 'Building target: $@'
	@echo 'Invoking: ARM Linker 5'
	armlink --cpu=Cortex-A9 --entry=Start --scatter=""C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_A9/ARM_DS5/../scatter.scat"" --info=sizes -o "IMX6SX-SDB-OS3_A9.axf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(OBJS) $(C++_DEPS) $(ASM_DEPS) $(C_DEPS) $(CC_DEPS) $(ASM_UPPER_DEPS) $(CPP_DEPS) $(S_DEPS) $(EXECUTABLES) $(CXX_DEPS) $(C_UPPER_DEPS) $(S_UPPER_DEPS) IMX6SX-SDB-OS3_A9.axf 
	-@echo ' '

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets
