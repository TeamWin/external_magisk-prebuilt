LOCAL_PATH := $(call my-dir)

# libnanopb.a
include $(CLEAR_VARS)
LOCAL_MODULE:= libnanopb
LOCAL_C_INCLUDES := ../$(LIBNANOPB)
LOCAL_SRC_FILES := \
	nanopb/pb_common.c \
	nanopb/pb_decode.c \
	nanopb/pb_encode.c
include $(BUILD_STATIC_LIBRARY)

