cmake_minimum_required(VERSION 2.8)

project(oicmake)

#1 options

#2 tool chain

#3 find resources
file(GLOB_RECURSE ${PROJECT_NAME}_COMPONENT_SRC
    src/dji_*.cpp
    )

file(GLOB_RECURSE ${PROJECT_NAME}_COMPONENT_INC
    inc/dji_*.hpp
    )

file(GLOB_RECURSE ${PROJECT_NAME}_COMPONENT_HEADER
    release/dji/dji_*.hpp
    release/dji_*(?<!.)
    )

file(GLOB_RECURSE ${PROJECT_NAME}_COMPONENT_TEST_INC
    test/inc/dji_*_test.hpp
    )

file(GLOB_RECURSE ${PROJECT_NAME}_COMPONENT_TEST_SRC
    test/src/dji_*_test.cpp
    )

add_custom_target(${PROJECT_NAME}_COMPONENTS SOURCES
    ${${PROJECT_NAME}_COMPONENT_SRC}
    ${${PROJECT_NAME}_COMPONENT_INC}
    ${${PROJECT_NAME}_COMPONENT_HEADER}
    ${${PROJECT_NAME}_COMPONENT_TEST_INC}
    ${${PROJECT_NAME}_COMPONENT_TEST_SRC}
    )

#4 build
#4.1 compile static library
add_library(${PROJECT_NAME}_static
    STATIC
    ${${PROJECT_NAME}_COMPONENT_SRC}
    )

set_target_properties(${PROJECT_NAME}_static PROPERTIES
    PUBLIC_HEADER ${${PROJECT_NAME}_COMPONENT_HEADER}
    OUTPUT_NAME   ${PROJECT_NAME}
    )
#4.2 compile dynamic library
file(GLOB_RECURSE ${PROJECT_NAME}_COMPONENT_SAMPLES
    samples/*CMakeLists.txt)

#4.3 find and compile samples
if(${${PROJECT_NAME}_COMPONENT_SAMPLES})
    message("no samples for ${PROJECT_NAME} ${${PROJECT_NAME}_COMPONENT_SAMPLES}")
else()
    foreach(SAMPLE ${${PROJECT_NAME}_COMPONENT_SAMPLES})
        string(REPLACE "/CMakeLists.txt" "" SAMPLE_NAME ${SAMPLE})
        message("add ${SAMPLE_NAME} as a sample")
        add_subdirectory(${SAMPLE_NAME})
    endforeach()
endif()

#5 test
add_executable(${PROJECT_NAME}_test
    ${${PROJECT_NAME}_COMPONENT_TEST_SRC}
    )

#6 install

#7 clean

