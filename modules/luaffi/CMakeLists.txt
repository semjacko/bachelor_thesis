# Copyright (C) 2012 LuaDist.
# Created by Peter Drahoš
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( luaffi C )
cmake_minimum_required ( VERSION 2.8 )
include ( cmake/dist.cmake )
include ( lua )

# Optionally rebuild buildvm_*.h header.
option ( LUAFFI_RUN_DYNASM "Re-generate headers with DynASM." OFF )
if ( LUAFFI_RUN_DYNASM )
  # We need LUA_EXECUTABLE
  find_package ( Lua REQUIRED )

  set ( DASM ${LUA} ${CMAKE_CURRENT_SOURCE_DIR}/dynasm/dynasm.lua )
  set ( DASM_FLAGS_X86 )
  set ( DASM_FLAGS_X64 -D X64 )
  set ( DASM_FLAGS_X64WIN -D X64 -D X64WIN )

  add_custom_command ( OUTPUT ${CMAKE_CURRENT_SOURCE_DIR}/call_x86.h COMMAND ${LUA_EXECUTABLE} 
    ${DASM} -LN ${DASM_FLAGS_X86} -o ${CMAKE_CURRENT_SOURCE_DIR}/call_x86.h ${CMAKE_CURRENT_SOURCE_DIR}/call_x86.dasc 
    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/call_x86.dasc )
  add_custom_command ( OUTPUT ${CMAKE_CURRENT_SOURCE_DIR}/call_x64.h COMMAND ${LUA_EXECUTABLE} 
    ${DASM} -LN ${DASM_FLAGS_X64} -o ${CMAKE_CURRENT_SOURCE_DIR}/call_x64.h ${CMAKE_CURRENT_SOURCE_DIR}/call_x86.dasc 
    DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/call_x86.dasc )
  add_custom_command ( OUTPUT ${CMAKE_CURRENT_SOURCE_DIR}/call_x64win.h COMMAND ${LUA_EXECUTABLE} 
    ${DASM} -LN ${DASM_FLAGS_X64WIN} -o ${CMAKE_CURRENT_SOURCE_DIR}/call_x64win.h 
    ${CMAKE_CURRENT_SOURCE_DIR}/call_x86.dasc DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/call_x86.dasc )
  # Note: not all of these are needed for the current platform, but for simplicity
  # specify all.
  set_source_files_properties ( ${CMAKE_CURRENT_SOURCE_DIR}/call.c PROPERTIES OBJECT_DEPENDS 
    ${CMAKE_CURRENT_SOURCE_DIR}/call_x64win.h ${CMAKE_CURRENT_SOURCE_DIR}/call_x64.h 
    ${CMAKE_CURRENT_SOURCE_DIR}/call_x86.h )
  include_directories ( ${CMAKE_CURRENT_BINARY_DIR} )
endif ( )

install_lua_module ( ffi ffi.c ctype.c parser.c call.c )
install_data ( README.md )
add_library ( test_cdecl MODULE test.c )
install ( TARGETS test_cdecl DESTINATION ${INSTALL_TEST} COMPONENT Test )
install_test ( test.lua )
