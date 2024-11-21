#
# Copyright (C) 2021 The twrpRom Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

# Source the vendorsetup.sh file
include $(LOCAL_PATH)/vendorsetup.sh

ifeq ($(TARGET_DEVICE),klein)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif
