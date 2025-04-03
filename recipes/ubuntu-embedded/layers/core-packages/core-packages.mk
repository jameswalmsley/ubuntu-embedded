LAYER:=core-packages
include $(DEFINE_LAYER)

core-packages:=$(LSTAMP)/core-packages

$(L) += $(core-packages)

include $(BUILD_LAYER)

$(core-packages):
	@arch-chroot $(rootfsdir) /overlay/core-packages.sh 2> /dev/null
	$(stamp)

