// This file implements all missing symbols that should exist in normal API 21
// libc.a but missing in our extremely lean libc.a replacements.

#include <cstdlib>
#include <cstring>
#include <cerrno>
#include <mntent.h>
#include <unistd.h>
#include <sys/syscall.h>

extern "C" {

/* Original source: https://github.com/freebsd/freebsd/blob/master/contrib/file/src/getline.c
 * License: BSD, full copyright notice please check original source */

ssize_t getdelim(char **buf, size_t *bufsiz, int delimiter, FILE *fp) {
    char *ptr, *eptr;

    if (*buf == nullptr || *bufsiz == 0) {
        *bufsiz = BUFSIZ;
        if ((*buf = (char *) malloc(*bufsiz)) == nullptr)
            return -1;
    }

    for (ptr = *buf, eptr = *buf + *bufsiz;;) {
        int c = fgetc(fp);
        if (c == -1) {
            if (feof(fp))
                return ptr == *buf ? -1 : ptr - *buf;
            else
                return -1;
        }
        *ptr++ = c;
        if (c == delimiter) {
            *ptr = '\0';
            return ptr - *buf;
        }
        if (ptr + 2 >= eptr) {
            char *nbuf;
            size_t nbufsiz = *bufsiz * 2;
            ssize_t d = ptr - *buf;
            if ((nbuf = (char *) realloc(*buf, nbufsiz)) == nullptr)
                return -1;
            *buf = nbuf;
            *bufsiz = nbufsiz;
            eptr = nbuf + nbufsiz;
            ptr = nbuf + d;
        }
    }
}

ssize_t getline(char **buf, size_t *bufsiz, FILE *fp) {
    return getdelim(buf, bufsiz, '\n', fp);
}

/* Original source: https://android.googlesource.com/platform/bionic/+/master/libc/bionic/mntent.cpp
 * License: AOSP, full copyright notice please check original source */

struct mntent *getmntent_r(FILE *fp, struct mntent *e, char *buf, int buf_len) {
    memset(e, 0, sizeof(*e));
    while (fgets(buf, buf_len, fp) != nullptr) {
        // Entries look like "proc /proc proc rw,nosuid,nodev,noexec,relatime 0 0".
        // That is: mnt_fsname mnt_dir mnt_type mnt_opts 0 0.
        int fsname0, fsname1, dir0, dir1, type0, type1, opts0, opts1;
        if (sscanf(buf, " %n%*s%n %n%*s%n %n%*s%n %n%*s%n %d %d",
                   &fsname0, &fsname1, &dir0, &dir1, &type0, &type1, &opts0, &opts1,
                   &e->mnt_freq, &e->mnt_passno) == 2) {
            e->mnt_fsname = &buf[fsname0];
            buf[fsname1] = '\0';
            e->mnt_dir = &buf[dir0];
            buf[dir1] = '\0';
            e->mnt_type = &buf[type0];
            buf[type1] = '\0';
            e->mnt_opts = &buf[opts0];
            buf[opts1] = '\0';
            return e;
        }
    }
    return nullptr;
}

FILE *setmntent(const char *path, const char *mode) {
    return fopen(path, mode);
}

int endmntent(FILE *fp) {
    if (fp != nullptr) {
        fclose(fp);
    }
    return 1;
}

// Missing system call wrappers

int setns(int fd, int nstype) {
    return syscall(__NR_setns, fd, nstype);
}

int unshare(int flags) {
    return syscall(__NR_unshare, flags);
}

int accept4(int sockfd, struct sockaddr *addr, socklen_t *addrlen, int flags) {
    return syscall(__NR_accept4, sockfd, addr, addrlen, flags);
}

int dup3(int oldfd, int newfd, int flags) {
    return syscall(__NR_dup3, oldfd, newfd, flags);
}

ssize_t readlinkat(int dirfd, const char *pathname, char *buf, size_t bufsiz) {
    return syscall(__NR_readlinkat, dirfd, pathname, buf, bufsiz);
}

int symlinkat(const char *target, int newdirfd, const char *linkpath) {
    return syscall(__NR_symlinkat, target, newdirfd, linkpath);
}

int linkat(int olddirfd, const char *oldpath,
           int newdirfd, const char *newpath, int flags) {
    return syscall(__NR_linkat, olddirfd, oldpath, newdirfd, newpath, flags);
}

int inotify_init1(int flags) {
    return syscall(__NR_inotify_init1, flags);
}

int faccessat(int dirfd, const char *pathname, int mode, int flags) {
    return syscall(__NR_faccessat, dirfd, pathname, mode, flags);
}

#define SPLIT_64(v) (unsigned)((v) & 0xFFFFFFFF), (unsigned)((v) >> 32)

#if defined(__arm__)
// Why the additional 0 is required: https://man7.org/linux/man-pages/man2/syscall.2.html
int ftruncate64(int fd, off64_t length) {
    return syscall(__NR_ftruncate64, fd, 0, SPLIT_64(length));
}
#elif defined(__i386__)
int ftruncate64(int fd, off64_t length) {
    return syscall(__NR_ftruncate64, fd, SPLIT_64(length));
}
#endif

#if !defined(__LP64__)
void android_set_abort_message(__attribute__((unused)) const char *msg) {}
#endif

} // extern "C"
