LAYER:=bootloader
include $(DEFINE_LAYER)

UBOOT_GIT_URL?=https://github.com/nxp-imx/uboot-imx.git
UBOOT_GIT_REF?=lf_v2024.04

UBOOT_OUT:=$(BUILD)/$(L)/u-boot
UBOOT_SIGNED_OUT:=$(BUILD)/$(L)/u-boot-signed
UBOOT_SOURCE:=$(SRC_bootloader)/u-boot
UBOOT_CONFIG?=$(RECIPE)/kconfigs/u-boot-imx93.config
UBOOT_DEFCONFIG?=imx93_11x11_evk_defconfig

uboot:=$(UBOOT_OUT)/u-boot.bin
uboot-config:=$(UBOOT_OUT)/.config

$(L) += $(uboot-config)
$(L) += $(uboot)


$(T) += bootloader-config

$(call git_clone, u-boot, $(UBOOT_GIT_URL), $(UBOOT_GIT_REF))

include $(BUILD_LAYER)

$(uboot): $(uboot-config)
$(uboot):
	mkdir -p $(builddir)
	cd $(UBOOT_SOURCE) && $(MAKE) O=$(UBOOT_OUT) CROSS_COMPILE=$(CROSS_COMPILE)

$(uboot-config): $(UBOOT_CONFIG)
$(uboot-config):
	mkdir -p $(UBOOT_OUT)
	cp $(UBOOT_CONFIG) $(uboot-config)

define do_bconfig
  @echo do_bconfig
	cd $(UBOOT_SOURCE) && $(MAKE) O=$(UBOOT_OUT) CROSS_COMPILE=$(CROSS_COMPILE) $(UBOOT_DEFCONFIG)
	cp $(UBOOT_OUT)/.config $(UBOOT_CONFIG)
endef

$(UBOOT_CONFIG):
	$(call do_bconfig)
	cp $(UBOOT_OUT)/.config $@


