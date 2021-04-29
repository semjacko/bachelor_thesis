# Copyright(C) 2007-2016 LuaDist.
# Created by Peter Drahoš, Peter Kapec
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project( busted NONE )
cmake_minimum_required( VERSION 2.8 )
include( cmake/dist.cmake )
include( lua )

install_lua_module( busted.core			busted/core.lua )
install_lua_module( busted.context		busted/context.lua )
install_lua_module( busted.environment	busted/environment.lua )
install_lua_module( busted.compatibility	busted/compatibility.lua )
install_lua_module( busted.options	busted/options.lua )
install_lua_module( busted.done			busted/done.lua )
install_lua_module( busted.runner		busted/runner.lua )
install_lua_module( busted.status		busted/status.lua )
install_lua_module( busted.utils		busted/utils.lua )
install_lua_module( busted.block		busted/block.lua )
install_lua_module( busted.execute		busted/execute.lua )
install_lua_module( busted.init			busted/init.lua )

install_lua_module( busted.modules.configuration_loader		busted/modules/configuration_loader.lua)
install_lua_module( busted.modules.luacov					busted/modules/luacov.lua)
install_lua_module( busted.modules.standalone_loader		busted/modules/standalone_loader.lua)
install_lua_module( busted.modules.test_file_loader			busted/modules/test_file_loader.lua)
install_lua_module( busted.modules.output_handler_loader	busted/modules/output_handler_loader.lua)
install_lua_module( busted.modules.helper_loader			busted/modules/helper_loader.lua)
install_lua_module( busted.modules.filter_loader			busted/modules/filter_loader.lua)
install_lua_module( busted.modules.cli						busted/modules/cli.lua)

install_lua_module( busted.modules.files.lua		busted/modules/files/lua.lua)
install_lua_module( busted.modules.files.moonscript	busted/modules/files/moonscript.lua)
install_lua_module( busted.modules.files.terra		busted/modules/files/terra.lua)

install_lua_module( busted.outputHandlers.base			busted/outputHandlers/base.lua)
install_lua_module( busted.outputHandlers.utfTerminal	busted/outputHandlers/utfTerminal.lua)
install_lua_module( busted.outputHandlers.plainTerminal	busted/outputHandlers/plainTerminal.lua)
install_lua_module( busted.outputHandlers.TAP			busted/outputHandlers/TAP.lua)
install_lua_module( busted.outputHandlers.json			busted/outputHandlers/json.lua)
install_lua_module( busted.outputHandlers.junit			busted/outputHandlers/junit.lua)
install_lua_module( busted.outputHandlers.gtest			busted/outputHandlers/gtest.lua)
install_lua_module( busted.outputHandlers.sound			busted/outputHandlers/sound.lua)

install_lua_module( busted.languages.en		busted/languages/en.lua)
install_lua_module( busted.languages.ar		busted/languages/ar.lua)
install_lua_module( busted.languages.de		busted/languages/de.lua)
install_lua_module( busted.languages.es		busted/languages/es.lua)
install_lua_module( busted.languages.fr		busted/languages/fr.lua)
install_lua_module( busted.languages.ja		busted/languages/ja.lua)
install_lua_module( busted.languages.nl		busted/languages/nl.lua)
install_lua_module( busted.languages.ru		busted/languages/ru.lua)
install_lua_module( busted.languages.th		busted/languages/th.lua)
install_lua_module( busted.languages.ua		busted/languages/ua.lua)
install_lua_module( busted.languages.zh		busted/languages/zh.lua)
install_lua_module( busted.languages.it		busted/languages/it.lua)

install_lua_executable( busted bin/busted )
install_data( CONTRIBUTING.md LICENSE README.md TODO.md )

install_test( spec )
