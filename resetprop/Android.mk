LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := resetprop
LOCAL_SHARED_LIBRARIES := libresetprop
LOCAL_C_INCLUDES := \
	$(MAGISK_ROOT_PATH)/include \
	$(LIBUTILS)

LOCAL_SRC_FILES := \
	../core/applet_stub.cpp

LOCAL_CFLAGS += $(MAGISK_CFLAGS)
LOCAL_CFLAGS += -DAPPLET_STUB_MAIN=resetprop_main
#LOCAL_LDFLAGS := -static
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_MODULE := libresetprop
LOCAL_STATIC_LIBRARIES := libnanopb libmagisksystemproperties libmagiskutils
LOCAL_SHARED_LIBRARIES := liblog libselinux
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
include $(BUILD_SHARED_LIBRARY)
