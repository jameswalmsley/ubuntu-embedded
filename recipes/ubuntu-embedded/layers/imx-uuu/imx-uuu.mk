LAYER:=imx-uuu
include $(DEFINE_LAYER)

imx-uuu:=$(OUT)/images/uuu-ubuntu-embedded-arm64-rootfs.zip

$(L) += $(imx-uuu)

include $(BUILD_LAYER)

$(imx-uuu):
	
