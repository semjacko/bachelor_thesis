# Copyright (C) 2007-2012 LuaDist.
# Created by Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( luadoc NONE )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

# Install all files and documentation
install_lua_executable ( luadoc src/luadoc.lua )

# Install all modules directly
install ( DIRECTORY src/luadoc DESTINATION ${INSTALL_LMOD} COMPONENT Runtime )

install_data ( README )
install_doc ( doc/ )
install_test ( test/ )
