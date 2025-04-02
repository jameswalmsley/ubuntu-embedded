LAYER:=debootstrap
include $(DEFINE_LAYER)

debootstrap:=$(LSTAMP)/debootstrap

$(L) += $(debootstrap)

include $(BUILD_LAYER)

$(debootstrap):
	-rm -rf $(ROOTFS)
	mkdir -p $(ROOTFS)
	debootstrap \
		--arch=arm64 \
		--verbose \
		--foreign \
		--variant=minbase \
		noble \
		$(ROOTFS)
	chroot $(ROOTFS) /bin/bash -c "DEBIAN_FRONTEND=noninteractive /debootstrap/debootstrap --second-stage"
	rm -rf $(ROOTFS)/debootstrap
	$(stamp)
