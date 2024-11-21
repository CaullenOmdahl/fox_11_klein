#
# Copyright (C) 2021 The kleinRom Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),klein)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif
