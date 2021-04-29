# Copyright (C) 2011-2012 LuaDist.
# Created by Peter Kapec
# Redistribution and use of this file is allowed according to the terms of the MIT license.
# For details see the COPYRIGHT file distributed with LuaDist.
# Please note that the package source code is licensed under its own license.

PROJECT(im C CXX)
CMAKE_MINIMUM_REQUIRED(VERSION 2.6)
INCLUDE(cmake/dist.cmake)
INCLUDE( lua )

# find packages
	FIND_PACKAGE(OpenGL)
	FIND_PACKAGE(GLUT)

	FIND_PACKAGE(IM REQUIRED)
	FIND_PACKAGE(CD REQUIRED)
	FIND_PACKAGE(IUP REQUIRED)

# find libs
	FIND_LIBRARY( VFW32_LIBRARY NAMES vfw32 vfw_ms32 vfw_avi32)
	FIND_LIBRARY( STRMIIDS_LIBRARY NAMES strmiids)

############################################################################################

	INCLUDE_DIRECTORIES (${IUP_INCLUDE_DIRS} ${CD_INCLUDE_DIRS} ${IM_INCLUDE_DIRS})

# glut_capture example app
	IF(WIN32)
		IF( OPENGL_FOUND AND OPENGL_GLU_FOUND AND GLUT_FOUND AND VFW32_LIBRARY AND STRMIIDS_LIBRARY
			AND
			IM_LIBRARY_CAPTURE AND IM_LIBRARY_AVI AND IM_LIBRARY_PROCESS
		)
			ADD_EXECUTABLE(glut_capture examples/C/glut_capture.c)
			TARGET_LINK_LIBRARIES (glut_capture ${IM_LIBRARY_CAPTURE} ${IM_LIBRARY_AVI} ${IM_LIBRARY_PROCESS}  ${IM_LIBRARY}
											${GLUT_LIBRARIES} ${OPENGL_LIBRARIES} ${VFW32_LIBRARY} ${STRMIIDS_LIBRARY})

			INSTALL(TARGETS glut_capture DESTINATION ${INSTALL_EXAMPLE} COMPONENT Example)
		ENDIF()
	ENDIF()

# im_paint example app
	ADD_EXECUTABLE(im_paint examples/C/im_paint.c)
	TARGET_LINK_LIBRARIES (im_paint ${IUPCD_LIBRARY} ${IUPIMGLIB_LIBRARY} ${IUP_LIBRARY} ${IM_LIBRARY} ${CD_LIBRARY} )

# im_view example app
	ADD_EXECUTABLE(im_view examples/C/im_view.c)
	TARGET_LINK_LIBRARIES (im_view ${IUPCD_LIBRARY} ${IUP_LIBRARY} ${IM_LIBRARY} ${CD_LIBRARY} )

# im_glview example app	- needed FIX
	ADD_EXECUTABLE(iupglview examples/C/iupglview.c)
	TARGET_LINK_LIBRARIES (iupglview ${IUPGL_LIBRARY} ${IUP_LIBRARY} ${IM_LIBRARY} ${OPENGL_LIBRARIES} )

# im_ copy example app
	ADD_EXECUTABLE(im_copy examples/C/im_copy.cpp)
	TARGET_LINK_LIBRARIES (im_copy ${IM_LIBRARY})

# im_ info example app
	ADD_EXECUTABLE(im_info examples/C/im_info.cpp)
	TARGET_LINK_LIBRARIES (im_info ${IM_LIBRARY})

# memfile example app
	ADD_EXECUTABLE(memfile examples/C/memfile.cpp)
	TARGET_LINK_LIBRARIES (memfile ${IM_LIBRARY_JP2} ${IM_LIBRARY})

# proc_fourier example app	- needed FIX
	ADD_EXECUTABLE(proc_fourier examples/C/proc_fourier.cpp)
	TARGET_LINK_LIBRARIES (proc_fourier ${IM_LIBRARY_FFTW} ${IM_LIBRARY_PROCESS} ${IM_LIBRARY})

# install example apps
#~ 	install_example(examples/ im_paint im_view  iupglview im_copy im_info memfile proc_fourier)
	INSTALL(TARGETS im_paint im_view  iupglview im_copy im_info memfile proc_fourier
			DESTINATION ${INSTALL_EXAMPLE}
			COMPONENT Example)

############################################################################################

# install example Lua apps
	install_lua_module(view_image examples/modules/view_image.lua )
	install_example( examples/Lua )
	install_data( examples/images )


