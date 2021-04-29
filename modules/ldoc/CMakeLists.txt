# Copyright (C) 2007-2012 LuaDist.
# Submited by Peter Kapec
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( ldoc NONE )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

install_lua_executable ( ldoc ldoc.lua )
install ( DIRECTORY ldoc DESTINATION ${INSTALL_LMOD} COMPONENT "Runtime" )

install_data ( readme.md COPYRIGHT )
install_doc ( docs/ )
install_test ( tests/ )
