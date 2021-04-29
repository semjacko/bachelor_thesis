/* based on include/arch/unix/apr_private.h.in, generated from configure.in by autoheader.  */


#ifndef APR_PRIVATE_H
#define APR_PRIVATE_H


/* Define if building universal (internal helper macro) */
#cmakedefine AC_APPLE_UNIVERSAL_BUILD

/* Define if apr_allocator should use mmap */
#cmakedefine APR_ALLOCATOR_USES_MMAP

/* Define as function which can be used for conversion of strings to
   apr_int64_t */
#cmakedefine APR_INT64_STRFN

/* Define as function used for conversion of strings to apr_off_t */
#cmakedefine APR_OFF_T_STRFN

/* Define to one of `_getb67', `GETB67', `getb67' for Cray-2 and Cray-YMP
   systems. This function is required for `alloca.c' support on those systems.
   */
#cmakedefine CRAY_STACKSEG_END

/* Define to 1 if using `alloca.c'. */
#cmakedefine C_ALLOCA

/* Define to path of random device */
#cmakedefine DEV_RANDOM

/* Define if struct dirent has an inode member */
#cmakedefine DIRENT_INODE

/* Define if struct dirent has a d_type member */
#cmakedefine DIRENT_TYPE

/* Define if DSO support uses dlfcn.h */
#cmakedefine DSO_USE_DLFCN

/* Define if DSO support uses dyld.h */
#cmakedefine DSO_USE_DYLD

/* Define if DSO support uses shl_load */
#cmakedefine DSO_USE_SHL

/* Define to list of paths to EGD sockets */
#cmakedefine EGD_DEFAULT_SOCKET

/* Define if fcntl locks affect threads within the process */
#cmakedefine FCNTL_IS_GLOBAL

/* Define if fcntl returns EACCES when F_SETLK is already held */
#cmakedefine FCNTL_TRYACQUIRE_EACCES

/* Define if flock locks affect threads within the process */
#cmakedefine FLOCK_IS_GLOBAL

/* Define if gethostbyaddr is thread safe */
#cmakedefine GETHOSTBYADDR_IS_THREAD_SAFE

/* Define if gethostbyname is thread safe */
#cmakedefine GETHOSTBYNAME_IS_THREAD_SAFE

/* Define if gethostbyname_r has the glibc style */
#cmakedefine GETHOSTBYNAME_R_GLIBC2

/* Define if gethostbyname_r has the hostent_data for the third argument */
#cmakedefine GETHOSTBYNAME_R_HOSTENT_DATA

/* Define if getservbyname is thread safe */
#cmakedefine GETSERVBYNAME_IS_THREAD_SAFE

/* Define if getservbyname_r has the glibc style */
#cmakedefine GETSERVBYNAME_R_GLIBC2

/* Define if getservbyname_r has the OSF/1 style */
#cmakedefine GETSERVBYNAME_R_OSF1

/* Define if getservbyname_r has the Solaris style */
#cmakedefine GETSERVBYNAME_R_SOLARIS

/* Define if accept4 function is supported */
#cmakedefine HAVE_ACCEPT4

/* Define to 1 if you have `alloca', as a function or macro. */
#cmakedefine HAVE_ALLOCA

/* Define to 1 if you have <alloca.h> and it should be used (not on Ultrix).
   */
#cmakedefine HAVE_ALLOCA_H

/* Define to 1 if you have the <arpa/inet.h> header file. */
#cmakedefine HAVE_ARPA_INET_H

/* Define if compiler provides atomic builtins */
#cmakedefine HAVE_ATOMIC_BUILTINS

/* Define if BONE_VERSION is defined in sys/socket.h */
#cmakedefine HAVE_BONE_VERSION

/* Define to 1 if you have the <ByteOrder.h> header file. */
#cmakedefine HAVE_BYTEORDER_H

/* Define to 1 if you have the `calloc' function. */
#cmakedefine HAVE_CALLOC

/* Define to 1 if you have the <conio.h> header file. */
#cmakedefine HAVE_CONIO_H

/* Define to 1 if you have the `create_area' function. */
#cmakedefine HAVE_CREATE_AREA

/* Define to 1 if you have the `create_sem' function. */
#cmakedefine HAVE_CREATE_SEM

/* Define to 1 if you have the <crypt.h> header file. */
#cmakedefine HAVE_CRYPT_H

/* Define to 1 if you have the <ctype.h> header file. */
#cmakedefine HAVE_CTYPE_H

/* Define to 1 if you have the declaration of `sys_siglist', and to 0 if you
   don't. */
#cmakedefine HAVE_DECL_SYS_SIGLIST

/* Define to 1 if you have the <dirent.h> header file. */
#cmakedefine HAVE_DIRENT_H

/* Define to 1 if you have the <dir.h> header file. */
#cmakedefine HAVE_DIR_H

/* Define to 1 if you have the <dlfcn.h> header file. */
#cmakedefine HAVE_DLFCN_H

/* Define to 1 if you have the <dl.h> header file. */
#cmakedefine HAVE_DL_H

/* Define if dup3 function is supported */
#cmakedefine HAVE_DUP3

/* Define if EGD is supported */
#cmakedefine HAVE_EGD

/* Define if the epoll interface is supported */
#cmakedefine HAVE_EPOLL

/* Define if epoll_create1 function is supported */
#cmakedefine HAVE_EPOLL_CREATE1

/* Define to 1 if you have the <errno.h> header file. */
#cmakedefine HAVE_ERRNO_H

/* Define to 1 if you have the <fcntl.h> header file. */
#cmakedefine HAVE_FCNTL_H

/* Define to 1 if you have the `fdatasync' function. */
#cmakedefine HAVE_FDATASYNC

/* Define to 1 if you have the `flock' function. */
#cmakedefine HAVE_FLOCK

/* Define to 1 if you have the `fork' function. */
#cmakedefine HAVE_FORK

/* Define if F_SETLK is defined in fcntl.h */
#cmakedefine HAVE_F_SETLK

/* Define if getaddrinfo accepts the AI_ADDRCONFIG flag */
#cmakedefine HAVE_GAI_ADDRCONFIG

/* Define to 1 if you have the `gai_strerror' function. */
#cmakedefine HAVE_GAI_STRERROR

/* Define if getaddrinfo exists and works well enough for APR */
#cmakedefine HAVE_GETADDRINFO

/* Define to 1 if you have the `getenv' function. */
#cmakedefine HAVE_GETENV

/* Define to 1 if you have the `getgrgid_r' function. */
#cmakedefine HAVE_GETGRGID_R

/* Define to 1 if you have the `getgrnam_r' function. */
#cmakedefine HAVE_GETGRNAM_R

/* Define to 1 if you have the `gethostbyaddr_r' function. */
#cmakedefine HAVE_GETHOSTBYADDR_R

/* Define to 1 if you have the `gethostbyname_r' function. */
#cmakedefine HAVE_GETHOSTBYNAME_R

/* Define to 1 if you have the `getifaddrs' function. */
#cmakedefine HAVE_GETIFADDRS

/* Define if getnameinfo exists */
#cmakedefine HAVE_GETNAMEINFO

/* Define to 1 if you have the `getpass' function. */
#cmakedefine HAVE_GETPASS

/* Define to 1 if you have the `getpassphrase' function. */
#cmakedefine HAVE_GETPASSPHRASE

/* Define to 1 if you have the `getpwnam_r' function. */
#cmakedefine HAVE_GETPWNAM_R

/* Define to 1 if you have the `getpwuid_r' function. */
#cmakedefine HAVE_GETPWUID_R

/* Define to 1 if you have the `getrlimit' function. */
#cmakedefine HAVE_GETRLIMIT

/* Define to 1 if you have the `getservbyname_r' function. */
#cmakedefine HAVE_GETSERVBYNAME_R

/* Define to 1 if you have the `gmtime_r' function. */
#cmakedefine HAVE_GMTIME_R

/* Define to 1 if you have the <grp.h> header file. */
#cmakedefine HAVE_GRP_H

/* Define if hstrerror is present */
#cmakedefine HAVE_HSTRERROR

/* Define to 1 if you have the <inttypes.h> header file. */
#cmakedefine01 HAVE_INTTYPES_H

/* Define to 1 if you have the <io.h> header file. */
#cmakedefine HAVE_IO_H

/* Define to 1 if you have the `isinf' function. */
#cmakedefine HAVE_ISINF

/* Define to 1 if you have the `isnan' function. */
#cmakedefine HAVE_ISNAN

/* Define to 1 if you have the <kernel/OS.h> header file. */
#cmakedefine HAVE_KERNEL_OS_H

/* Define to 1 if you have the `kqueue' function. */
#cmakedefine HAVE_KQUEUE

/* Define to 1 if you have the <langinfo.h> header file. */
#cmakedefine HAVE_LANGINFO_H

/* Define to 1 if you have the `bsd' library (-lbsd). */
#cmakedefine HAVE_LIBBSD

/* Define to 1 if you have the `sendfile' library (-lsendfile). */
#cmakedefine HAVE_LIBSENDFILE

/* Define to 1 if you have the `truerand' library (-ltruerand). */
#cmakedefine HAVE_LIBTRUERAND

/* Define to 1 if you have the <limits.h> header file. */
#cmakedefine HAVE_LIMITS_H

/* Define to 1 if you have the `localtime_r' function. */
#cmakedefine HAVE_LOCALTIME_R

/* Define if LOCK_EX is defined in sys/file.h */
#cmakedefine HAVE_LOCK_EX

/* Define to 1 if you have the <mach-o/dyld.h> header file. */
#cmakedefine HAVE_MACH_O_DYLD_H

/* Define to 1 if you have the <malloc.h> header file. */
#cmakedefine HAVE_MALLOC_H

/* Define if MAP_ANON is defined in sys/mman.h */
#cmakedefine HAVE_MAP_ANON

/* Define to 1 if you have the `memchr' function. */
#cmakedefine HAVE_MEMCHR

/* Define to 1 if you have the `memmove' function. */
#cmakedefine HAVE_MEMMOVE

/* Define to 1 if you have the <memory.h> header file. */
#cmakedefine HAVE_MEMORY_H

/* Define to 1 if you have the `mkstemp' function. */
#cmakedefine HAVE_MKSTEMP

/* Define to 1 if you have the `mkstemp64' function. */
#cmakedefine HAVE_MKSTEMP64

/* Define to 1 if you have the `mmap' function. */
#cmakedefine HAVE_MMAP

/* Define to 1 if you have the `mmap64' function. */
#cmakedefine HAVE_MMAP64

/* Define to 1 if you have the `munmap' function. */
#cmakedefine HAVE_MUNMAP

/* Define to 1 if you have the <netdb.h> header file. */
#cmakedefine HAVE_NETDB_H

/* Define to 1 if you have the <netinet/in.h> header file. */
#cmakedefine HAVE_NETINET_IN_H

/* Define to 1 if you have the <netinet/sctp.h> header file. */
#cmakedefine HAVE_NETINET_SCTP_H

/* Define to 1 if you have the <netinet/sctp_uio.h> header file. */
#cmakedefine HAVE_NETINET_SCTP_UIO_H

/* Defined if netinet/tcp.h is present */
#cmakedefine HAVE_NETINET_TCP_H

/* Define to 1 if you have the <net/errno.h> header file. */
#cmakedefine HAVE_NET_ERRNO_H

/* Define to 1 if you have the `nl_langinfo' function. */
#cmakedefine HAVE_NL_LANGINFO

/* Define to 1 if you have the <os2.h> header file. */
#cmakedefine HAVE_OS2_H

/* Define to 1 if you have the <osreldate.h> header file. */
#cmakedefine HAVE_OSRELDATE_H

/* Define to 1 if you have the <OS.h> header file. */
#cmakedefine HAVE_OS_H

/* Define to 1 if you have the `poll' function. */
#cmakedefine HAVE_POLL

/* Define if POLLIN is defined */
#cmakedefine HAVE_POLLIN

/* Define to 1 if you have the <poll.h> header file. */
#cmakedefine01 HAVE_POLL_H

/* Define to 1 if you have the `port_create' function. */
#cmakedefine HAVE_PORT_CREATE

/* Define to 1 if you have the <process.h> header file. */
#cmakedefine HAVE_PROCESS_H

/* Define to 1 if you have the `pthread_attr_setguardsize' function. */
#cmakedefine HAVE_PTHREAD_ATTR_SETGUARDSIZE

/* Define to 1 if you have the <pthread.h> header file. */
#cmakedefine HAVE_PTHREAD_H

/* Define to 1 if you have the `pthread_key_delete' function. */
#cmakedefine HAVE_PTHREAD_KEY_DELETE

/* Define to 1 if you have the `pthread_mutexattr_setpshared' function. */
#cmakedefine HAVE_PTHREAD_MUTEXATTR_SETPSHARED

/* Define if recursive pthread mutexes are available */
#cmakedefine HAVE_PTHREAD_MUTEX_RECURSIVE

/* Define if cross-process robust mutexes are available */
#cmakedefine HAVE_PTHREAD_MUTEX_ROBUST

/* Define if PTHREAD_PROCESS_SHARED is defined in pthread.h */
#cmakedefine HAVE_PTHREAD_PROCESS_SHARED

/* Define if pthread rwlocks are available */
#cmakedefine HAVE_PTHREAD_RWLOCKS

/* Define to 1 if you have the `pthread_rwlock_init' function. */
#cmakedefine HAVE_PTHREAD_RWLOCK_INIT

/* Define to 1 if you have the `pthread_yield' function. */
#cmakedefine HAVE_PTHREAD_YIELD

/* Define to 1 if you have the `putenv' function. */
#cmakedefine HAVE_PUTENV

/* Define to 1 if you have the <pwd.h> header file. */
#cmakedefine HAVE_PWD_H

/* Define to 1 if you have the `readdir64_r' function. */
#cmakedefine HAVE_READDIR64_R

/* Define to 1 if you have the <sched.h> header file. */
#cmakedefine01 HAVE_SCHED_H

/* Define to 1 if you have the `sched_yield' function. */
#cmakedefine HAVE_SCHED_YIELD

/* Define to 1 if you have the <semaphore.h> header file. */
#cmakedefine HAVE_SEMAPHORE_H

/* Define to 1 if you have the `semctl' function. */
#cmakedefine HAVE_SEMCTL

/* Define to 1 if you have the `semget' function. */
#cmakedefine HAVE_SEMGET

/* Define to 1 if you have the `sem_close' function. */
#cmakedefine HAVE_SEM_CLOSE

/* Define to 1 if you have the `sem_post' function. */
#cmakedefine HAVE_SEM_POST

/* Define if SEM_UNDO is defined in sys/sem.h */
#cmakedefine HAVE_SEM_UNDO

/* Define to 1 if you have the `sem_unlink' function. */
#cmakedefine HAVE_SEM_UNLINK

/* Define to 1 if you have the `sem_wait' function. */
#cmakedefine HAVE_SEM_WAIT

/* Define to 1 if you have the `sendfile' function. */
#cmakedefine HAVE_SENDFILE

/* Define to 1 if you have the `sendfile64' function. */
#cmakedefine HAVE_SENDFILE64

/* Define to 1 if you have the `sendfilev' function. */
#cmakedefine HAVE_SENDFILEV

/* Define to 1 if you have the `sendfilev64' function. */
#cmakedefine HAVE_SENDFILEV64

/* Define to 1 if you have the `send_file' function. */
#cmakedefine HAVE_SEND_FILE

/* Define to 1 if you have the `setenv' function. */
#cmakedefine HAVE_SETENV

/* Define to 1 if you have the `setrlimit' function. */
#cmakedefine HAVE_SETRLIMIT

/* Define to 1 if you have the `setsid' function. */
#cmakedefine HAVE_SETSID

/* Define to 1 if you have the `set_h_errno' function. */
#cmakedefine HAVE_SET_H_ERRNO

/* Define to 1 if you have the `shmat' function. */
#cmakedefine HAVE_SHMAT

/* Define to 1 if you have the `shmctl' function. */
#cmakedefine HAVE_SHMCTL

/* Define to 1 if you have the `shmdt' function. */
#cmakedefine HAVE_SHMDT

/* Define to 1 if you have the `shmget' function. */
#cmakedefine HAVE_SHMGET

/* Define to 1 if you have the `shm_open' function. */
#cmakedefine HAVE_SHM_OPEN

/* Define to 1 if you have the `shm_unlink' function. */
#cmakedefine HAVE_SHM_UNLINK

/* Define to 1 if you have the `sigaction' function. */
#cmakedefine HAVE_SIGACTION

/* Define to 1 if you have the <signal.h> header file. */
#cmakedefine HAVE_SIGNAL_H

/* Define to 1 if you have the `sigsuspend' function. */
#cmakedefine HAVE_SIGSUSPEND

/* Define to 1 if you have the `sigwait' function. */
#cmakedefine HAVE_SIGWAIT

/* Whether you have socklen_t */
#cmakedefine HAVE_SOCKLEN_T

/* Define if the SOCK_CLOEXEC flag is supported */
#cmakedefine HAVE_SOCK_CLOEXEC

/* Define if SO_ACCEPTFILTER is defined in sys/socket.h */
#cmakedefine HAVE_SO_ACCEPTFILTER

/* Define to 1 if you have the <stdarg.h> header file. */
#cmakedefine HAVE_STDARG_H

/* Define to 1 if you have the <stddef.h> header file. */
#cmakedefine HAVE_STDDEF_H

/* Define to 1 if you have the <stdint.h> header file. */
#cmakedefine HAVE_STDINT_H

/* Define to 1 if you have the <stdio.h> header file. */
#cmakedefine HAVE_STDIO_H

/* Define to 1 if you have the <stdlib.h> header file. */
#cmakedefine HAVE_STDLIB_H

/* Define to 1 if you have the `strcasecmp' function. */
#cmakedefine HAVE_STRCASECMP

/* Define to 1 if you have the `strdup' function. */
#cmakedefine HAVE_STRDUP

/* Define to 1 if you have the `strerror_r' function. */
#cmakedefine HAVE_STRERROR_R

/* Define to 1 if you have the `stricmp' function. */
#cmakedefine HAVE_STRICMP

/* Define to 1 if you have the <strings.h> header file. */
#cmakedefine HAVE_STRINGS_H

/* Define to 1 if you have the <string.h> header file. */
#cmakedefine HAVE_STRING_H

/* Define to 1 if you have the `strncasecmp' function. */
#cmakedefine HAVE_STRNCASECMP

/* Define to 1 if you have the `strnicmp' function. */
#cmakedefine HAVE_STRNICMP

/* Define to 1 if you have the `strstr' function. */
#cmakedefine HAVE_STRSTR

/* Define if struct impreq was found */
#cmakedefine HAVE_STRUCT_IPMREQ

/* Define to 1 if `st_atimensec' is a member of `struct stat'. */
#cmakedefine HAVE_STRUCT_STAT_ST_ATIMENSEC

/* Define to 1 if `st_atime_n' is a member of `struct stat'. */
#cmakedefine HAVE_STRUCT_STAT_ST_ATIME_N

/* Define to 1 if `st_atim.tv_nsec' is a member of `struct stat'. */
#cmakedefine HAVE_STRUCT_STAT_ST_ATIM_TV_NSEC

/* Define to 1 if `st_blocks' is a member of `struct stat'. */
#cmakedefine HAVE_STRUCT_STAT_ST_BLOCKS

/* Define to 1 if `st_ctimensec' is a member of `struct stat'. */
#cmakedefine HAVE_STRUCT_STAT_ST_CTIMENSEC

/* Define to 1 if `st_ctime_n' is a member of `struct stat'. */
#cmakedefine HAVE_STRUCT_STAT_ST_CTIME_N

/* Define to 1 if `st_ctim.tv_nsec' is a member of `struct stat'. */
#cmakedefine HAVE_STRUCT_STAT_ST_CTIM_TV_NSEC

/* Define to 1 if `st_mtimensec' is a member of `struct stat'. */
#cmakedefine HAVE_STRUCT_STAT_ST_MTIMENSEC

/* Define to 1 if `st_mtime_n' is a member of `struct stat'. */
#cmakedefine HAVE_STRUCT_STAT_ST_MTIME_N

/* Define to 1 if `st_mtim.tv_nsec' is a member of `struct stat'. */
#cmakedefine HAVE_STRUCT_STAT_ST_MTIM_TV_NSEC

/* Define to 1 if `tm_gmtoff' is a member of `struct tm'. */
#cmakedefine HAVE_STRUCT_TM_TM_GMTOFF

/* Define to 1 if `__tm_gmtoff' is a member of `struct tm'. */
#cmakedefine HAVE_STRUCT_TM___TM_GMTOFF

/* Define to 1 if you have the <sysapi.h> header file. */
#cmakedefine HAVE_SYSAPI_H

/* Define to 1 if you have the <sysgtime.h> header file. */
#cmakedefine HAVE_SYSGTIME_H

/* Define to 1 if you have the <sys/file.h> header file. */
#cmakedefine HAVE_SYS_FILE_H

/* Define to 1 if you have the <sys/ioctl.h> header file. */
#cmakedefine HAVE_SYS_IOCTL_H

/* Define to 1 if you have the <sys/ipc.h> header file. */
#cmakedefine HAVE_SYS_IPC_H

/* Define to 1 if you have the <sys/mman.h> header file. */
#cmakedefine HAVE_SYS_MMAN_H

/* Define to 1 if you have the <sys/mutex.h> header file. */
#cmakedefine HAVE_SYS_MUTEX_H

/* Define to 1 if you have the <sys/param.h> header file. */
#cmakedefine HAVE_SYS_PARAM_H

/* Define to 1 if you have the <sys/poll.h> header file. */
#cmakedefine01 HAVE_SYS_POLL_H

/* Define to 1 if you have the <sys/resource.h> header file. */
#cmakedefine HAVE_SYS_RESOURCE_H

/* Define to 1 if you have the <sys/select.h> header file. */
#cmakedefine HAVE_SYS_SELECT_H

/* Define to 1 if you have the <sys/sem.h> header file. */
#cmakedefine HAVE_SYS_SEM_H

/* Define to 1 if you have the <sys/sendfile.h> header file. */
#cmakedefine HAVE_SYS_SENDFILE_H

/* Define to 1 if you have the <sys/shm.h> header file. */
#cmakedefine HAVE_SYS_SHM_H

/* Define to 1 if you have the <sys/signal.h> header file. */
#cmakedefine HAVE_SYS_SIGNAL_H

/* Define to 1 if you have the <sys/socket.h> header file. */
#cmakedefine HAVE_SYS_SOCKET_H

/* Define to 1 if you have the <sys/sockio.h> header file. */
#cmakedefine HAVE_SYS_SOCKIO_H

/* Define to 1 if you have the <sys/stat.h> header file. */
#cmakedefine HAVE_SYS_STAT_H

/* Define to 1 if you have the <sys/sysctl.h> header file. */
#cmakedefine HAVE_SYS_SYSCTL_H

/* Define to 1 if you have the <sys/syslimits.h> header file. */
#cmakedefine HAVE_SYS_SYSLIMITS_H

/* Define to 1 if you have the <sys/time.h> header file. */
#cmakedefine HAVE_SYS_TIME_H

/* Define to 1 if you have the <sys/types.h> header file. */
#cmakedefine HAVE_SYS_TYPES_H

/* Define to 1 if you have the <sys/uio.h> header file. */
#cmakedefine HAVE_SYS_UIO_H

/* Define to 1 if you have the <sys/un.h> header file. */
#cmakedefine HAVE_SYS_UN_H

/* Define to 1 if you have the <sys/uuid.h> header file. */
#cmakedefine HAVE_SYS_UUID_H

/* Define to 1 if you have the <sys/wait.h> header file. */
#cmakedefine HAVE_SYS_WAIT_H

/* Define if TCP_CORK is defined in netinet/tcp.h */
#cmakedefine HAVE_TCP_CORK

/* Define if TCP_NODELAY and TCP_CORK can be enabled at the same time */
#cmakedefine HAVE_TCP_NODELAY_WITH_CORK

/* Define if TCP_NOPUSH is defined in netinet/tcp.h */
#cmakedefine HAVE_TCP_NOPUSH

/* Define to 1 if you have the <termios.h> header file. */
#cmakedefine HAVE_TERMIOS_H

/* Define to 1 if you have the <time.h> header file. */
#cmakedefine HAVE_TIME_H

/* Define to 1 if you have the <tpfeq.h> header file. */
#cmakedefine HAVE_TPFEQ_H

/* Define to 1 if you have the <tpfio.h> header file. */
#cmakedefine HAVE_TPFIO_H

/* Define if truerand is supported */
#cmakedefine HAVE_TRUERAND

/* Define to 1 if you have the <unistd.h> header file. */
#cmakedefine HAVE_UNISTD_H

/* Define to 1 if you have the <unix.h> header file. */
#cmakedefine HAVE_UNIX_H

/* Define to 1 if you have the `unsetenv' function. */
#cmakedefine HAVE_UNSETENV

/* Define to 1 if you have the `utime' function. */
#cmakedefine HAVE_UTIME

/* Define to 1 if you have the `utimes' function. */
#cmakedefine HAVE_UTIMES

/* Define to 1 if you have the `uuid_create' function. */
#cmakedefine HAVE_UUID_CREATE

/* Define to 1 if you have the `uuid_generate' function. */
#cmakedefine HAVE_UUID_GENERATE

/* Define to 1 if you have the <uuid.h> header file. */
#cmakedefine HAVE_UUID_H

/* Define to 1 if you have the <uuid/uuid.h> header file. */
#cmakedefine HAVE_UUID_UUID_H

/* Define if C compiler supports VLA */
#cmakedefine HAVE_VLA

/* Define to 1 if you have the `waitpid' function. */
#cmakedefine HAVE_WAITPID

/* Define to 1 if you have the <windows.h> header file. */
#cmakedefine HAVE_WINDOWS_H

/* Define to 1 if you have the <winsock2.h> header file. */
#cmakedefine HAVE_WINSOCK2_H

/* Define to 1 if you have the `writev' function. */
#cmakedefine HAVE_WRITEV

/* Define for z/OS pthread API nuances */
#cmakedefine HAVE_ZOS_PTHREADS

/* Define to the sub-directory in which libtool stores uninstalled libraries.
   */
#cmakedefine LT_OBJDIR

/* Define if EAI_ error codes from getaddrinfo are negative */
#cmakedefine NEGATIVE_EAI

/* Define to the address where bug reports for this package should be sent. */
#cmakedefine PACKAGE_BUGREPORT

/* Define to the full name of this package. */
#cmakedefine PACKAGE_NAME

/* Define to the full name and version of this package. */
#cmakedefine PACKAGE_STRING

/* Define to the one symbol short name of this package. */
#cmakedefine PACKAGE_TARNAME

/* Define to the home page for this package. */
#cmakedefine PACKAGE_URL

/* Define to the version of this package. */
#cmakedefine PACKAGE_VERSION

/* Define if POSIX semaphores affect threads within the process */
#cmakedefine POSIXSEM_IS_GLOBAL

/* Define on PowerPC 405 where errata 77 applies */
#cmakedefine PPC405_ERRATA

/* Define if pthread_attr_getdetachstate() has one arg */
#cmakedefine PTHREAD_ATTR_GETDETACHSTATE_TAKES_ONE_ARG

/* Define if pthread_getspecific() has two args */
#cmakedefine PTHREAD_GETSPECIFIC_TAKES_TWO_ARGS

/* Define if readdir is thread safe */
#cmakedefine READDIR_IS_THREAD_SAFE

/* Define to 1 if the `setpgrp' function takes no argument. */
#cmakedefine SETPGRP_VOID

/* */
#cmakedefine SIGWAIT_TAKES_ONE_ARG

/* The size of `char', as computed by sizeof. */
#cmakedefine SIZEOF_CHAR

/* The size of ino_t */
#cmakedefine SIZEOF_INO_T

/* The size of `int', as computed by sizeof. */
#cmakedefine SIZEOF_INT

/* The size of `long', as computed by sizeof. */
#cmakedefine SIZEOF_LONG

/* The size of `long long', as computed by sizeof. */
#cmakedefine SIZEOF_LONG_LONG

/* The size of off_t */
#cmakedefine SIZEOF_OFF_T

/* The size of pid_t */
#cmakedefine SIZEOF_PID_T

/* The size of `short', as computed by sizeof. */
#cmakedefine SIZEOF_SHORT

/* The size of size_t */
#cmakedefine SIZEOF_SIZE_T

/* The size of ssize_t */
#cmakedefine SIZEOF_SSIZE_T

/* The size of struct iovec */
#cmakedefine SIZEOF_STRUCT_IOVEC

/* The size of `void*', as computed by sizeof. */
#cmakedefine SIZEOF_VOIDP

/* If using the C implementation of alloca, define if you know the
   direction of stack growth for your system; otherwise it will be
   automatically deduced at runtime.
	STACK_DIRECTION > 0 => grows toward higher addresses
	STACK_DIRECTION < 0 => grows toward lower addresses
	STACK_DIRECTION = 0 => direction of growth unknown */
#cmakedefine STACK_DIRECTION

/* Define to 1 if you have the ANSI C header files. */
#cmakedefine STDC_HEADERS

/* Define if strerror returns int */
#cmakedefine STRERROR_R_RC_INT

/* Define if SysV semaphores affect threads within the process */
#cmakedefine SYSVSEM_IS_GLOBAL

/* Define if use of generic atomics is requested */
#cmakedefine USE_ATOMICS_GENERIC

/* Define if BeOS Semaphores will be used */
#cmakedefine USE_BEOSSEM

/* Define if SVR4-style fcntl() will be used */
#cmakedefine USE_FCNTL_SERIALIZE

/* Define if 4.2BSD-style flock() will be used */
#cmakedefine USE_FLOCK_SERIALIZE

/* Define if BeOS areas will be used */
#cmakedefine USE_SHMEM_BEOS

/* Define if BeOS areas will be used */
#cmakedefine USE_SHMEM_BEOS_ANON

/* Define if 4.4BSD-style mmap() via MAP_ANON will be used */
#cmakedefine USE_SHMEM_MMAP_ANON

/* Define if mmap() via POSIX.1 shm_open() on temporary file will be used */
#cmakedefine USE_SHMEM_MMAP_SHM

/* Define if Classical mmap() on temporary file will be used */
#cmakedefine USE_SHMEM_MMAP_TMP

/* Define if SVR4-style mmap() on /dev/zero will be used */
#cmakedefine USE_SHMEM_MMAP_ZERO

/* Define if OS/2 DosAllocSharedMem() will be used */
#cmakedefine USE_SHMEM_OS2

/* Define if OS/2 DosAllocSharedMem() will be used */
#cmakedefine USE_SHMEM_OS2_ANON

/* Define if SysV IPC shmget() will be used */
#cmakedefine USE_SHMEM_SHMGET

/* Define if SysV IPC shmget() will be used */
#cmakedefine USE_SHMEM_SHMGET_ANON

/* Define if Windows shared memory will be used */
#cmakedefine USE_SHMEM_WIN32

/* Define if Windows CreateFileMapping() will be used */
#cmakedefine USE_SHMEM_WIN32_ANON

/* Enable extensions on AIX 3, Interix.  */
#ifndef _ALL_SOURCE
# undef _ALL_SOURCE
#endif
/* Enable GNU extensions on systems that have them.  */
#ifndef _GNU_SOURCE
# undef _GNU_SOURCE
#endif
/* Enable threading extensions on Solaris.  */
#ifndef _POSIX_PTHREAD_SEMANTICS
# undef _POSIX_PTHREAD_SEMANTICS
#endif
/* Enable extensions on HP NonStop.  */
#ifndef _TANDEM_SOURCE
# undef _TANDEM_SOURCE
#endif
/* Enable general extensions on Solaris.  */
#ifndef __EXTENSIONS__
# undef __EXTENSIONS__
#endif


/* Define if SysV IPC semget() will be used */
#cmakedefine USE_SYSVSEM_SERIALIZE

/* Define if apr_wait_for_io_or_timeout() uses poll(2) */
#cmakedefine WAITIO_USES_POLL

/* Define WORDS_BIGENDIAN to 1 if your processor stores words with the most
   significant byte first (like Motorola and SPARC, unlike Intel). */
#if defined AC_APPLE_UNIVERSAL_BUILD
# if defined __BIG_ENDIAN__
#  define WORDS_BIGENDIAN 1
# endif
#else
# ifndef WORDS_BIGENDIAN
#  undef WORDS_BIGENDIAN
# endif
#endif

/* Define to 1 if on MINIX. */
#cmakedefine _MINIX

/* Define to 2 if the system does not provide POSIX.1 features except with
   this defined. */
#cmakedefine _POSIX_1_SOURCE

/* Define to 1 if you need to in order for `stat' and other things to work. */
#cmakedefine _POSIX_SOURCE

/* Define to empty if `const' does not conform to ANSI C. */
#cmakedefine const

/* Define to `int' if <sys/types.h> doesn't define. */
#cmakedefine gid_t

/* Define to `__inline__' or `__inline' if that's what the C compiler
   calls it, or to nothing if 'inline' is not supported under any name.  */
#ifndef __cplusplus
#cmakedefine inline
#endif

/* Define to `long int' if <sys/types.h> does not define. */
#cmakedefine off_t

/* Define to `int' if <sys/types.h> does not define. */
#cmakedefine pid_t

/* Define to `unsigned int' if <sys/types.h> does not define. */
#cmakedefine size_t

/* Define to `int' if <sys/types.h> does not define. */
#cmakedefine ssize_t

/* Define to `int' if <sys/types.h> doesn't define. */
#cmakedefine uid_t


/* switch this on if we have a BeOS version below BONE */
#if BEOS && !HAVE_BONE_VERSION
#cmakedefine BEOS_R5 1
#else
#cmakedefine BEOS_BONE 1
#endif

/*
 * Darwin 10's default compiler (gcc42) builds for both 64 and
 * 32 bit architectures unless specifically told not to.
 * In those cases, we need to override types depending on how
 * we're being built at compile time.
 * NOTE: This is an ugly work-around for Darwin's
 * concept of universal binaries, a single package
 * (executable, lib, etc...) which contains both 32
 * and 64 bit versions. The issue is that if APR is
 * built universally, if something else is compiled
 * against it, some bit sizes will depend on whether
 * it is 32 or 64 bit. This is determined by the __LP64__
 * flag. Since we need to support both, we have to
 * handle OS X unqiuely.
 */
#ifdef DARWIN_10

#cmakedefine APR_OFF_T_STRFN
#cmakedefine APR_INT64_STRFN
#cmakedefine SIZEOF_LONG
#cmakedefine SIZEOF_SIZE_T
#cmakedefine SIZEOF_SSIZE_T
#cmakedefine SIZEOF_VOIDP
#cmakedefine SIZEOF_STRUCT_IOVEC

#ifdef __LP64__
 #cmakedefine APR_INT64_STRFN strtol
 #cmakedefine SIZEOF_LONG    8
 #cmakedefine SIZEOF_SIZE_T  8
 #cmakedefine SIZEOF_SSIZE_T 8
 #cmakedefine SIZEOF_VOIDP   8
 #cmakedefine SIZEOF_STRUCT_IOVEC 16
#else
 #cmakedefine APR_INT64_STRFN strtoll
 #cmakedefine SIZEOF_LONG    4
 #cmakedefine SIZEOF_SIZE_T  4
 #cmakedefine SIZEOF_SSIZE_T 4
 #cmakedefine SIZEOF_VOIDP   4
 #cmakedefine SIZEOF_STRUCT_IOVEC 8
#endif

#cmakedefine APR_OFF_T_STRFN
#cmakedefine APR_OFF_T_STRFN APR_INT64_STRFN
 

#cmakedefine SETPGRP_VOID
#ifdef __DARWIN_UNIX03
 #cmakedefine SETPGRP_VOID 1
#else
/* #cmakedefine SETPGRP_VOID */
#endif
 
#endif /* DARWIN_10 */

/*
 * Include common private declarations.
 */
#include "../apr_private_common.h"
#endif /* APR_PRIVATE_H */

