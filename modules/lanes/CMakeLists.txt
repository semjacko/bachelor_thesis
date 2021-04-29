# Copyright (C) 2007-20014 LuaDist.
# Created by Peter Kapec
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project( lanes C )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

find_package ( Lua REQUIRED )
find_package ( Threads REQUIRED )

if( UNIX AND NOT CYGWIN )
  add_definitions( -D_GNU_SOURCE )
  set( LIBS ${CMAKE_THREAD_LIBS_INIT} )
endif( UNIX AND NOT CYGWIN )

# Using LuaJIT
if( LUAJIT_VERSION_STRING )
	message("Using LuaJIT:" ${LUAJIT_VERSION_STRING})

	# note: lanes checks via LUA_LJDIR macro (should be defined in luaconf.h) if using LuaJIT
	add_definitions( -DLUA_LJDIR=1)
endif()

# Build
include_directories(src)
set(SRC_LANES src/lanes.c src/deep.c src/threading.c src/tools.c src/keeper.c src/compat.c)

# Install all files and documentation
install_lua_module ( lanes.core ${SRC_LANES} LINK ${LIBS} )

install_lua_module( lanes src/lanes.lua )
install_data( ABOUT BUGS CHANGES COPYRIGHT README TODO )
install_test( tests/ )
