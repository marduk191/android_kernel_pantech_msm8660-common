#!/bin/bash
###############################################################################
#
#                           Kernel Build Script 
#
###############################################################################
# 2011-10-24 effectivesky : modified
# 2010-12-29 allydrop     : created
###############################################################################
##############################################################################
# set toolchain
##############################################################################
export ARCH=arm
export CROSS_COMPILE=$PWD/tools/arm-eabi-4.6/bin/arm-eabi-
export LINUX_BIN_PATH=$PWD/obj
rm -rf $LINUX_BIN_PATH
CMD_V_LOG_FILE=$PWD/KERNEL_build.log
rm -rf $CMD_V_LOG_FILE

##############################################################################
# make zImage
##############################################################################
mkdir -p ./obj/KERNEL_OBJ/
make O=./obj/KERNEL_OBJ cyanogenmod_presto_defconfig
make -j9 O=./obj/KERNEL_OBJ 2>&1 | tee $CMD_V_LOG_FILE

##############################################################################
# Build boot image
##############################################################################
./tools/mkbootimg --kernel ./obj/KERNEL_OBJ/arch/arm/boot/zImage --ramdisk ./tools/ramdisk/recovery.img-ramdisk.gz --cmdline 'console=ttyHSL0,115200,n8 androidboot.hardware=qcom kgsl.mmutype=gpummu vmalloc=400M loglevel=0 androidboot.selinux=permissive androidboot.baseband=csfb' --board presto --base 0x40200000 --pagesize 2048 --ramdisk_offset 0x01400000 --output ./obj/recovery.img

