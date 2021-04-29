# Copyright (C) 2007-2012 LuaDist.
# Created by Peter Kapec
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( luaunit NONE )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

install_lua_module ( luaunit luaunit.lua )
install_data ( LICENSE.txt README.txt )
install_test ( test_luaunit.lua )
install_example ( example_with_luaunit.lua )
add_lua_test ( test_luaunit.lua )
# note: use_luaunit.lua is expected to fail
