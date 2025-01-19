# Inherit mobile full common stuff
$(call inherit-product, vendor/rvos/config/common_mobile_full.mk)

# Inherit tablet common stuff
$(call inherit-product, vendor/rvos/config/tablet.mk)

$(call inherit-product, vendor/rvos/config/telephony.mk)
