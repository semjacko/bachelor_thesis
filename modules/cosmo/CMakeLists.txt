# Copyright (C) 2007-2012 LuaDist.
# Created by Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( cosmo NONE )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

install_lua_module ( cosmo src/cosmo.lua )
install_lua_module ( cosmo.fill src/cosmo/fill.lua )
install_lua_module ( cosmo.grammar src/cosmo/grammar.lua )
install_data ( README )
install_example ( samples/ )
install_doc ( doc/ )
install_test ( tests/ )
