#
# Copyright (C) 2021 The twrpRom Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product-if-exists, $(SRC_TARGET_DIR)/product/embedded.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Inherit from klein device
$(call inherit-product, device/blackshark/klein/device.mk)

# Inherit some common twrp stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := klein
PRODUCT_NAME := twrp_klein
PRODUCT_BRAND := blackshark
PRODUCT_MODEL := SHARK KLE-H0
PRODUCT_MANUFACTURER := blackshark