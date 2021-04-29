# Copyright (C) 2007-2012 LuaDist.
# Created by Peter Kapec, Peter Drahos
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( wsapi NONE )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

# Find fcgi
find_package ( FCGI REQUIRED )
include_directories ( ${FCGI_INCLUDE_DIR} )

# Quick environ fix without need to patch
if ( APPLE )
  add_definitions ( -Denviron=\(*_NSGetEnviron\(\)\) )
endif ( APPLE )

# lfcgi module
install_lua_module ( lfcgi src/fastcgi/lfcgi.c LINK ${FCGI_LIBRARY} )
install_lua_module ( wsapi.common src/wsapi/common.lua )
install_lua_module ( wsapi.request src/wsapi/request.lua )
install_lua_module ( wsapi.response src/wsapi/response.lua )
install_lua_module ( wsapi.util src/wsapi/util.lua )
install_lua_module ( wsapi.cgi src/wsapi/cgi.lua )
install_lua_module ( wsapi.fastcgi src/wsapi/fastcgi.lua )
install_lua_module ( wsapi.xavante src/wsapi/xavante.lua )
install_lua_module ( wsapi.sapi src/wsapi/sapi.lua )
install_lua_module ( wsapi.ringer src/wsapi/ringer.lua )
install_lua_executable ( wsapi.cgi src/launcher/wsapi.cgi )
install_lua_executable ( wsapi.fcgi src/launcher/wsapi.fcgi )
install_lua_executable ( wsapi src/launcher/wsapi )
install_example ( samples/ )
install_doc ( doc/ )
install_test ( tests/ )
