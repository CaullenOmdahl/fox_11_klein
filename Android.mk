#
# Copyright (C) 2021 The twrpRom Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

source device/blackshark/klein/vendorsetup.sh

ifeq ($(TARGET_DEVICE),klein)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif
