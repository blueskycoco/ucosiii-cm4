################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := clean

# All of the sources participating in the build are defined here
-include sources.mk
-include uCOS-III/Source/subdir.mk
-include uCOS-III/Ports/ARM-Cortex-M4/Generic/RealView/subdir.mk
-include uC-LIB/subdir.mk
-include uC-CPU/ARM-Cortex-M4/RealView/subdir.mk
-include uC-CPU/subdir.mk
-include Freescale/IMX6SX-SDB/BSP_M4/uCOS-III/subdir.mk
-include Freescale/IMX6SX-SDB/BSP_M4/RealView/subdir.mk
-include Freescale/IMX6SX-SDB/BSP_M4/subdir.mk
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
all: IMX6SX-SDB-OS3_M4.axf

# Tool invocations
IMX6SX-SDB-OS3_M4.axf: $(OBJS) C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_M4/ARM_DS5/..//scatter.scat $(USER_OBJS) $(LIBS)
	@echo 'Building target: $@'
	@echo 'Invoking: ARM Linker 5'
	armlink --cpu=Cortex-M4.fp --entry=Start --scatter=""C:/Users/jonathan/Desktop/imx6solox_final/OS3/Examples/Freescale/IMX6SX-SDB/OS3_M4/ARM_DS5/..//scatter.scat"" --no_remove --info=sizes -o "IMX6SX-SDB-OS3_M4.axf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '
	$(MAKE) --no-print-directory post-build

# Other Targets
clean:
	-$(RM) $(OBJS) $(C++_DEPS) $(ASM_DEPS) $(C_DEPS) $(CC_DEPS) $(ASM_UPPER_DEPS) $(CPP_DEPS) $(S_DEPS) $(EXECUTABLES) $(CXX_DEPS) $(C_UPPER_DEPS) $(S_UPPER_DEPS) IMX6SX-SDB-OS3_M4.axf 
	-@echo ' '

post-build:
	-@echo 'C Output'
	-fromelf --cadcombined IMX6SX-SDB-OS3_M4.axf --output IMX6SX-SDB-uCOSIII_M4.c
	-@echo ' '

.PHONY: all clean dependents
.SECONDARY: post-build

-include ../makefile.targets
