# Copyright (C) 2007-2012 LuaDist.
# Created by Peter Kapec, Peter Drahos
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( lrexlib-gnu C )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

add_definitions ( -DVERSION=\"${DIST_VERSION}\" )

set ( COMMON_SRC src/common.c )
install_lua_module ( rex_gnu 
  src/common.c 
  src/gnu/lgnu.c )
