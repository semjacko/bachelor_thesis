# Configure header files and such using autoconf rather than cmake.
# D.Manura, 2012-04.

function ( my_execute_process )
  execute_process ( ${ARGV} RESULT_VARIABLE res_ ERROR_VARIABLE err_ )
  if ( NOT ( res_ EQUAL 0 ) )
    message ( FATAL_ERROR "${res_} ${err_} in executing ${ARGV}" )
  endif ()
endfunction ()

# based on buildconf
if ( NOT EXISTS apr_private.h OR NOT EXISTS apr.h OR NOT EXISTS build/apr_rules.mk )
  message ( "running autoconf..." )
  file ( WRITE build/libtool.m4  # dummy functions
    "m4_defun([AC_PROG_LIBTOOL], []) m4_defun([AC_LIBTOOL_WIN32_DLL], [])")
  my_execute_process ( COMMAND mkdir -p include/arch/unix )
  my_execute_process ( COMMAND autoheader -I${CMAKE_CURRENT_SOURCE_DIR}
                       ${CMAKE_CURRENT_SOURCE_DIR}/configure.in )
  my_execute_process ( COMMAND autoconf -I${CMAKE_CURRENT_SOURCE_DIR}
                       -o configure ${CMAKE_CURRENT_SOURCE_DIR}/configure.in )
  my_execute_process ( COMMAND ./configure --srcdir=${CMAKE_CURRENT_SOURCE_DIR} )
  configure_file ( ${CMAKE_CURRENT_BINARY_DIR}/include/arch/unix/apr_private.h apr_private.h COPYONLY )
  configure_file ( ${CMAKE_CURRENT_BINARY_DIR}/include/apr.h apr.h COPYONLY )
endif ()
file ( READ ${CMAKE_CURRENT_BINARY_DIR}/build/apr_rules.mk _rules )
string ( REGEX MATCH "EXTRA_CPPFLAGS=([^\n]*)" _unused "${_rules}" )
set ( _extra_cppflags "${CMAKE_MATCH_1}" )
string ( REGEX MATCH "EXTRA_LIBS=([^\n]*)" _unused "${_rules}" )
set ( _extra_libs "${CMAKE_MATCH_1}" )
string ( REGEX MATCH "EXTRA_CFLAGS=([^\n]*)" _unused "${_rules}" )
set ( _extra_cflags "${CMAKE_MATCH_1}" )
set ( _extra_libs "-lpthread ${_extra_libs}" ) #FIX: workaround to avoid link errors. -lpthread before -lrt  why?
add_definitions ( -DHAVE_CONFIG_H ${_extra_cppflags} ${_extra_cflags} )
message ( "EXTRA_CPPFLAGS=${_extra_cppflags}" )
message ( "EXTRA_CFLAGS=${_extra_cflags}" )
message ( "EXTRA_LIBS=${_extra_libs}" )
