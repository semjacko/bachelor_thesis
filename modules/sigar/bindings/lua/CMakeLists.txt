include ( lua )

file ( GLOB SRC_LUA *.c )

install_lua_module ( sigar ${SRC_LUA} LINK libsigar )
install_test ( sigar-test.lua )
