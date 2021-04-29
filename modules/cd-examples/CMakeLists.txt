# Copyright (C) 2011-2012 LuaDist.
# Created by Peter Kapec
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

PROJECT(cd C)
CMAKE_MINIMUM_REQUIRED(VERSION 2.6)
INCLUDE(cmake/dist.cmake)
INCLUDE(lua)

# find packages
	find_package(OpenGL)

	find_package(IM REQUIRED)
	find_package(CD REQUIRED)
	find_package(IUP REQUIRED)

	INCLUDE_DIRECTORIES ( ${IM_INCLUDE_DIRS} ${CD_INCLUDE_DIRS})

# install modules
	install_lua_module(iupcdaux modules/iupcdaux.lua )

# install example Lua apps
	install_example( examples/ )

# screencapture test app
	ADD_EXECUTABLE(screencapture test/screencapture.c)
	TARGET_LINK_LIBRARIES (screencapture ${CD_LIBRARIES} ${IM_LIBRARIES})
	INSTALL(TARGETS screencapture DESTINATION ${INSTALL_EXAMPLE} COMPONENT Example)

# metafile test app
	ADD_EXECUTABLE(metafile test/metafile.c)
	TARGET_LINK_LIBRARIES (metafile ${CD_LIBRARIES})
	INSTALL(TARGETS metafile DESTINATION ${INSTALL_EXAMPLE} COMPONENT Example)

# cdtest test app
	FILE(GLOB CDTEST_SRC "test/cdtest/*.c")
	IF(CDCONTEXTPLUS_LIBRARY)
		SET_SOURCE_FILES_PROPERTIES(${CDTEST_SRC} PROPERTIES COMPILE_DEFINITIONS  "USE_CONTEXTPLUS;USE_LED")
	ELSE()
		SET_SOURCE_FILES_PROPERTIES(${CDTEST_SRC} PROPERTIES COMPILE_DEFINITIONS  "USE_LED")
	ENDIF()
	ADD_EXECUTABLE(cdtest ${CDTEST_SRC} test/cdtest/cdtest.rc)
	TARGET_LINK_LIBRARIES (cdtest ${CDPDF_LIBRARY} ${CD_LIBRARIES} ${IUPCD_LIBRARY} ${IUP_LIBRARIES})
	IF(CDCONTEXTPLUS_LIBRARY)
		TARGET_LINK_LIBRARIES (cdtest ${CDCONTEXTPLUS_LIBRARY})
	ENDIF()
	INSTALL(TARGETS cdtest DESTINATION ${INSTALL_EXAMPLE} COMPONENT Example)
	install_example(test/cdtest/cdtest.led)

# simple test app
	FILE(GLOB SIMPLE_SRC "test/simple/*.c")

	IF(CDCONTEXTPLUS_LIBRARY)
		SET(USE_CONTEXTPLUS "-DUSE_CONTEXTPLUS")
	ENDIF()
	IF(OPENGL_FOUND)
		SET(USE_OPENGL "-DUSE_OPENGL")
	ENDIF()
	# 2DO - more elegant solution ???
	SET_SOURCE_FILES_PROPERTIES(${SIMPLE_SRC} PROPERTIES COMPILE_FLAGS  "${USE_OPENGL} ${USE_CONTEXTPLUS}")

	ADD_EXECUTABLE(simple ${SIMPLE_SRC})
	TARGET_LINK_LIBRARIES (simple ${CDPDF_LIBRARY} ${CD_LIBRARIES} ${IUPCD_LIBRARY} ${IUP_LIBRARIES})
	IF(CDCONTEXTPLUS_LIBRARY)
		TARGET_LINK_LIBRARIES (simple ${CDCONTEXTPLUS_LIBRARY})
	ENDIF()
	IF(OPENGL_FOUND)
		TARGET_LINK_LIBRARIES (simple ${IUPGL_LIBRARY} ${CDGL_LIBRARY} ${OPENGL_LIBRARIES})
	ENDIF()

	INSTALL(TARGETS simple DESTINATION ${INSTALL_EXAMPLE} COMPONENT Example)
	install_example(test/simple/simple.led)