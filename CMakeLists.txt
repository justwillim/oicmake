cmake_minimum_required(VERSION 2.8)

project(OI)

#0 options

#1 var


#2 tool chain

#3 gengerator

#4 add components
file(GLOB ${PROJECT_NAME}_COMPONENTS
    component/*/CMakeLists.txt)

if(${PROJECT_NAME}_COMPONENTS)
    foreach(COMPONENTS ${${PROJECT_NAME}_COMPONENTS})
        string(REPLACE "/CMakeLists.txt" "" COMPONENT ${COMPONENTS})
        message("\nadd ${COMPONENT} as a component")
        add_subdirectory(${COMPONENT})
    endforeach(COMPONENTS)
else()
    message("no component for ${PROJECT_NAME} ${${PROJECT_NAME}_COMPONENTS}")
endif()

#5 build OI
#5.1 find cmake files
file(GLOB_RECURSE ${PROJECT_NAME}_CMAKE_TEMPLATE
    cmake/*
    )


#6 test

#7 install

#7.2 uninstall
configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/cmake_uninstall.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake" IMMEDIATE @ONLY)

add_custom_target(uninstall
    COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake)

#8 clean

