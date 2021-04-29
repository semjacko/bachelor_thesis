# Copyright (C) 2007-2012 LuaDist.
# Created by Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( tre C )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( configure )

configure_file ( config.h.in ${CMAKE_CURRENT_SOURCE_DIR}/config.h )
configure_file ( lib/tre-config.h.in ${CMAKE_CURRENT_SOURCE_DIR}/lib/tre-config.h )

add_definitions ( -DHAVE_CONFIG_H )
include_directories ( ${CMAKE_CURRENT_SOURCE_DIR} lib )

file ( GLOB TRE_SRC lib/*.c )
add_library ( tre ${TRE_SRC} )

install_library ( tre )
install_header ( lib/tre.h lib/tre-config.h INTO tre )