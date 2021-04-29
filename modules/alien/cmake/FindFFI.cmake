# - Try to find LibFFI
# Once done this will define
#  FFI_FOUND - System has LibFFI
#  FFI_INCLUDE_DIRS - The LibFFI include directories
#  FFI_LIBRARIES - The libraries needed to use LibFFI
#  FFI_DEFINITIONS - Compiler switches required for using LibFFI

find_path(FFI_INCLUDE_DIR ffi.h ffi/ffi.h PATHS /usr/include/x86_64-linux-gnu/)
find_library(FFI_LIBRARY NAMES ffi libffi)

set(FFI_LIBRARIES ${FFI_LIBRARY} )
set(FFI_INCLUDE_DIRS ${FFI_INCLUDE_DIR} )

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(FFI DEFAULT_MSG FFI_LIBRARY FFI_INCLUDE_DIR)

mark_as_advanced(FFI_INCLUDE_DIR FFI_LIBRARY )