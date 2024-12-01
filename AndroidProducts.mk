LOCAL_PATH := device/blackshark/klein

PRODUCT_MAKEFILES := \
    $(LOCAL_PATH)/omni_klein.mk

COMMON_LUNCH_CHOICES := \
    omni_klein-eng \
    omni_klein-userdebug 