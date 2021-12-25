LOCAL_PATH := $(call my-dir)

# All Magisk common code lives here

UTILS_SRC_FILES := \
    new.cpp \
    files.cpp \
    misc.cpp \
    selinux.cpp \
    logging.cpp \
    xwrap.cpp \
    stream.cpp

include $(CLEAR_VARS)
LOCAL_MODULE:= libmagiskutils
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../include $(LOCAL_PATH)/include out/generated
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_C_INCLUDES)
LOCAL_EXPORT_STATIC_LIBRARIES := libc++_static
LOCAL_STATIC_LIBRARIES := libc++_static
LOCAL_SRC_FILES := $(UTILS_SRC_FILES) missing.cpp
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE:= libmagiskutils-shared
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../include out/generated
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_C_INCLUDES)
LOCAL_EXPORT_STATIC_LIBRARIES := libc++_static
LOCAL_STATIC_LIBRARIES := libc++_static
LOCAL_SRC_FILES := $(UTILS_SRC_FILES)
include $(BUILD_STATIC_LIBRARY)
