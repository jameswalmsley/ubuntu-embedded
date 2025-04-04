LAYER:=core-packages
include $(DEFINE_LAYER)

core-packages:=$(LSTAMP)/core-packages

$(L) += $(core-packages)

include $(BUILD_LAYER)

$(core-packages): $(BASE_core-packages)/core-packages.sh
	arch-chroot $(rootfsdir) /overlay/core-packages.sh
	$(stamp)

