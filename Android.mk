LOCAL_PATH := $(call my-dir)

# Some handy paths
MAGISK_ROOT_PATH := $(LOCAL_PATH)
EXT_PATH := $(LOCAL_PATH)/external
SE_PATH := $(EXT_PATH)/selinux
LIBSELINUX := $(SE_PATH)/libselinux/include
LIBSEPOL := $(SE_PATH)/libsepol/include $(SE_PATH)/libsepol/cil/include
LIBLZMA := $(EXT_PATH)/xz/src/liblzma/api
LIBLZ4 := $(EXT_PATH)/lz4/lib
LIBBZ2 := $(EXT_PATH)/bzip2
LIBFDT := $(EXT_PATH)/dtc/libfdt
LIBNANOPB := $(EXT_PATH)/nanopb
LIBSYSTEMPROPERTIES := $(LOCAL_PATH)/systemproperties/include
LIBUTILS := $(LOCAL_PATH)/utils/include
LIBMINCRYPT := $(EXT_PATH)/mincrypt/include
LIBXZ := $(EXT_PATH)/xz-embedded
LIBPCRE2 := $(EXT_PATH)/pcre/include

MAGISK_CFLAGS += -D__MVSTR="TWRP-dynamic" -D__MCODE="ed58cf9"
MAGISK_CFLAGS += -Wno-unused-parameter -std=c++14 -Wno-sign-compare

ifeq ($(TW_INCLUDE_RESETPROP), true)
    ifeq ($(shell test $(PLATFORM_SDK_VERSION) -lt 24; echo $$?),0)
        TW_INCLUDE_RESETPROP_PREBUILT := true
    else
        TW_INCLUDE_RESETPROP_SOURCE := true
        TW_INCLUDE_LIBRESETPROP := true
    endif
endif

ifeq ($(TW_INCLUDE_LIBRESETPROP), true)
    ifeq ($(shell test $(PLATFORM_SDK_VERSION) -lt 24; echo $$?),0)
        TW_INCLUDE_LIBRESETPROP_PREBUILT := true
    else
        TW_INCLUDE_LIBRESETPROP_SOURCE := true
    endif
endif

include $(call all-subdir-makefiles)
