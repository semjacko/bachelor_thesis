# Copyright (C) 2007-2012 LuaDist.
# Created by Peter Kapec
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( lua-cjson C )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

# lua-cjson modules
add_definitions ( -DVERSION="${DIST_VERSION}" )
install_lua_module ( cjson lua_cjson.c strbuf.c )

# Install Lua-CJSON Documentation
install_data ( README NEWS performance.txt rfc4627.txt )

# Install Tests
install_test ( tests/ )
