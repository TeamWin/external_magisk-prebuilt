#pragma once

#include <logging.h>

#define MAIN_SOCKET  "d30138f2310a9fb9c54a3e0c21f58591"
#define JAVA_PACKAGE_NAME "com.topjohnwu.magisk"
#define LOGFILE         "/cache/magisk.log"
#define UNBLOCKFILE     "/dev/.magisk_unblock"
#define DISABLEFILE     "/cache/.disable_magisk"
#define MAGISKTMP       "/sbin/.magisk"
#define MIRRDIR         MAGISKTMP "/mirror"
#define BLOCKDIR        MAGISKTMP "/block"
#define BBPATH          MAGISKTMP "/busybox"
#define MODULEMNT       MAGISKTMP "/modules"
#define ROOTOVL         MAGISKTMP "/rootdir"
#define ROOTMNT         ROOTOVL "/.mount_list"
#define SECURE_DIR      "/data/adb"
#define MODULEROOT      SECURE_DIR "/modules"
#define MODULEUPGRADE   SECURE_DIR "/modules_update"
#define DATABIN         SECURE_DIR "/magisk"
#define MAGISKDB        SECURE_DIR "/magisk.db"
#define MANAGERAPK      DATABIN "/magisk.apk"

constexpr const char *applet_names[] = { "su", "resetprop", "magiskhide", nullptr };

// Multi-call entrypoints
int magisk_main(int argc, char *argv[]);
int magiskhide_main(int argc, char *argv[]);
int magiskpolicy_main(int argc, char *argv[]);
int su_client_main(int argc, char *argv[]);
int resetprop_main(int argc, char *argv[]);
