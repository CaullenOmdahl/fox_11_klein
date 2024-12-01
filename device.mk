# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    android.hardware.fastboot@1.0-impl-mock.recovery \
    fastbootd

# API level
PRODUCT_SHIPPING_API_LEVEL := 29

# A/B support
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    system \
    vendor \
    vbmeta \
    dtbo

# A/B OTA dexopt update_engine hookup
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service \
    bootctrl.kona \
    bootctrl.kona.recovery

PRODUCT_PACKAGES_DEBUG += \
    bootctl

# Update engine
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# Recovery modules
PRODUCT_HOST_PACKAGES += \
    libandroidicu

# OrangeFox Recovery
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# QCOM Decryption
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Additional OrangeFox packages
PRODUCT_PACKAGES += \
    bash \
    nano \
    grep \
    curl \
    unzip \
    zip \
    xz-utils