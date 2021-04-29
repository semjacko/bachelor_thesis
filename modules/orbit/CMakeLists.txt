# Copyright (C) 2007-2012 LuaDist.
# Created by Peter Kapec, Peter Drahos
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( orbit NONE )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

install_lua_module ( orbit.model src/orbit/model.lua )
install_lua_module ( orbit.pages src/orbit/pages.lua )
install_lua_module ( orbit.cache src/orbit/cache.lua )
install_lua_module ( orbit.ophandler src/orbit/ophandler.lua )
install_lua_module ( orbit.routes src/orbit/routes.lua )

install_lua_executable ( orbit src/launchers/orbit )
install_lua_executable ( op.cgi src/launchers/op.cgi )
install_lua_executable ( op.fcgi src/launchers/op.fcgi )

install_example ( samples/ )
install_doc ( doc/ )
install_test ( test/ )
