LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE:= libmagiskutils
LOCAL_C_INCLUDES := $(MAGISK_ROOT_PATH)/include $(LIBUTILS)
LOCAL_SRC_FILES := \
	logging.cpp \
	file.cpp \
	missing.cpp \
	xwrap.cpp \

	#cpio.cpp \
	#new.cpp \
	#misc.cpp \
	#selinux.cpp \
	#stream.cpp 

LOCAL_CFLAGS += $(MAGISK_CFLAGS)
include $(BUILD_STATIC_LIBRARY)
