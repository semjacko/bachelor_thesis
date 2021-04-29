# Copyright (C) 2012 LuaDist.
# Created by Peter Drahos
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( luapgsql C )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

#add_definitions ( -D_GNU_SOURCE )

find_package ( PostgreSQL REQUIRED )

include_directories ( ${POSTGRESQL_INCLUDE_DIR} src )
install_lua_module ( pgsql luapgsql.c LINK ${POSTGRESQL_LIBRARIES} )

install_test ( testdb.lua )
install_data ( README )
