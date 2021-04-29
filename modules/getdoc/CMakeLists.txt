# Copyright (C) 2014 LuaDist.
# Created by Peter Kapec
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( lua-getdoc NONE )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

# Install all files and documentation
install_lua_executable ( luagetdoc src/luagetdoc.lua )
install ( DIRECTORY src/getdoc DESTINATION ${INSTALL_LMOD} )
install_data ( README.md )

