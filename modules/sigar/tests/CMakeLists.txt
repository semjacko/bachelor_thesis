macro ( SIGAR_TEST name )
add_executable ( ${name} ${name}.c )
target_link_libraries ( ${name} libsigar )
add_test ( ${name} ${name} )
endmacro ( SIGAR_TEST name )

include_directories ( ../include/ )

message ( STATUS "CMAKE_SYSTEM_NAME is ${CMAKE_SYSTEM_NAME}" )

## linux
if ( CMAKE_SYSTEM_NAME STREQUAL "Linux" )
  add_definitions ( -DSIGAR_TEST_OS_LINUX )
endif ( CMAKE_SYSTEM_NAME STREQUAL "Linux" )

## macosx, freebsd
if ( CMAKE_SYSTEM_NAME MATCHES "(Darwin|FreeBSD)" )
  add_definitions ( -DSIGAR_TEST_OS_DARWIN )
endif ( CMAKE_SYSTEM_NAME MATCHES "(Darwin|FreeBSD)" )

## solaris
if ( CMAKE_SYSTEM_NAME MATCHES "(Solaris|SunOS)" )
  add_definitions ( -DSIGAR_TEST_OS_SOLARIS )
endif ( CMAKE_SYSTEM_NAME MATCHES "(Solaris|SunOS)" )

## solaris
if ( CMAKE_SYSTEM_NAME MATCHES "(hpux)" )
  add_definitions ( -DSIGAR_TEST_OS_HPUX )
endif ( CMAKE_SYSTEM_NAME MATCHES "(hpux)" )

## aix
if ( CMAKE_SYSTEM_NAME MATCHES "(AIX)" )
  add_definitions ( -DSIGAR_TEST_OS_AIX )
endif ( CMAKE_SYSTEM_NAME MATCHES "(AIX)" )

if ( WIN32 )
  add_definitions ( -DSIGAR_TEST_OS_WIN32 )
endif ( WIN32 )

sigar_test ( t_sigar_cpu )
sigar_test ( t_sigar_fs )
sigar_test ( t_sigar_loadavg )
sigar_test ( t_sigar_mem )
sigar_test ( t_sigar_netconn )
sigar_test ( t_sigar_netif )
sigar_test ( t_sigar_pid )
sigar_test ( t_sigar_proc )
sigar_test ( t_sigar_reslimit )
sigar_test ( t_sigar_swap )
sigar_test ( t_sigar_sysinfo )
sigar_test ( t_sigar_uptime )
# SIGAR_TEST(t_sigar_version)
