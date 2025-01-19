RVOS_BUILD_DATE := $(shell date -u +%Y%m%d-%H%M)

RVOS_PLATFORM_VERSION := 15.0
RVOS_DISPLAY_VERSION := 1.0
RVOS_VERSION := RvOS-v$(RVOS_DISPLAY_VERSION)-$(RVOS_BUILD)-$(RVOS_BUILD_TYPE)-$(RVOS_PLATFORM_VERSION)-$(RVOS_BUILD_DATE)

RVOS_MAINTAINER ?= Unknown
RVOS_BUILD_TYPE ?= UNOFFICIAL

# RvOS Platform Version
PRODUCT_PRODUCT_PROPERTIES += \
    ro.rvos.build.date=$(BUILD_DATE) \
    ro.rvos.device=$(RVOS_BUILD) \
    ro.rvos.fingerprint=$(ROM_FINGERPRINT) \
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
