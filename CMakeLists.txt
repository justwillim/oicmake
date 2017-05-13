cmake_minimum_required(VERSION 2.8)

project(OI)

#0 options


#1 var

#2 tool chain

#3 gengerator

#4 find resources

#5 build
file(GLOB ${PROJECT_NAME}_COMPONENTS
    component/*/CMakeLists.txt)

if(${${PROJECT_NAME}_COMPONENTS})
    message("no component for ${PROJECT_NAME} ${${PROJECT_NAME}_COMPONENTS}")
else()
    foreach(COMPONENTS ${${PROJECT_NAME}_COMPONENTS})
        string(REPLACE "/CMakeLists.txt" "" COMPONENT ${COMPONENTS})
        message("add ${COMPONENT} as a compunent")
        add_subdirectory(${COMPONENT})
    endforeach()
endif()

#6 test

#7 install

#8 clean

