RVOS_BUILD_DATE := $(shell date -u +%Y%m%d-%H%M)

RVOS_MAINTAINER ?= Unknown
RVOS_BUILD_TYPE := Unofficial
RVOS_PLATFORM_VERSION := 15.0
RVOS_DISPLAY_VERSION := 1.0
OFFICIAL_MAINTAINER = $(shell cat vendor/rvos/maintainer/official_maintainer.mk | awk '{ print $$1 }')

# Check Official Maintainer
ifdef RVOS_MAINTAINER
        ifeq ($(filter $(RVOS_MAINTAINER), $(OFFICIAL_MAINTAINER)), $(RVOS_MAINTAINER))
                $(warning "$(RVOS_MAINTAINER) is verified as official RvOS maintainer, build as official build.")
                RVOS_BUILD_TYPE := Official
        else
                $(warning "Unofficial maintainer detected, building as unofficial build.")
        endif
else
        $(warning "No maintainer name detected, building as unofficial build.")
endif

RVOS_VERSION := RvOS-v$(RVOS_DISPLAY_VERSION)-$(RVOS_BUILD)-$(RVOS_BUILD_TYPE)-$(RVOS_PLATFORM_VERSION)-$(RVOS_BUILD_DATE)

# RvOS Platform Version
PRODUCT_PRODUCT_PROPERTIES += \
    ro.rvos.device=$(RVOS_BUILD) \
    ro.rvos.version=$(RVOS_DISPLAY_VERSION) \
    ro.modversion=$(RVOS_VERSION) \
    ro.rvos.maintainer=$(RVOS_MAINTAINER) \
    ro.rvos.build.type=$(RVOS_BUILD_TYPE)

# Signing
ifneq (eng,$(TARGET_BUILD_VARIANT))
ifneq (,$(wildcard vendor/rvos/signing/keys/releasekey.pk8))
PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/rvos/signing/keys/releasekey
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.oem_unlock_supported=1
endif
ifneq (,$(wildcard vendor/rvos/signing/keys/otakey.x509.pem))
PRODUCT_OTA_PUBLIC_KEYS := vendor/rvos/signing/keys/otakey.x509.pem
endif
endif
