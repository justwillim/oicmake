include(ExternalProject)
message( "External project - ${EXTERNAL_DEPENDENCY}" )
ExternalProject_Add(
    googletest
    GIT_REPOSITORY https://github.com/google/googletest.git
    CMAKE_ARGS  -DCMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG:PATH=DebugLibs
                -DCMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE:PATH=ReleaseLibs
                -DCMAKE_CXX_FLAGS=${MSVC_COMPILER_DEFS}
                -Dgtest_force_shared_crt=${GTEST_FORCE_SHARED_CRT}
                -Dgtest_disable_pthreads=${GTEST_DISABLE_PTHREADS}
    PREFIX ${CMAKE_CURRENT_BINARY_DIR}
    # Disable steps
    UPDATE_COMMAND ""
    INSTALL_COMMAND ""
 )

