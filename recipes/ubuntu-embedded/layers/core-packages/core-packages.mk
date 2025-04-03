LAYER:=core-packages
include $(DEFINE_LAYER)

core-packages:=$(LSTAMP)/core-packages

$(L) += $(core-packages)

include $(BUILD_LAYER)

$(core-packages):
	mkdir -p $(rootfsdir)/overlay
	mount --bind $(basedir)/overlay $(rootfsdir)/overlay
	arch-chroot $(rootfsdir) /overlay/core-packages.sh
	umount -R $(rootfsdir)/overlay
	$(stamp)


