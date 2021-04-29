# Copyright (C) 2007-2013 LuaDist.
# Created by Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( lua-websockets NONE )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

install_lua_module ( websocket src/websocket.lua )
install_lua_module ( websocket.sync src/websocket/sync.lua )
install_lua_module ( websocket.client src/websocket/client.lua )
install_lua_module ( websocket.client_ev src/websocket/client_ev.lua )
install_lua_module ( websocket.client_copas src/websocket/client_copas.lua )
install_lua_module ( websocket.ev_common src/websocket/ev_common.lua )
install_lua_module ( websocket.server src/websocket/server.lua )
install_lua_module ( websocket.server_ev src/websocket/server_ev.lua )
install_lua_module ( websocket.server_copas src/websocket/server_copas.lua )
install_lua_module ( websocket.handshake src/websocket/handshake.lua )
install_lua_module ( websocket.tools src/websocket/tools.lua )
install_lua_module ( websocket.frame src/websocket/frame.lua )
install_lua_module ( websocket.bit src/websocket/bit.lua )

install_example ( examples/echo-server-copas.lua examples/echo-server-ev.lua )
install_test ( test-server )
install_data ( README.md )
