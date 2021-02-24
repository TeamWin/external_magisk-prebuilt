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
    LOCAL_MODULE := magiskboot
    ifeq ($(shell test $(PLATFORM_SDK_VERSION) -ge 29; echo $$?),0)
        LOCAL_MODULE_TAGS := optional
    else
        LOCAL_MODULE_TAGS := eng
    endif
    LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
    LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/system/bin
    LOCAL_SRC_FILES := $(MAGISKBOOT_TARGET)
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
    LOCAL_MODULE := resetprop
    ifeq ($(shell test $(PLATFORM_SDK_VERSION) -ge 29; echo $$?),0)
        LOCAL_MODULE_TAGS := optional
    else
        LOCAL_MODULE_TAGS := eng
    endif
    LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
    LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/system/bin
    LOCAL_SRC_FILES := $(RESETPROP_TARGET)
    include $(BUILD_PREBUILT)
endif
