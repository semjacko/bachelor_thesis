# Copyright (C) 2008 MySQL AB
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#

#
# Tests for header files
#
INCLUDE (CheckIncludeFiles)

CHECK_INCLUDE_FILES (alloca.h HAVE_ALLOCA_H)
CHECK_INCLUDE_FILES (arpa/inet.h HAVE_ARPA_INET_H)
CHECK_INCLUDE_FILES (crypt.h HAVE_CRYPT_H)
CHECK_INCLUDE_FILES (dirent.h HAVE_DIRENT_H)
CHECK_INCLUDE_FILES (execinfo.h HAVE_EXECINFO_H)
CHECK_INCLUDE_FILES (fcntl.h HAVE_FCNTL_H)
CHECK_INCLUDE_FILES (fenv.h HAVE_FENV_H)
CHECK_INCLUDE_FILES (float.h HAVE_FLOAT_H)
CHECK_INCLUDE_FILES (fpu/control.h HAVE_FPU_CONTROL_H)
CHECK_INCLUDE_FILES (grp.h HAVE_GRP_H)
CHECK_INCLUDE_FILES (ieeefp.h HAVE_IEEEFP_H)
CHECK_INCLUDE_FILES (limits.h HAVE_LIMITS_H)
CHECK_INCLUDE_FILES (malloc.h HAVE_MALLOC_H)
CHECK_INCLUDE_FILES (memory.h HAVE_MEMORY_H)
CHECK_INCLUDE_FILES (netinet/in.h HAVE_NETINET_IN_H)
CHECK_INCLUDE_FILES (paths.h HAVE_PATHS_H)
CHECK_INCLUDE_FILES (pwd.h HAVE_PWD_H)
CHECK_INCLUDE_FILES (sched.h HAVE_SCHED_H)
CHECK_INCLUDE_FILES (select.h HAVE_SELECT_H)
CHECK_INCLUDE_FILES (stddef.h HAVE_STDDEF_H)
CHECK_INCLUDE_FILES (stdint.h HAVE_STDINT_H)
CHECK_INCLUDE_FILES (stdlib.h HAVE_STDLIB_H)
CHECK_INCLUDE_FILES (strings.h HAVE_STRINGS_H)
CHECK_INCLUDE_FILES (string.h HAVE_STRING_H)
CHECK_INCLUDE_FILES (synch.h HAVE_SYNCH_H)
CHECK_INCLUDE_FILES (sysent.h HAVE_SYSENT_H)
CHECK_INCLUDE_FILES (sys/fpu.h HAVE_SYS_FPU_H)
CHECK_INCLUDE_FILES (sys/ioctl.h HAVE_SYS_IOCTL_H)
CHECK_INCLUDE_FILES (sys/ipc.h HAVE_SYS_IPC_H)
CHECK_INCLUDE_FILES (sys/mman.h HAVE_SYS_MMAN_H)
CHECK_INCLUDE_FILES (sys/prctl.h HAVE_SYS_PRCTL_H)
CHECK_INCLUDE_FILES (sys/select.h HAVE_SYS_SELECT_H)
CHECK_INCLUDE_FILES (sys/shm.h HAVE_SYS_SHM_H)
CHECK_INCLUDE_FILES (sys/socket.h HAVE_SYS_SOCKET_H)
CHECK_INCLUDE_FILES (sys/stat.h HAVE_SYS_STAT_H)
CHECK_INCLUDE_FILES (sys/stream.h HAVE_SYS_STREAM_H)
CHECK_INCLUDE_FILES (sys/timeb.h HAVE_SYS_TIMEB_H)
CHECK_INCLUDE_FILES (sys/types.h HAVE_SYS_TYPES_H)
CHECK_INCLUDE_FILES (sys/un.h HAVE_SYS_UN_H)
CHECK_INCLUDE_FILES (termios.h HAVE_TERMIOS_H)
CHECK_INCLUDE_FILES (termio.h HAVE_TERMIO_H)
CHECK_INCLUDE_FILES (unistd.h HAVE_UNISTD_H)
CHECK_INCLUDE_FILES (utime.h HAVE_UTIME_H)

#
# Figure out threading library
#
FIND_PACKAGE (Threads)

#
# Decide if we need -lm
#
IF(UNIX)
  FIND_LIBRARY(MATH_LIBRARY m)
  FIND_LIBRARY(SOCKET_LIBRARY socket)
ENDIF(UNIX)

#
# Tests for functions
#
INCLUDE (CheckFunctionExists)

CHECK_FUNCTION_EXISTS (access HAVE_ACCESS)
CHECK_FUNCTION_EXISTS (aiowait HAVE_AIOWAIT)
CHECK_FUNCTION_EXISTS (alarm HAVE_ALARM)
CHECK_FUNCTION_EXISTS (alloca HAVE_ALLOCA)
CHECK_FUNCTION_EXISTS (bcmp HAVE_BCMP)
CHECK_FUNCTION_EXISTS (bfill HAVE_BFILL)
CHECK_FUNCTION_EXISTS (bmove HAVE_BMOVE)
CHECK_FUNCTION_EXISTS (bzero HAVE_BZERO)
CHECK_FUNCTION_EXISTS (clock_gettime HAVE_CLOCK_GETTIME)
CHECK_FUNCTION_EXISTS (compress HAVE_COMPRESS)
CHECK_FUNCTION_EXISTS (crypt HAVE_CRYPT)
CHECK_FUNCTION_EXISTS (dlerror HAVE_DLERROR)
CHECK_FUNCTION_EXISTS (dlopen HAVE_DLOPEN)
CHECK_FUNCTION_EXISTS (fchmod HAVE_FCHMOD)
CHECK_FUNCTION_EXISTS (fcntl HAVE_FCNTL)
CHECK_FUNCTION_EXISTS (fconvert HAVE_FCONVERT)
CHECK_FUNCTION_EXISTS (fdatasync HAVE_FDATASYNC)
CHECK_FUNCTION_EXISTS (fesetround HAVE_FESETROUND)
CHECK_FUNCTION_EXISTS (finite HAVE_FINITE)
CHECK_FUNCTION_EXISTS (fseeko HAVE_FSEEKO)
CHECK_FUNCTION_EXISTS (fsync HAVE_FSYNC)
CHECK_FUNCTION_EXISTS (getaddrinfo HAVE_GETADDRINFO)
CHECK_FUNCTION_EXISTS (getcwd HAVE_GETCWD)
CHECK_FUNCTION_EXISTS (gethostbyaddr_r HAVE_GETHOSTBYADDR_R)
CHECK_FUNCTION_EXISTS (gethostbyname_r HAVE_GETHOSTBYNAME_R)
CHECK_FUNCTION_EXISTS (gethrtime HAVE_GETHRTIME)
CHECK_FUNCTION_EXISTS (getnameinfo HAVE_GETNAMEINFO)
CHECK_FUNCTION_EXISTS (getpagesize HAVE_GETPAGESIZE)
CHECK_FUNCTION_EXISTS (getpass HAVE_GETPASS)
CHECK_FUNCTION_EXISTS (getpassphrase HAVE_GETPASSPHRASE)
CHECK_FUNCTION_EXISTS (getpwnam HAVE_GETPWNAM)
CHECK_FUNCTION_EXISTS (getpwuid HAVE_GETPWUID)
CHECK_FUNCTION_EXISTS (getrlimit HAVE_GETRLIMIT)
CHECK_FUNCTION_EXISTS (getrusage HAVE_GETRUSAGE)
CHECK_FUNCTION_EXISTS (getwd HAVE_GETWD)
CHECK_FUNCTION_EXISTS (gmtime_r HAVE_GMTIME_R)
CHECK_FUNCTION_EXISTS (initgroups HAVE_INITGROUPS)
CHECK_FUNCTION_EXISTS (ldiv HAVE_LDIV)
CHECK_FUNCTION_EXISTS (localtime_r HAVE_LOCALTIME_R)
CHECK_FUNCTION_EXISTS (log2 HAVE_LOG2)
CHECK_FUNCTION_EXISTS (longjmp HAVE_LONGJMP)
CHECK_FUNCTION_EXISTS (lstat HAVE_LSTAT)
CHECK_FUNCTION_EXISTS (madvise HAVE_MADVISE)
CHECK_FUNCTION_EXISTS (mallinfo HAVE_MALLINFO)
CHECK_FUNCTION_EXISTS (memalign HAVE_MEMALIGN)
CHECK_FUNCTION_EXISTS (memcpy HAVE_MEMCPY)
CHECK_FUNCTION_EXISTS (memmove HAVE_MEMMOVE)
CHECK_FUNCTION_EXISTS (mkstemp HAVE_MKSTEMP)
CHECK_FUNCTION_EXISTS (mlock HAVE_MLOCK)
CHECK_FUNCTION_EXISTS (mlockall HAVE_MLOCKALL)
CHECK_FUNCTION_EXISTS (mmap HAVE_MMAP)
CHECK_FUNCTION_EXISTS (mmap64 HAVE_MMAP64)
CHECK_FUNCTION_EXISTS (perror HAVE_PERROR)
CHECK_FUNCTION_EXISTS (poll HAVE_POLL)
CHECK_FUNCTION_EXISTS (pread HAVE_PREAD)
CHECK_FUNCTION_EXISTS (pthread_attr_create HAVE_PTHREAD_ATTR_CREATE)
CHECK_FUNCTION_EXISTS (pthread_attr_getstacksize HAVE_PTHREAD_ATTR_GETSTACKSIZE)
CHECK_FUNCTION_EXISTS (pthread_attr_setprio HAVE_PTHREAD_ATTR_SETPRIO)
CHECK_FUNCTION_EXISTS (pthread_attr_setschedparam
                       HAVE_PTHREAD_ATTR_SETSCHEDPARAM)
CHECK_FUNCTION_EXISTS (pthread_attr_setscope HAVE_PTHREAD_ATTR_SETSCOPE)
CHECK_FUNCTION_EXISTS (pthread_attr_setstacksize HAVE_PTHREAD_ATTR_SETSTACKSIZE)
CHECK_FUNCTION_EXISTS (pthread_condattr_create HAVE_PTHREAD_CONDATTR_CREATE)
CHECK_FUNCTION_EXISTS (pthread_init HAVE_PTHREAD_INIT)
CHECK_FUNCTION_EXISTS (pthread_key_delete HAVE_PTHREAD_KEY_DELETE)
CHECK_FUNCTION_EXISTS (pthread_kill HAVE_PTHREAD_KILL)
CHECK_FUNCTION_EXISTS (pthread_rwlock_rdlock HAVE_PTHREAD_RWLOCK_RDLOCK)
CHECK_FUNCTION_EXISTS (pthread_setprio_np HAVE_PTHREAD_SETPRIO_NP)
CHECK_FUNCTION_EXISTS (pthread_setschedparam HAVE_PTHREAD_SETSCHEDPARAM)
CHECK_FUNCTION_EXISTS (pthread_sigmask HAVE_PTHREAD_SIGMASK)
CHECK_FUNCTION_EXISTS (pthread_threadmask HAVE_PTHREAD_THREADMASK)
CHECK_FUNCTION_EXISTS (pthread_yield_np HAVE_PTHREAD_YIELD_NP)
CHECK_FUNCTION_EXISTS (readdir_r HAVE_READDIR_R)
CHECK_FUNCTION_EXISTS (readlink HAVE_READLINK)
CHECK_FUNCTION_EXISTS (realpath HAVE_REALPATH)
CHECK_FUNCTION_EXISTS (rename HAVE_RENAME)
CHECK_FUNCTION_EXISTS (sched_yield HAVE_SCHED_YIELD)
CHECK_FUNCTION_EXISTS (select HAVE_SELECT)
CHECK_FUNCTION_EXISTS (setfd HAVE_SETFD)
CHECK_FUNCTION_EXISTS (setfilepointer HAVE_SETFILEPOINTER)
CHECK_FUNCTION_EXISTS (sigaction HAVE_SIGACTION)
CHECK_FUNCTION_EXISTS (sigthreadmask HAVE_SIGTHREADMASK)
CHECK_FUNCTION_EXISTS (sigwait HAVE_SIGWAIT)
CHECK_FUNCTION_EXISTS (sleep HAVE_SLEEP)
CHECK_FUNCTION_EXISTS (snprintf HAVE_SNPRINTF)
CHECK_FUNCTION_EXISTS (stpcpy HAVE_STPCPY)
CHECK_FUNCTION_EXISTS (strerror HAVE_STRERROR)
CHECK_FUNCTION_EXISTS (strlcpy HAVE_STRLCPY)
CHECK_FUNCTION_EXISTS (strnlen HAVE_STRNLEN)
CHECK_FUNCTION_EXISTS (strpbrk HAVE_STRPBRK)
CHECK_FUNCTION_EXISTS (strsep HAVE_STRSEP)
CHECK_FUNCTION_EXISTS (strstr HAVE_STRSTR)
CHECK_FUNCTION_EXISTS (strtok_r HAVE_STRTOK_R)
CHECK_FUNCTION_EXISTS (strtol HAVE_STRTOL)
CHECK_FUNCTION_EXISTS (strtoll HAVE_STRTOLL)
CHECK_FUNCTION_EXISTS (strtoul HAVE_STRTOUL)
CHECK_FUNCTION_EXISTS (strtoull HAVE_STRTOULL)
CHECK_FUNCTION_EXISTS (tell HAVE_TELL)
CHECK_FUNCTION_EXISTS (thr_setconcurrency HAVE_THR_SETCONCURRENCY)
CHECK_FUNCTION_EXISTS (thr_yield HAVE_THR_YIELD)
CHECK_FUNCTION_EXISTS (vasprintf HAVE_VASPRINTF)
CHECK_FUNCTION_EXISTS (vsnprintf HAVE_VSNPRINTF)

#
# Tests for symbols
#
INCLUDE (CheckSymbolExists)

CHECK_SYMBOL_EXISTS(sys_errlist "stdio.h" HAVE_SYS_ERRLIST)
CHECK_SYMBOL_EXISTS(__bss_start "" HAVE_BSS_START)
CHECK_SYMBOL_EXISTS(madvise "sys/mman.h" HAVE_DECL_MADVISE)

#
# Test for endianess
#
#INCLUDE(TestBigEndian)
#TEST_BIG_ENDIAN(WORDS_BIGENDIAN)
set(WORDS_BIGENDIAN FALSE)

#
# Tests for type sizes (and presence)
#
INCLUDE (CheckTypeSize)

SET(CMAKE_EXTRA_INCLUDE_FILES signal.h)
CHECK_TYPE_SIZE(sigset_t SIZEOF_SIGSET_T)
IF(HAVE_STDINT_H)
  SET(CMAKE_EXTRA_INCLUDE_FILES stdint.h)
ENDIF(HAVE_STDINT_H)
CHECK_TYPE_SIZE(char SIZEOF_CHAR)
CHECK_TYPE_SIZE("char *" SIZEOF_CHARP)
CHECK_TYPE_SIZE(short SIZEOF_SHORT)
CHECK_TYPE_SIZE(int SIZEOF_INT)
CHECK_TYPE_SIZE(long SIZEOF_LONG)
CHECK_TYPE_SIZE("long long" SIZEOF_LONG_LONG)
SET(CMAKE_EXTRA_INCLUDE_FILES stdio.h)
CHECK_TYPE_SIZE(size_t SIZEOF_SIZE_T)
SET(CMAKE_EXTRA_INCLUDE_FILES sys/types.h)
CHECK_TYPE_SIZE(off_t SIZEOF_OFF_T)
CHECK_TYPE_SIZE(uchar SIZEOF_UCHAR)
CHECK_TYPE_SIZE(uint SIZEOF_UINT)
CHECK_TYPE_SIZE(ulong SIZEOF_ULONG)
CHECK_TYPE_SIZE(int8 SIZEOF_INT8)
CHECK_TYPE_SIZE(uint8 SIZEOF_UINT8)
CHECK_TYPE_SIZE(int16 SIZEOF_INT16)
CHECK_TYPE_SIZE(uint16 SIZEOF_UINT16)
CHECK_TYPE_SIZE(int32 SIZEOF_INT32)
CHECK_TYPE_SIZE(uint32 SIZEOF_UINT32)
CHECK_TYPE_SIZE(u_int32_t SIZEOF_UINT_32_T)
CHECK_TYPE_SIZE(int64 SIZEOF_INT64)
CHECK_TYPE_SIZE(uint64 SIZEOF_UINT64)

IF(HAVE_SYS_SOCKET_H)
  SET(CMAKE_EXTRA_INCLUDE_FILES sys/socket.h)
ENDIF(HAVE_SYS_SOCKET_H)
CHECK_TYPE_SIZE(socklen_t SIZEOF_SOCKLEN_T)
SET(CMAKE_EXTRA_INCLUDE_FILES)

IF(HAVE_SYS_TYPES_H)
	SET(CMAKE_EXTA_INCLUDE_FILES sys/types.h)
ENDIF(HAVE_SYS_TYPES_H)
CHECK_TYPE_SIZE(ssize_t HAVE_SSIZE_T )
SET(CMAKE_EXTRA_INCLUDE_FILES)

#
# Code tests
#
INCLUDE (CheckCSourceCompiles)

#
# Check if timespec has ts_sec and ts_nsec fields
#
SET(CMAKE_REQUIRED_INCLUDES pthread.h)
CHECK_C_SOURCE_COMPILES("
#include <pthread.h>

int main(int ac, char **av)
{
  struct timespec abstime;
  abstime.ts_sec = time(NULL)+1;
  abstime.ts_nsec = 0;
}
" HAVE_TIMESPEC_TS_SEC)
SET(CMAKE_REQUIRED_INCLUDES)

#
# Check return type of qsort()
#
CHECK_C_SOURCE_COMPILES("
#include <stdlib.h>
#ifdef __cplusplus
extern \"C\"
#endif
void qsort(void *base, size_t nel, size_t width,
  int (*compar) (const void *, const void *));
int main(int ac, char **av) {}
" QSORT_TYPE_IS_VOID)
IF(QSORT_TYPE_IS_VOID)
  SET(RETQSORTTYPE "void")
ELSE(QSORT_TYPE_IS_VOID)
  SET(RETQSORTTYPE "int")
ENDIF(QSORT_TYPE_IS_VOID)

#
# Check return type of signal handlers
#
CHECK_C_SOURCE_COMPILES("
#include <signal.h>
#ifdef signal
# undef signal
#endif
#ifdef __cplusplus
extern \"C\" void (*signal (int, void (*)(int)))(int);
#else
void (*signal ()) ();
#endif
int main(int ac, char **av) {}
" SIGNAL_RETURN_TYPE_IS_VOID)
IF(SIGNAL_RETURN_TYPE_IS_VOID)
  SET(RETSIGTYPE "void")
ELSE(SIGNAL_RETURN_TYPE_IS_VOID)
  SET(RETSIGTYPE "int")
ENDIF(SIGNAL_RETURN_TYPE_IS_VOID)

#
# isnan() is trickier than the usual function test -- it may be a macro
#
IF(MATH_LIBRARY)
  SET(CMAKE_REQUIRED_LIBRARIES "${MATH_LIBRARY}")
ENDIF(MATH_LIBRARY)
CHECK_C_SOURCE_COMPILES("#include <math.h>
  int main(int ac, char **av)
  {
    isnan(0.0);
    return 0;
  }"
  HAVE_ISNAN)
CHECK_C_SOURCE_COMPILES("#include <math.h>
  int main(int ac, char **av)
  {
    (void)rint(0.0);
    return 0;
  }"
  HAVE_RINT)
SET(CMAKE_REQUIRED_LIBRARIES "")

#
# Test for how the C compiler does inline, if at all
#
FOREACH(KEYWORD "inline" "__inline__" "__inline")
  IF(NOT DEFINED C_INLINE)
    CHECK_C_SOURCE_COMPILES("typedef int foo_t;
static inline foo_t static_foo(){return 0;}
foo_t foo(){return 0;}
int main(int argc, char *argv[]){return 0;}"
                            C_HAS_${KEYWORD})
    IF(C_HAS_${KEYWORD})
      SET(C_INLINE ${KEYWORD})
    ENDIF(C_HAS_${KEYWORD})
  ENDIF(NOT DEFINED C_INLINE)
ENDFOREACH(KEYWORD)
IF(NOT DEFINED C_INLINE)
  SET(C_INLINE "")
ENDIF(NOT DEFINED C_INLINE)