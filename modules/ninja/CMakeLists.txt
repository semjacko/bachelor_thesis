# Copyright (C) 2012 LuaDist.
# Submitted by David Manura.
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

project ( ninja CXX )
cmake_minimum_required ( VERSION 2.6 )
include ( cmake/dist.cmake )

# reimplement `src/inline.sh  kBrowsePy < browse.py > browse_py.h`
file ( READ src/browse.py _data HEX )
string ( REGEX REPLACE
  "(...?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?.?)"
  "\"\\1\"\n" _data "${_data}" )
string ( REGEX REPLACE "([0-9a-f][0-9a-f])" "\\\\x\\1" _data "${_data}" )
set ( _data "const char kBrowsePy[] =\n${_data};" )
file ( WRITE "${CMAKE_CURRENT_BINARY_DIR}/build/browse_py.h" "${_data}" )

include_directories ( src "${CMAKE_CURRENT_BINARY_DIR}/build" )

add_definitions ( -Wno-deprecated )
add_definitions ( -DNINJA_PYTHON="python" )  # improve?

add_library ( libninja
  src/browse.cc
  src/build.cc
  src/build_log.cc
  src/clean.cc
  src/depfile_parser.cc
  src/disk_interface.cc
  src/edit_distance.cc
  src/eval_env.cc
  src/graph.cc
  src/graphviz.cc
  src/lexer.cc
  src/metrics.cc
  src/parsers.cc
  src/state.cc
  src/util.cc
  src/subprocess.cc
)
set_target_properties ( libninja PROPERTIES OUTPUT_NAME ninja )


add_executable ( ninja src/ninja.cc )
target_link_libraries ( ninja libninja )

# testing.
# This requires libgtest-dev.
if ( BUILD_TESTING )
  enable_testing()
  add_executable ( ninja_test
    src/build_log_test.cc
    src/build_test.cc
    src/clean_test.cc
    src/depfile_parser_test.cc
    src/disk_interface_test.cc
    src/edit_distance_test.cc
    src/graph_test.cc
    src/lexer_test.cc
    src/parsers_test.cc
    src/state_test.cc
    src/subprocess_test.cc
    src/test.cc
    src/util_test.cc
  ) 
  target_link_libraries ( ninja_test libninja -lgtest_main -lgtest -lpthread )

  add_executable ( parser_perftest src/parser_perftest.cc )
  target_link_libraries ( parser_perftest libninja )
  
  add_test ( ninja_test ninja_test )

endif ()

#~2DO: generate manual

install_library ( libninja )
install_executable ( ninja )
install_doc ( doc/manual.asciidoc )
install_data ( COPYING HACKING README )
install_foo ( misc/ )

  