# Copyright (C) 2007-2012 LuaDist.
# Created by Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( rings C )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

install_lua_module ( rings src/rings.c )
install_lua_module ( stable src/stable.lua )

install_data ( README )
install_doc ( doc/ )
install_test ( tests/ )

#FIX: lua.cmake is incompatible with tests using package.path forwarding between states
#add_lua_test(tests/test.lua)
add_lua_test ( tests/sample.lua )
#add_lua_test(tests/sample_state.lua)
