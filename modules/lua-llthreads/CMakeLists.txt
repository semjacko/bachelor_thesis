# Copyright (C) 2007-2014 LuaDist.
# Created by Robert G. Jakabosky and modified by Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

cmake_minimum_required ( VERSION 2.8 )

project ( lua-llthreads C )
include ( cmake/dist.cmake )
include ( lua )

set ( LUA_NATIVE_OBJECTS_PATH ../LuaNativeObjects CACHE PATH "Directory to LuaNativeObjects bindings generator." )
set ( USE_PRE_GENERATED_BINDINGS TRUE CACHE BOOL "Set this to FALSE to re-generate bindings using LuaNativeObjects" )

## find threads
set ( CMAKE_THREAD_PREFER_PTHREAD TRUE )
include ( FindThreads )

include_directories ( ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR} )

## LuaLLTHREADS
set ( LUA_LLTHREADS_SRC llthreads.nobj.lua )

if ( USE_PRE_GENERATED_BINDINGS )
	set ( LUA_LLTHREADS_SRC src/pre_generated-llthreads.nobj.c )
else ()
	# Generate Lua bindings.
	## LuaNativeObjects
	include ( LuaNativeObjects )
	GenLuaNativeObjects ( LUA_LLTHREADS_SRC )
endif ()

install_lua_module ( llthreads ${LUA_LLTHREADS_SRC} LINK ${CMAKE_THREAD_LIBS_INIT} )
install_data ( COPYRIGHT README.md )
install_example ( examples/ )
install_test ( tests/ )
