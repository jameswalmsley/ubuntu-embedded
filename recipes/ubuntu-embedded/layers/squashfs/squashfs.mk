LAYER:=squashfs
include $(DEFINE_LAYER)

squashfs:=$(OUT)/images/rootfs.sqsh

$(L) += $(squashfs)

DEPENDS += rootfs

include $(BUILD_LAYER)

$(squashfs):
	mkdir -p $(dir $@)
	mksquashfs $(rootfsdir) $@ -noappend -comp lz4
