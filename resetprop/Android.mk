LOCAL_PATH := $(call my-dir)

ifneq ($(filter x86_64 arm64,$(TARGET_ARCH)),)
    MAGISK_LDFLAGS := -Wl,-dynamic-linker,/sbin/linker64
else
    MAGISK_LDFLAGS := -Wl,-dynamic-linker,/sbin/linker
endif

include $(CLEAR_VARS)
ifeq ($(TW_INCLUDE_RESETPROP_SOURCE), true)
    LOCAL_MODULE := resetprop
    LOCAL_MULTILIB := first
    LOCAL_SHARED_LIBRARIES := libresetprop
    LOCAL_MODULE_TAGS := eng
    LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
    LOCAL_C_INCLUDES := \
        $(MAGISK_ROOT_PATH)/include \
        $(LIBUTILS)

    LOCAL_SRC_FILES := \
        ../core/applet_stub.cpp

    LOCAL_CFLAGS += $(MAGISK_CFLAGS)
    LOCAL_CFLAGS += -DAPPLET_STUB_MAIN=resetprop_main
    #LOCAL_LDFLAGS := -static
    LOCAL_LDFLAGS := $(MAGISK_LDFLAGS)
    include $(BUILD_EXECUTABLE)
endif

include $(CLEAR_VARS)
ifeq ($(TW_INCLUDE_LIBRESETPROP_SOURCE), true)
    LOCAL_MODULE := libresetprop
    LOCAL_MULTILIB := first
    LOCAL_STATIC_LIBRARIES := libnanopb libmagisksystemproperties libmagiskutils
    LOCAL_SHARED_LIBRARIES := liblog libselinux
    LOCAL_MODULE_TAGS := eng
    LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
    LOCAL_C_INCLUDES := \
        $(MAGISK_ROOT_PATH)/include \
        $(LIBNANOPB) \
        $(LIBSYSTEMPROPERTIES) \
        $(LIBUTILS)

    LOCAL_SRC_FILES := \
        persist_properties.cpp \
        resetprop.cpp \
        system_property_api.cpp \
        system_property_set.cpp

    LOCAL_CFLAGS += $(MAGISK_CFLAGS)
    LOCAL_LDFLAGS := $(MAGISK_LDFLAGS)
    include $(BUILD_SHARED_LIBRARY)
endif
