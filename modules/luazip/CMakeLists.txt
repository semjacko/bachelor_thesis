# Copyright (C) 2007-2012 LuaDist.
# Created by Peter Kapec
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( luazip C )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

# Zlib library needed
find_package ( ZLIB REQUIRED )
include_directories ( ${ZLIB_INCLUDE_DIR} )

# zziplib library needed
find_package ( zziplib REQUIRED )
include_directories ( ${ZZIPLIB_INCLUDE_DIRS} )

include_directories ( src )

install_lua_module ( zip src/luazip.c src/luazip.def LINK ${ZZIPLIB_LIBRARIES} ${ZLIB_LIBRARIES} )

add_lua_test ( tests/test_zip.lua WORKING_DIRECTORY tests )

install_data ( README )
install_doc ( doc/ )
install_test ( tests )
