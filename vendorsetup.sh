# device/blackshark/klein/vendorsetup.sh

# Enable ADB and logcat
OF_ENABLE_ADB=1
TWRP_INCLUDE_LOGCAT=true

# File-Based Encryption support
OF_FBE_METADATA_MOUNT_IGNORE=1
TW_INCLUDE_CRYPTO=true
TW_INCLUDE_CRYPTO_FBE=true

# Dynamic partitions
BOARD_USES_DYNAMIC_PARTITIONS=true

# OTA update support
OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=1

# MIUI specific settings
OF_NO_MIUI_PATCH_WARNING=1

# Advanced security features
OF_ADVANCED_SECURITY=1

# Skip FBE decryption if necessary
OF_SKIP_FBE_DECRYPTION=1

# General build variables
TARGET_ARCH=arm64
FOX_AB_DEVICE=1  # If the device is A/B