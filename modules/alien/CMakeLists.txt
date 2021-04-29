# Copyright (C) 2007-2012 LuaDist.
# Created by Peter Drahos, Peter Kapec
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( alien C )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

if ( WIN32 )
  add_definitions ( -DWINDOWS )
  if ( MSVC )
    add_definitions ( -D_MSC_VER )
  endif ( )
elseif ( UNIX )
add_definitions ( -DLINUX )
elseif ( APPLE )
add_definitions ( -DDARWIN )
endif ( )

if ( APPLE )
  set ( CMAKE_C_FLAGS "-bundle -undefined dynamic_lookup" )
elseif ( UNIX )
set ( CMAKE_C_FLAGS "-fno-stack-protector" )
endif ( )

# Find LibFFI
find_package ( FFI REQUIRED )
include_directories ( ${CMAKE_CURRENT_SOURCE_DIR} ${FFI_INCLUDE_DIRS} )

install_lua_module ( alien_c src/alien.c LINK ${FFI_LIBRARY} )
install_lua_module ( alien src/alien.lua )
install_doc ( doc/ )
install_example ( samples/ )

# Testing....
add_library ( alientest MODULE tests/alientest.c )
install ( TARGETS alientest DESTINATION ${INSTALL_TEST} COMPONENT Test)
install_test ( tests/test_alien.lua )
#add_lua_test ( tests/test_alien.lua )
