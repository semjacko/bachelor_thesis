# Copyright (C) 2012 LuaDist.
# Created by Peter Kapec
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( lua-compress-deflatelua NONE )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

# Install all files and documentation
install_lua_module ( compress.deflatelua module/lmod/compress/deflatelua.lua )
install_lua_module ( bin.gunziplua module/lmod/bin/gunziplua.lua )
install_lua_executable ( gunziplua bin/gunziplua )
install_test ( test/test.lua )
install_data ( COPYRIGHT share/compress.deflatelua/hello.txt.gz )
