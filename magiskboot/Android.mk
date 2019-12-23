LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

ifeq ($(TW_INCLUDE_REPACKTOOLS), true)
    ifneq (,$(filter $(TARGET_ARCH), x86 x86_64))
        MAGISKBOOT_TARGET := magiskbootx86
    else
        MAGISKBOOT_TARGET := magiskbootarm
    endif
    #magiskboot prebuilt
    include $(CLEAR_VARS)
    LOCAL_MODULE := $(MAGISKBOOT_TARGET)
    LOCAL_MODULE_STEM := magiskboot
    LOCAL_MODULE_TAGS := eng
    LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
    LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
    LOCAL_SRC_FILES := $(LOCAL_MODULE)
    include $(BUILD_PREBUILT)
endif
