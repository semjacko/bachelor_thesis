# Copyright (C) 2007-2013 LuaDist.
# Created by Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( luadist-activate NONE )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )

install( PROGRAMS activate DESTINATION ${INSTALL_BIN} COMPONENT Runtime )
