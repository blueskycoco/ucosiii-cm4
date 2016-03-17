#******************************************************************************
#
# Makefile - Rules for building the uart_echo example.
#
# Copyright (c) 2013-2014 Texas Instruments Incorporated.  All rights reserved.
# Software License Agreement
# 
# Texas Instruments (TI) is supplying this software for use solely and
# exclusively on TI's microcontroller products. The software is owned by
# TI and/or its suppliers, and is protected under applicable copyright
# laws. You may not combine this software with "viral" open-source
# software in order to form a larger program.
# 
# THIS SOFTWARE IS PROVIDED "AS IS" AND WITH ALL FAULTS.
# NO WARRANTIES, WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT
# NOT LIMITED TO, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE. TI SHALL NOT, UNDER ANY
# CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR CONSEQUENTIAL
# DAMAGES, FOR ANY REASON WHATSOEVER.
# 
# This is part of revision 2.1.0.12573 of the EK-TM4C1294XL Firmware Package.
#
#******************************************************************************

#
# The base directory for TivaWare.
#
ROOT=.

#
# Include the common make definitions.
#
include ${ROOT}/makedefs

#
# Where to find header files that do not live in the source directory.
#
IPATH=./Micrium/Examples/Freescale/IMX6SX-SDB/OS3_M4
IPATH+=./Micrium/Software/uC-CPU
IPATH+=./Micrium/Software/uC-LIB
IPATH+=./Micrium/Software/uCOS-III
IPATH+=./Micrium/Software/uCOS-III/Source
IPATH+=./Micrium/Examples/Freescale/IMX6SX-SDB/BSP_M4
IPATH+=./Micrium/Examples/Freescale/IMX6SX-SDB/BSP_M4/uCOS-III
IPATH+=./Micrium/Examples/Freescale/IMX6SX-SDB/BSP_M4/GNU
IPATH+=./Micrium/Software/uC-CPU/ARM-Cortex-M4/GNU
IPATH+=./Micrium/Software/uCOS-III/Ports/ARM-Cortex-M4/Generic/GNU


VPATH=./Micrium/Examples/Freescale/IMX6SX-SDB/OS3_M4
VPATH+=./Micrium/Software/uC-CPU
VPATH+=./Micrium/Software/uC-LIB
VPATH+=./Micrium/Software/uCOS-III/Source
VPATH+=./Micrium/Examples/Freescale/IMX6SX-SDB/BSP_M4
VPATH+=./Micrium/Examples/Freescale/IMX6SX-SDB/BSP_M4/uCOS-III
VPATH+=./Micrium/Examples/Freescale/IMX6SX-SDB/BSP_M4/GNU
VPATH+=./Micrium/Software/uC-CPU/ARM-Cortex-M4/GNU
VPATH+=./Micrium/Software/uCOS-III/Ports/ARM-Cortex-M4/Generic/GNU
#
# The default rule, which causes the uart_echo example to be built.
#
all: ${COMPILER}
all: ${COMPILER}/uCosIII.axf

#
# The rule to clean out all the build products.
#
clean:
	@rm -rf ${COMPILER} ${wildcard *~}
install:
	openocd -f openocd.cfg -c "flash_image"
#	jlink.exe burn.txt

#
# The rule to create the target directory.
#
${COMPILER}:
	@mkdir -p ${COMPILER}

#
# Rules for building the uart_echo example.
#
${COMPILER}/uCosIII.axf: ${COMPILER}/app.o
${COMPILER}/uCosIII.axf: ${COMPILER}/cpu_core.o
${COMPILER}/uCosIII.axf: ${COMPILER}/lib_ascii.o
${COMPILER}/uCosIII.axf: ${COMPILER}/lib_math.o
${COMPILER}/uCosIII.axf: ${COMPILER}/lib_mem.o
${COMPILER}/uCosIII.axf: ${COMPILER}/lib_str.o
${COMPILER}/uCosIII.axf: ${COMPILER}/os_cfg_app.o
${COMPILER}/uCosIII.axf: ${COMPILER}/os_core.o
${COMPILER}/uCosIII.axf: ${COMPILER}/os_dbg.o
${COMPILER}/uCosIII.axf: ${COMPILER}/os_flag.o
${COMPILER}/uCosIII.axf: ${COMPILER}/os_int.o
${COMPILER}/uCosIII.axf: ${COMPILER}/os_mem.o
${COMPILER}/uCosIII.axf: ${COMPILER}/os_mon.o
${COMPILER}/uCosIII.axf: ${COMPILER}/os_msg.o
${COMPILER}/uCosIII.axf: ${COMPILER}/os_mutex.o
${COMPILER}/uCosIII.axf: ${COMPILER}/os_pend_multi.o
${COMPILER}/uCosIII.axf: ${COMPILER}/os_prio.o
${COMPILER}/uCosIII.axf: ${COMPILER}/os_q.o
${COMPILER}/uCosIII.axf: ${COMPILER}/os_sem.o
${COMPILER}/uCosIII.axf: ${COMPILER}/os_stat.o
${COMPILER}/uCosIII.axf: ${COMPILER}/os_task.o
${COMPILER}/uCosIII.axf: ${COMPILER}/os_tick.o
${COMPILER}/uCosIII.axf: ${COMPILER}/os_time.o
${COMPILER}/uCosIII.axf: ${COMPILER}/os_tmr.o
${COMPILER}/uCosIII.axf: ${COMPILER}/os_var.o
${COMPILER}/uCosIII.axf: ${COMPILER}/bsp.o
${COMPILER}/uCosIII.axf: ${COMPILER}/bsp_int.o
${COMPILER}/uCosIII.axf: ${COMPILER}/bsp_ser.o
${COMPILER}/uCosIII.axf: ${COMPILER}/cpu_c.o
${COMPILER}/uCosIII.axf: ${COMPILER}/bsp_os.o
${COMPILER}/uCosIII.axf: ${COMPILER}/os_cpu_c.o
${COMPILER}/uCosIII.axf: ${COMPILER}/_sbrk.o
${COMPILER}/uCosIII.axf: ${COMPILER}/startup.o
${COMPILER}/uCosIII.axf: ${COMPILER}/cpu_a.o
${COMPILER}/uCosIII.axf: ${COMPILER}/os_cpu_a.o
${COMPILER}/uCosIII.axf: solox_cm4.ld
SCATTERgcc_uCosIII=solox_cm4.ld
ENTRY_uCosIII=Reset_Handler
CFLAGSgcc=

#
# Include the automatically generated dependency files.
#
ifneq (${MAKECMDGOALS},clean)
-include ${wildcard ${COMPILER}/*.d} __dummy__
endif
