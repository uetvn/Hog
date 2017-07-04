cmake_minimum_required(VERSION 2.8)

set (PROJECT_NAME hog)

SET(CMAKE_C_FLAGS "-g -pg")

project( ${PROJECT_NAME} )

#mylib
set(MYLIBS_DIR  ".")

#SET(CMAKE_FIND_ROOT_PATH  ${MJPEG-tools_DIR})

set(CMAKE_VERBOSE_MAKEFILE ON)

include_directories(${MYLIBS_DIR} lib inc)

file(GLOB my_INC lib/*.h inc/*.h)
file(GLOB my_SRC lib/*.c *.c src/*.c)

set(my_SRC_INC ${my_SRC} ${my_INC})

ADD_EXECUTABLE( ${PROJECT_NAME}
	${my_SRC_INC})

TARGET_LINK_LIBRARIES( ${PROJECT_NAME} m )

#
#subdirs(tests)
