# Copyright (C) 2007-2012 LuaDist.
# Created by Peter Drahoš, Peter Kapec
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( luanativeobjects NONE )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

install ( DIRECTORY native_objects DESTINATION ${INSTALL_LMOD} COMPONENT Runtime )
install_data ( project_template )
install_example ( examples/ )
install_lua_module ( record record.lua )
install_lua_executable ( native_objects native_objects.lua )
install_data ( COPYRIGHT README.md TODO.md )
