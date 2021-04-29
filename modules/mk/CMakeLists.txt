# Copyright (C) 2007-2012 LuaDist.
# Created by Peter Drahoš, Peter Kapec
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( lua NONE )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

install_lua_module ( mk src/mk.lua )
install_lua_module ( mk.routes src/mk/routes.lua )
install_lua_module ( mk.forms src/mk/forms.lua )
install_lua_module ( mk.blocks src/mk/blocks.lua )
install_lua_module ( mk.util src/mk/util.lua )
install_lua_module ( mk.themes src/mk/themes.lua )
install_lua_module ( mk.template src/mk/template.lua )
install_lua_module ( mk.auth src/mk/auth.lua )
install_lua_module ( mk.cache src/mk/cache.lua )

install_doc ( doc/ )
install_test ( test/ )
install_example ( samples/ )

