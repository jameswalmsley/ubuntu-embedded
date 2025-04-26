LAYER:=imx-firmware
include $(DEFINE_LAYER)

imx-firmware-ddr:=$(BUILD)/$(L)/imx-ddr-firmware/
imx-firmware-sentinel:=$(LSTAMP)/firmware-sentinel


IMX_FW_VER:=8.21
IMX_FW_BASE:=$(BUILD)/$(L)/firmware-imx-$(IMX_FW_VER)/firmware
IMX_FW_DDR_BASE:=$(IMX_FW_BASE)/ddr/synopsys

IMX_SENTINEL_VER:=0.11
IMX_SENTINEL_BASE:=$(BUILD)/$(L)/firmware-sentinel-$(IMX_SENTINEL_VER)

#
# Convenience variables for other layers.
#

imx-firmware-ahab-container:=$(IMX_SENTINEL_BASE)/mx93a1-ahab-container.img

$(L) += $(imx-firmware-ddr)
$(L) += $(imx-firmware-sentinel)

$(call get_file, imx-ddr-firmware, https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-$(IMX_FW_VER).bin)
$(call get_file, imx-firmware-sentinel, https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-sentinel-$(IMX_SENTINEL_VER).bin)

include $(BUILD_LAYER)


$(imx-firmware-sentinel):
	rm -rf $(IMX_SENTINEL_BASE)
	mkdir -p $(builddir)
	chmod +x $(srcdir)/imx-firmware-sentinel/firmware-sentinel-0.11.bin
	cd $(builddir) && $(srcdir)/imx-firmware-sentinel/firmware-sentinel-0.11.bin --force --auto-accept
	$(stamp)

$(imx-firmware-ddr): | $(imx-firmware-sentinel)
	rm -rf $(IMX_FW_BASE)
	mkdir -p $(builddir)
	chmod +x $(srcdir)/imx-ddr-firmware/firmware-imx-8.21.bin
	cd $(builddir) && $(srcdir)/imx-ddr-firmware/firmware-imx-8.21.bin --force --auto-accept
	$(stamp)

