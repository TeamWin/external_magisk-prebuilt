LOCAL_PATH := $(call my-dir)

# magiskboot
include $(CLEAR_VARS)
ifeq ($(TW_INCLUDE_REPACKTOOLS), true)
    ifneq (,$(filter $(TARGET_ARCH), x86 x86_64))
        MAGISKBOOT_TARGET := magiskboot_x86
    else
        MAGISKBOOT_TARGET := magiskboot_arm
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

# resetprop
include $(CLEAR_VARS)
ifeq ($(TW_INCLUDE_RESETPROP_PREBUILT), true)
    ifneq (,$(filter $(TARGET_ARCH), x86 x86_64))
        RESETPROP_TARGET := resetprop_x86
    else
        RESETPROP_TARGET := resetprop_arm
    endif
    #resetprop prebuilt
    include $(CLEAR_VARS)
    LOCAL_MODULE := $(RESETPROP_TARGET)
    LOCAL_MODULE_STEM := resetprop
    LOCAL_MODULE_TAGS := eng
    LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
    LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
    LOCAL_SRC_FILES := $(LOCAL_MODULE)
    include $(BUILD_PREBUILT)
endif

# libresetprop
include $(CLEAR_VARS)
ifeq ($(TW_INCLUDE_LIBRESETPROP_PREBUILT), true)
    #libresetprop prebuilt
    include $(CLEAR_VARS)
    LOCAL_MODULE := libresetprop
    LOCAL_MODULE_TAGS := eng
    LOCAL_MODULE_CLASS := SHARED_LIBRARIES
    LOCAL_MODULE_SUFFIX := .so
    LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
    LOCAL_SRC_FILES := libresetprop_$(TARGET_ARCH).so
    include $(BUILD_PREBUILT)
endif
