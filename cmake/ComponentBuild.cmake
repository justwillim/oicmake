#1 options
#1.1 oi dependency

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
    endforeach(SAMPLE)
endif()

#5 test
#add_executable(${PROJECT_NAME}_test
#    ${${PROJECT_NAME}_COMPONENT_TEST_SRC}
#    )

#6 install

set(${PROJECT_NAME}_INC_INSTALL_DIR include               CACHE PATH "")
set(${PROJECT_NAME}_LIB_INSTALL_DIR lib                   CACHE PATH "")
set(${PROJECT_NAME}_SYS_INSTALL_DIR etc/${PROJECT_NAME}   CACHE PATH "")

include(CMakePackageConfigHelpers)
configure_package_config_file(Config.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/Config.cmake
  INSTALL_DESTINATION ${${PROJECT_NAME}_LIB_INSTALL_DIR}/${PROJECT_INSTALL_PATH}/cmake
  PATH_VARS
  ${PROJECT_NAME}_INC_INSTALL_DIR
  ${PROJECT_NAME}_SYS_INSTALL_DIR
  )

export(TARGETS ${PROJECT_NAME}_static FILE ${CMAKE_CURRENT_BINARY_DIR}/ConfigImport.cmake)

write_basic_package_version_file(
  ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_PATH_NAME}ConfigVersion.cmake
  VERSION 1.2.3
  COMPATIBILITY SameMajorVersion
  )


install(FILES ${CMAKE_CURRENT_BINARY_DIR}/Config.cmake
              ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_PATH_NAME}ConfigImport.cmake
              ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_PATH_NAME}ConfigVersion.cmake
        DESTINATION ${${PROJECT_NAME}_LIB_INSTALL_DIR}/${PROJECT_INSTALL_PATH}/cmake )



#7 clean

