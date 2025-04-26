LAYER:=imx-atf
include $(DEFINE_LAYER)

imx-atf:=$(BUILD)/$(L)/imx-atf/imx93/release/bl31.bin

$(call git_clone, imx-atf, https://github.com/nxp-imx/imx-atf.git, lf_v2.10)

$(L) += $(imx-atf)


include $(BUILD_LAYER)

$(imx-atf):
	mkdir -p $(builddir)
	cd $(builddir) && $(MAKE) BUILD_BASE=$(builddir)/imx-atf -C $(srcdir)/imx-atf PLAT=imx93
	touch $@


