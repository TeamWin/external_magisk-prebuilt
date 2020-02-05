#pragma once

#include <stdio.h>
#include <syscall.h>

#ifndef PR_SET_VMA
#define PR_SET_VMA 0x53564d41
#endif
#ifndef PR_SET_VMA_ANON_NAME
#define PR_SET_VMA_ANON_NAME 0
#endif
#define getline __getline
#define fsetxattr(...) syscall(__NR_fsetxattr, __VA_ARGS__)
ssize_t __getline(char **, size_t *, FILE *);

#ifndef __BIONIC_ALIGN
#define __BIONIC_ALIGN(__value, __alignment) (((__value) + (__alignment)-1) & ~((__alignment)-1))
#endif
