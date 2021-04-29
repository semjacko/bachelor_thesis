# Copyright (C) 2012 LuaDist.
# Created by Peter Kapec
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( lua-codegen NONE )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

install_lua_module ( CodeGen src/CodeGen.lua )
install_lua_module ( CodeGen.Graph src/CodeGen/Graph.lua )
install_lua_module ( CodeGen.lpeg src/CodeGen/lpeg.lua )
install_data ( CHANGES COPYRIGHT README.md )
install_test ( test/ )
