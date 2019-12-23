LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

ifneq (,$(filter $(TARGET_ARCH), x86 x86_64))
    RESETPROP_TARGET := resetprop_x86
else
    RESETPROP_TARGET := resetprop_arm
endif
#resetprop prebuilt
include $(CLEAR_VARS)
LOCAL_MODULE := $(RESETPROP_TARGET)
LOCAL_MODULE_STEM := resetprop
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)
