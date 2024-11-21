# device/blackshark/klein/vendorsetup.sh

# Enable ADB and logcat
export OF_ENABLE_ADB=1
export TWRP_INCLUDE_LOGCAT=true

# File-Based Encryption support
export OF_FBE_METADATA_MOUNT_IGNORE=1
export TW_INCLUDE_CRYPTO=true
export TW_INCLUDE_CRYPTO_FBE=true

# Dynamic partitions
export BOARD_USES_DYNAMIC_PARTITIONS=true

# Filesystem types
export BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE=f2fs
export BOARD_SYSTEMIMAGE_PARTITION_TYPE=ext4

# OTA update support
export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=1

# MIUI specific settings
export OF_NO_MIUI_PATCH_WARNING=1

# Advanced security features
export OF_ADVANCED_SECURITY=1

# Skip FBE decryption if necessary
export OF_SKIP_FBE_DECRYPTION=1

# General build variables
export TARGET_ARCH=arm64
export FOX_AB_DEVICE=1  # If the device is A/B