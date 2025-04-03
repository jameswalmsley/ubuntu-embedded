LAYER:=debootstrap
include $(DEFINE_LAYER)

DEBIAN_PACKAGES += systemd

debootstrap:=$(LSTAMP)/debootstrap

$(L) += $(debootstrap)

include $(BUILD_LAYER)

$(debootstrap):
	-rm -rf $(rootfsdir)
	mkdir -p $(rootfsdir)
	debootstrap \
		--arch=arm64 \
		--verbose \
		--foreign \
		--variant=minbase \
		--include=$(subst $(space),$(comma),$(strip $(DEBIAN_PACKAGES))) \
		noble \
		$(rootfsdir)
	chroot $(rootfsdir) /bin/bash -c "DEBIAN_FRONTEND=noninteractive /debootstrap/debootstrap --second-stage"
	rm -rf $(rootfsdir)/debootstrap
	$(stamp)

