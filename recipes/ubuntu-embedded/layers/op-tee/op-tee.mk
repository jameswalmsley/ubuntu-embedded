LAYER:=op-tee
include $(DEFINE_LAYER)

optee-os:=$(BUILD)/$(L)/arm/core/tee.bin

$(L) += $(optee-os)

$(call git_clone, optee_os, https://github.com/OP-TEE/optee_os.git, master)

include $(BUILD_LAYER)

$(optee-os):
	mkdir -p $(builddir)
	cd $(builddir) && $(MAKE) -C $(srcdir)/optee_os \
		CFG_ARM64_core=y \
		CFG_TEE_BENCHMARK=y \
		CFG_TEE_CORE_LOG_LEVEL=3 \
		CROSS_COMPILE=aarch64-linux-gnu- \
		CROSS_COMPILE_core=aarch64-linux-gnu- \
		CROSS_COMPILE_ta_arm32=arm-linux-gnueabihf \
		CROSS_COMPILE_ta_arm64=aarch64-linux-gnu- \
		DEBUG=1 \
		O=$(builddir)/arm \
		PLATFORM=imx \
		PLATFORM_FLAVOR=mx93evk
	touch $@
