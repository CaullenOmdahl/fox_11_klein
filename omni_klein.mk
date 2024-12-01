# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from klein device
$(call inherit-product, device/blackshark/klein/device.mk)

# Inherit some common TWRP stuff.
$(call inherit-product, vendor/omni/config/common.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := klein
PRODUCT_NAME := omni_klein
PRODUCT_BRAND := blackshark
PRODUCT_MODEL := SHARK KLE-H0
PRODUCT_MANUFACTURER := blackshark

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=klein \
    BUILD_PRODUCT=klein \
    TARGET_DEVICE=klein

# HACK: Set vendor patch level
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.build.security_patch=2099-12-31 