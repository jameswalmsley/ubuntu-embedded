LAYER:=imx-mkimage
include $(DEFINE_LAYER)

flash.bin:=$(BUILD)/$(L)/iMX93/flash.bin

$(L) += $(flash.bin)

$(call git_clone, imx-mkimage, https://github.com/nxp-imx/imx-mkimage, lf-6.12.3_1.0.0)

include $(BUILD_LAYER)

$(flash.bin):
	rm -rf $(builddir)
	mkdir -p $(builddir)
	cp -r $(srcdir)/imx-mkimage/* $(builddir)
	cp $(imx-firmware-ahab-container) $(builddir)/iMX93/
	cp $(u-boot-spl) $(builddir)/iMX93/
	cp $(IMX_FW_DDR_BASE)/lpddr4_imem_1d_v202201.bin $(builddir)/iMX93/
	cp $(IMX_FW_DDR_BASE)/lpddr4_dmem_1d_v202201.bin $(builddir)/iMX93/
	cp $(IMX_FW_DDR_BASE)/lpddr4_imem_2d_v202201.bin $(builddir)/iMX93/
	cp $(IMX_FW_DDR_BASE)/lpddr4_dmem_2d_v202201.bin $(builddir)/iMX93/
	cp $(imx-atf) $(builddir)/iMX93/
	cp $(uboot) $(builddir)/iMX93/
	cd $(builddir) && $(MAKE) SOC=iMX93 flash_singleboot

