#
# Copyright (C) 2021 The kleinRom Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/blackshark/klein

# Dynamic Partition
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    android.hardware.fastboot@1.0-impl-mock.recovery \
    fastbootd
