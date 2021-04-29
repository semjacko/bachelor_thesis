# Copyright (C) 2007-2012 LuaDist.
# Created by Peter Kapec, Peter Drahos
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( lrexlib-tre C )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

add_definitions ( -DVERSION=\"${DIST_VERSION}\" )


find_package ( TRE REQUIRED )
include_directories ( ${TRE_INCLUDE_DIRS} )

install_lua_module ( rex_posix 
  src/common.c
  src/tre/ltre.c
  LINK ${TRE_LIBRARIES} )
