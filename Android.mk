LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),klein)
include $(call all-makefiles-under,$(LOCAL_PATH))
endif 