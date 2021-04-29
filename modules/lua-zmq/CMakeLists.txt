# Copyright (C) 2012 LuaDist.
# Created by Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note this is a complete rewrite of the original build

project ( lua-zmq C )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

# For now use pre-generated source until we standardize lua_native_objects installation
#include ( LuaNativeObjects )
#GenLuaNativeObjects ( zmq.nobj.lua )
find_package ( ZMQ REQUIRED )

include_directories ( ${ZMQ_INCLUDE_DIR} )
install_lua_module ( zmq zmq.nobj.c LINK ${ZMQ_LIBRARY} )
install_lua_module ( zmq.poller src/poller.lua )
install_lua_module ( zmq.threads src/threads.lua )
install_example ( examples/ )
install_data ( COPYRIGHT )
