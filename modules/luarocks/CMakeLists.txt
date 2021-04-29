# Copyright (C) 2012 - 2014 LuaDist.
# Created by Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

# C project specification is needed as MinGW would not be detected otherwise
project ( luarocks C )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

# Settings
set ( LUAROCKS_PREFIX ${CMAKE_INSTALL_PREFIX}/ CACHE STRING "Prefix where LuaRocks should be installed." )
set ( LUAROCKS_SYSCONFDIR ${INSTALL_ETC} CACHE STRING "Location where the config file should be installed." )
set ( LUAROCKS_ROCKS_TREE ${INSTALL_DATA}/rocks CACHE STRING "Root of the local tree of installed rocks." )
set ( LUAROCKS_FORCE_CONFIG true CACHE STRING "Use a single config location. Do not use the LUAROCKS_CONFIG variable or the user's home directory. Useful to avoid conflicts when LuaRocks is embedded within an application. (true|false)" )
set ( LUAROCKS_LUA_BIN lua CACHE STRING "Name of the lua executable." )
set ( LUAROCKS_LUA_LIB lua CACHE STRING "Name of the lua library to link against when using builtin build-type." )
set ( LUAROCKS_LUA_BINDIR ${INSTALL_BIN} CACHE STRING "You can also specify Lua's binary dir." )
set ( LUAROCKS_LUA_INCDIR ${INSTALL_INC} CACHE STRING "You can also specify Lua's includes dir." )
set ( LUAROCKS_LUA_LIBDIR ${INSTALL_LIB} CACHE STRING "You can also specify Lua's libraries dir." )
set ( LUAROCKS_DOWNLOADER curl CACHE STRING "Which tool to use as a downloader. (wget|curl)" )
set ( LUAROCKS_MD5CHECKER md5 CACHE STRING "Which tool to use for checksum. (md5sum|openssl|md5)" )

# System detection
set ( LUAROCKS_UNAME_S Unix CACHE STRING "Detected system." Unknown )
if ( CYGWIN )
  set ( LUAROCKS_UNAME_S CYGWIN )
elseif ( MINGW )
  set ( LUAROCKS_UNAME_S MINGW )
  install ( FILES mingw.cfg DESTINATION ${INSTALL_ETC} RENAME luarocks.cfg COMPONENT Runtime )
elseif ( WIN32 )
  set ( LUAROCKS_UNAME_S Windows )
elseif ( LINUX )
  set ( LUAROCKS_UNAME_S Linux )
elseif ( APPLE )
 set ( LUAROCKS_UNAME_S Darwin )
endif ( )

# Architecture detection
set ( LUAROCKS_UNAME_M x86 CACHE STRING "Detected architecture." )
if ( CMAKE_SIZEOF_VOID_P EQUAL 8 )
  set ( LUAROCKS_UNAME_M x86_64 )
endif ( )

# Generate site_config.lua file
configure_file ( config.in ${CMAKE_CURRENT_SOURCE_DIR}/src/luarocks/site_config.lua 
  @ONLY )

# Install Everything
install ( DIRECTORY src/luarocks DESTINATION ${INSTALL_LMOD} COMPONENT Runtime )
install_lua_executable ( luarocks src/bin/luarocks )
install_lua_executable ( luarocks-admin src/bin/luarocks-admin )

install_data ( COPYING COPYING_7z COPYING_lua README.md )
install_data ( COPYING INTO rocks )
install_test ( test/ )
