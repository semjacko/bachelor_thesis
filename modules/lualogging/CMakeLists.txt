# Copyright (C) 2007-2013 LuaDist.
# Created by Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( lualogging NONE )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

# note path moves as in makefile
install_lua_module ( logging src/logging.lua )
install_lua_module ( logging.console src/logging/console.lua )
install_lua_module ( logging.file src/logging/file.lua )
install_lua_module ( logging.rolling_file src/logging/rolling_file.lua )
install_lua_module ( logging.email src/logging/email.lua )
install_lua_module ( logging.sql src/logging/sql.lua )
install_lua_module ( logging.socket src/logging/socket.lua )

install_data ( README )
install_doc ( doc/html/ )
install_test ( tests/ )

add_lua_test ( tests/test.lua ${CMAKE_CURRENT_SOURCE_DIR}/tests )
# FIX: paths
