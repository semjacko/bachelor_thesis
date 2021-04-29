# Define projects name
# The C tells CMAKE to check for C compilers
project ( lua-cmsgpack C )

# Define minimu^m version of CMAKE for compatibility
cmake_minimum_required ( VERSION 2.8 )

# Include dist.cmake - defines LuaDist related macros and install paths
# Also include Lua related macros
include ( cmake/dist.cmake )
include ( lua )

# Create and install a Lua module:
# first parameter is module's name (the name that can be required in Lua)
# second and following parameters are the source files (here only one file)
# last parameter is a .def file for exporting symbols from dll produced by MS compilers
install_lua_module ( cmsgpack lua_cmsgpack.c )

# Schedules a test, this is optional
add_lua_test ( test.lua )

# Install test ( NOTE: This does not execute testing, just installs)
install_test ( test.lua )

# Install documentation
install_doc ( Readme.md )