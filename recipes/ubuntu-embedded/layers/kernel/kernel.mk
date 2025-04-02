LAYER:=kernel
include $(DEFINE_LAYER)

LINUX_GIT_URL?=https://github.com/nxp-imx/linux-imx.git
LINUX_GIT_REF?=lf-6.12.y

KERNEL_OUT:=$(BUILD)/$(L)/linux
KERNEL_SOURCE:=$(SRC_kernel)/linux
LINUX_CONFIG?=$(RECIPE)/kconfigs/linux-$(ARCH).config
LINUX_DEFCONFIG?=imx_v8_defconfig

#
# Define target variables
#
kernel:=$(BUILD)/$(L)/linux/arch/$(ARCH)/boot/Image
kernel-config:=$(KERNEL_OUT)/.config
dtb-file?=$(dir $(kernel))/dts/$(dtb-name)

#
# Hook layer targets
#
$(L) += $(kernel)
$(L) += $(kernel-config)

#
# Register optional targets.
#
$(T) += kernel-config
$(T) += kernelversion
$(T) += dtbs

#
# Specify source checkouts
#
$(call git_clone, linux, $(LINUX_GIT_URL), $(LINUX_GIT_REF))

#
# Hook layer into build system.
#
include $(BUILD_LAYER)


#
# Layer Build instructions...
#
$(kernel):
	mkdir -p $(KERNEL_OUT)
	cp $(LINUX_CONFIG) $(kernel-config)
	cd $(KERNEL_SOURCE) && $(MAKE) O=$(KERNEL_OUT) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) olddefconfig
	cd $(KERNEL_SOURCE) && $(MAKE) O=$(KERNEL_OUT) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) modules_prepare
	cd $(KERNEL_SOURCE) && $(MAKE) O=$(KERNEL_OUT) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) Image.gz
	cd $(KERNEL_SOURCE) && $(MAKE) O=$(KERNEL_OUT) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) dtbs
	cd $(KERNEL_SOURCE) && $(MAKE) O=$(KERNEL_OUT) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) modules
	touch $@

$(kernel): $(LINUX_CONFIG)

KERNEL_CONFIG_TARGET:=$(LINUX_DEFCONFIG)

define do_kconfig
	cd $(KERNEL_SOURCE) && $(MAKE) O=$(KERNEL_OUT) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) $(KERNEL_CONFIG_TARGET)
	cp $(kernel-config) $(LINUX_CONFIG)
endef

$(kernel-config):
	mkdir -p $(KERNEL_OUT)
	cp $(LINUX_CONFIG) $(kernel-config)

$(kernel-config): $(LINUX_CONFIG)

.PHONY:kernel-config
kernel-config: KERNEL_CONFIG_TARGET:=menuconfig

kernel-config:
	cp $(LINUX_CONFIG) $(KERNEL_OUT)/.config
	$(call do_kconfig)
	cp $(KERNEL_OUT)/.config $(LINUX_CONFIG)

$(LINUX_CONFIG):
	$(call do_kconfig)
	cp $(KERNEL_OUT)/.config $@

ifneq ($(wildcard $(KERNEL_SOURCE)),)
KERNEL_VERSION:=$(shell cd $(KERNEL_SOURCE) && $(MAKE) --quiet O=$(KERNEL_OUT) ARCH=$(ARCH) kernelversion)
endif

.PHONY: kernelversion
kernelversion:
	@echo $(KERNEL_VERSION)

.PHONY: dtbs
dtbs:
	cd $(KERNEL_SOURCE) && $(MAKE) O=$(KERNEL_OUT) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) dtbs

$(L).clean:
	rm -rf $(L_kernel)
	cd $(KERNEL_SOURCE) && $(MAKE) O=$(KERNEL_OUT) clean

