# Copyright (C) 2007-2016 LuaDist.
# Created by Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( lua_cliargs NONE )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

install_lua_module ( cliargs src/cliargs.lua )

install_lua_module ( cliargs.config_loader  src/cliargs/config_loader.lua )
install_lua_module ( cliargs.constants  src/cliargs/constants.lua )
install_lua_module ( cliargs.core  src/cliargs/core.lua )
install_lua_module ( cliargs.parser  src/cliargs/parser.lua )
install_lua_module ( cliargs.printer  src/cliargs/printer.lua )
install_lua_module ( cliargs.utils.disect  src/cliargs/utils/disect.lua )
install_lua_module ( cliargs.utils.disect_argument  src/cliargs/utils/disect_argument.lua )
install_lua_module ( cliargs.utils.filter  src/cliargs/utils/filter.lua )
install_lua_module ( cliargs.utils.lookup  src/cliargs/utils/lookup.lua )
install_lua_module ( cliargs.utils.shallow_copy  src/cliargs/utils/shallow_copy.lua )
install_lua_module ( cliargs.utils.split  src/cliargs/utils/split.lua )
install_lua_module ( cliargs.utils.trim  src/cliargs/utils/trim.lua )
install_lua_module ( cliargs.utils.wordwrap  src/cliargs/utils/wordwrap.lua )

install_example ( examples/ )
install_doc ( doc/ )
install_data (  README.md UPGRADE.md LICENSE )
