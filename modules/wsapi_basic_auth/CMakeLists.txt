# Copyright (C) 2007-2012 LuaDist.
# Created by Peter Drahos
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( wsapi_basic_auth NONE )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

install_lua_module ( wsapi.basic_auth wsapi/basic_auth.lua )
install_data ( readme.md )
