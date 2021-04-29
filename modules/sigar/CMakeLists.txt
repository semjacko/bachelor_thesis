project ( sigar C )
cmake_minimum_required ( VERSION 2.6 )
include ( cmake/dist.cmake )
include ( lua )

include ( CheckIncludeFiles )
include ( CheckFunctionExists )
include ( CheckTypeSize )
include ( CTest )
include ( InstallRequiredSystemLibraries )

enable_testing ( )

if ( WIN32 )
  ## make sure we only use the smallest set of 
  ## headers on win32. Otherwise we get clashes 
  ## between winsock2.h and winsock.h
  add_definitions ( -DWIN32_LEAN_AND_MEAN )

  # force the correct version for the redist manifest
  add_definitions ( -D_BIND_TO_CURRENT_MFC_VERSION=1 -D_BIND_TO_CURRENT_CRT_VERSION=1 )
  # turn off security warnings for system calls
  add_definitions ( -D_CRT_SECURE_NO_WARNINGS )
endif ( WIN32 )

include_directories ( include )

add_subdirectory ( src build-src )
add_subdirectory ( tests build-tests )
add_subdirectory ( include build-include )
add_subdirectory ( bindings/lua build-lua )

install_data ( LICENSE README NOTICE )
