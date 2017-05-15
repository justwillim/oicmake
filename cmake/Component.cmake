#1 set project properties
include(${OI_CMAKE_PATH}/cmake/ComponentName.cmake)

#2 init dependency
include(${OI_CMAKE_PATH}/cmake/ComponentDependency.cmake)
#3 tool chain

#4 cmake
include(${OI_CMAKE_PATH}/cmake/ComponentBuild.cmake)
