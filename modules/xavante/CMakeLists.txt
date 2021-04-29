# Copyright (C) 2007-2012 LuaDist.
# Created by Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( xavante NONE )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

install_lua_module ( xavante src/xavante/xavante.lua )
install_lua_module ( xavante.cgiluahandler src/xavante/cgiluahandler.lua )
install_lua_module ( xavante.encoding src/xavante/encoding.lua )
install_lua_module ( xavante.filehandler src/xavante/filehandler.lua )
install_lua_module ( xavante.httpd src/xavante/httpd.lua )
install_lua_module ( xavante.mime src/xavante/mime.lua )
install_lua_module ( xavante.patternhandler src/xavante/patternhandler.lua )
install_lua_module ( xavante.redirecthandler src/xavante/redirecthandler.lua )
install_lua_module ( xavante.vhostshandler src/xavante/vhostshandler.lua )
install_lua_module ( xavante.indexhandler src/xavante/indexhandler.lua )
install_lua_module ( xavante.urlhandler src/xavante/urlhandler.lua )
install_lua_module ( xavante.ruleshandler src/xavante/ruleshandler.lua )

install_lua_module ( sajax src/sajax/sajax.lua)

install_data ( README )
install_doc ( doc/ )
install_example ( examples/ )
