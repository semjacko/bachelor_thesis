## sigar has some base files + a set of platform specific files

message ( STATUS "CMAKE_SYSTEM_NAME is ${CMAKE_SYSTEM_NAME}" )

include_directories ( ../include/ )

include ( CheckCSourceCompiles )

macro ( CHECK_STRUCT_MEMBER _STRUCT _MEMBER _HEADER _RESULT )
set ( _INCLUDE_FILES )
foreach ( it ${_HEADER} )
set ( _INCLUDE_FILES "${_INCLUDE_FILES}#include <${it}>\n" )
endforeach ( it )

set ( _CHECK_STRUCT_MEMBER_SOURCE_CODE " ${_INCLUDE_FILES} int main() { static ${_STRUCT} tmp; if (sizeof(tmp.${_MEMBER})) return 0; return 0; } " )
check_c_source_compiles ( "${_CHECK_STRUCT_MEMBER_SOURCE_CODE}" ${_RESULT} )

endmacro ( CHECK_STRUCT_MEMBER )

## linux
if ( CMAKE_SYSTEM_NAME STREQUAL "Linux" )
  set ( SIGAR_SRC os/linux/linux_sigar.c )

  include_directories ( os/linux/ )
endif ( CMAKE_SYSTEM_NAME STREQUAL "Linux" )

## macosx, freebsd
if ( CMAKE_SYSTEM_NAME MATCHES "(Darwin|FreeBSD)" )
  set ( SIGAR_SRC os/darwin/darwin_sigar.c )

  include_directories ( os/darwin/ )
  if ( CMAKE_SYSTEM_NAME MATCHES "(Darwin)" )
    add_definitions ( -DDARWIN )
    set ( SIGAR_LINK_FLAGS "-framework CoreServices -framework IOKit" )
  else ( CMAKE_SYSTEM_NAME MATCHES "(Darwin)" )
    ## freebsd needs libkvm
    set ( SIGAR_LINK_FLAGS "-lkvm" )
  endif ( CMAKE_SYSTEM_NAME MATCHES "(Darwin)" )
endif ( CMAKE_SYSTEM_NAME MATCHES "(Darwin|FreeBSD)" )

## solaris
if ( CMAKE_SYSTEM_NAME MATCHES "(Solaris|SunOS)" )
  set ( SIGAR_SRC os/solaris/solaris_sigar.c os/solaris/get_mib2.c os/solaris/kstats.c 
    os/solaris/procfs.c )

  include_directories ( os/solaris/ )
  add_definitions ( -DSOLARIS )
  set ( SIGAR_LINK_FLAGS -lkstat -ldl -lnsl -lsocket -lresolv )
endif ( CMAKE_SYSTEM_NAME MATCHES "(Solaris|SunOS)" )

## solaris
if ( CMAKE_SYSTEM_NAME MATCHES "(hpux)" )
  set ( SIGAR_SRC os/hpux/hpux_sigar.c )
  include_directories ( os/hpux/ )
  add_definitions ( -DSIGAR_HPUX )
  set ( SIGAR_LINK_FLAGS -lnm )
endif ( CMAKE_SYSTEM_NAME MATCHES "(hpux)" )

## aix
if ( CMAKE_SYSTEM_NAME MATCHES "(AIX)" )
  set ( SIGAR_SRC os/aix/aix_sigar.c )

  include_directories ( os/aix/ )
  set ( SIGAR_LINK_FLAGS -lodm -lcfg )
endif ( CMAKE_SYSTEM_NAME MATCHES "(AIX)" )

if ( WIN32 )
  add_definitions ( -DSIGAR_SHARED )
  set ( SIGAR_SRC os/win32/peb.c os/win32/win32_sigar.c )
  include_directories ( os/win32 )
  check_struct_member ( MIB_IPADDRROW wType "windows.h;iphlpapi.h" wType_in_MIB_IPADDRROW )
  add_definitions ( -DHAVE_MIB_IPADDRROW_WTYPE=${wType_in_MIB_IPADDRROW} )
endif ( WIN32 )

set ( SIGAR_SRC ${SIGAR_SRC} sigar.c sigar_cache.c sigar_fileinfo.c sigar_format.c 
  sigar_getline.c sigar_ptql.c sigar_signal.c sigar_util.c sigar_version.c)

add_library ( libsigar SHARED ${SIGAR_SRC} )
set_target_properties ( libsigar PROPERTIES OUTPUT_NAME sigar )

if ( WIN32 )
  target_link_libraries ( libsigar ws2_32 netapi32 version )
endif ( WIN32 )
if ( SIGAR_LINK_FLAGS )
  set_target_properties ( libsigar PROPERTIES LINK_FLAGS "${SIGAR_LINK_FLAGS}" )
endif ( SIGAR_LINK_FLAGS )

install_library ( libsigar )
