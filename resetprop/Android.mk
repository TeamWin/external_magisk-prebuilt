LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
ifeq ($(TW_INCLUDE_RESETPROP_SOURCE), true)
    LOCAL_MODULE := resetprop
    LOCAL_MULTILIB := first
    LOCAL_SHARED_LIBRARIES := libresetprop
    LOCAL_MODULE_TAGS := optional
    LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/system/bin
    LOCAL_C_INCLUDES := \
        $(MAGISK_ROOT_PATH)/include \
        $(LIBUTILS) \
        $(LIBUTILS)/include 

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
    LOCAL_MODULE_TAGS := optional
    LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/system/lib64
    LOCAL_C_INCLUDES := \
        $(MAGISK_ROOT_PATH) \
        $(MAGISK_ROOT_PATH)/include \
        $(MAGISK_ROOT_PATH)/utils/include \
        $(LIBNANOPB) \
        $(LIBSYSTEMPROPERTIES) \
        $(LIBSYSTEMPROPERTIES)/include \
        $(LIBUTILS) \
	bionic/libc \
	bionic/libc/include

    LOCAL_SRC_FILES := \
	    persist.cpp \
	    resetprop.cpp

    LOCAL_CFLAGS += $(MAGISK_CFLAGS)
    LOCAL_LDFLAGS := $(MAGISK_LDFLAGS)
    LOCAL_CFLAGS += -Wno-implicit-fallthrough -std=c++17
    include $(BUILD_SHARED_LIBRARY)
endif
