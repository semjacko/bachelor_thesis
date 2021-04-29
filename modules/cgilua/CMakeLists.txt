# Copyright (C) 2007-2012 LuaDist.
# Created by Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( cgilua NONE )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

install_lua_module ( cgilua src/cgilua/cgilua.lua )
# note: special location
install_lua_module ( cgilua.authentication src/cgilua/authentication.lua )
install_lua_module ( cgilua.cookies src/cgilua/cookies.lua )
install_lua_module ( cgilua.dispatcher src/cgilua/dispatcher.lua )
install_lua_module ( cgilua.loader src/cgilua/loader.lua )
install_lua_module ( cgilua.lp src/cgilua/lp.lua )
install_lua_module ( cgilua.mime src/cgilua/mime.lua )
install_lua_module ( cgilua.post src/cgilua/post.lua )
install_lua_module ( cgilua.readuntil src/cgilua/readuntil.lua )
install_lua_module ( cgilua.serialize src/cgilua/serialize.lua )
install_lua_module ( cgilua.session src/cgilua/session.lua )
install_lua_module ( cgilua.urlcode src/cgilua/urlcode.lua )

install_data ( README )
install_doc ( doc )
install_test ( tests )
install_example ( examples )

#FIX: how to run tests? add_lua_test ( ... )
