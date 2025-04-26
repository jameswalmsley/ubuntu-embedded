include $(DEFINE_RECIPE)

ARCH:=arm64
DEBARCH:=arm64

#
# Build bootloader / Kernel from sources
# 
LAYERS += imx-atf
LAYERS += imx-firmware
LAYERS += op-tee
LAYERS += bootloader
LAYERS += imx-mkimage
LAYERS += kernel

#
# Bootstrap the rootfs / ubuntu and configure
#
LAYERS += debootstrap
LAYERS += core-packages
LAYERS += rootfs-customisation

#
# META / Sync layer
#
LAYERS += rootfs


#
# Image Generation
#
LAYERS += squashfs
LAYERS += imx-uuu


#
# DONE!
#

include $(BUILD_RECIPE)
