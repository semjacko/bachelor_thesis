# Copyright (C) 2007-2012 LuaDist.
# Created by Peter Kapec
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( luaxmlrpc NONE )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

install_lua_module ( xmlrpc.http src/http.lua )
install_lua_module ( xmlrpc.init src/init.lua )
install_lua_module ( xmlrpc.server src/server.lua )

install_data ( README )
install_doc ( doc/ )
install_example ( examples/ )
install_test ( tests/ )
