include(CheckIncludeFile)
include(CheckSymbolExists)
include(CheckFunctionExists)
include(CheckLibraryExists)
include(CheckTypeSize)
include(CheckCXXSourceCompiles)
include(TestBigEndian)

set(PACKAGE ${APPLICATION_NAME})
set(VERSION ${APPLICATION_VERSION})
set(DATADIR ${DATA_INSTALL_DIR})
set(LIBDIR ${LIB_INSTALL_DIR})
set(PLUGINDIR "${PLUGIN_INSTALL_DIR}-${LIBRARY_SOVERSION}")
set(SYSCONFDIR ${SYSCONF_INSTALL_DIR})

set(BINARYDIR ${CMAKE_BINARY_DIR})
set(SOURCEDIR ${CMAKE_SOURCE_DIR})

function(COMPILER_DUMPVERSION _OUTPUT_VERSION)
    # Remove whitespaces from the argument.
    # This is needed for CC="ccache gcc" cmake ..
    string(REPLACE " " "" _C_COMPILER_ARG "${CMAKE_C_COMPILER_ARG1}")

    execute_process(
        COMMAND
            ${CMAKE_C_COMPILER} ${_C_COMPILER_ARG} -dumpversion
        OUTPUT_VARIABLE _COMPILER_VERSION
    )

    string(REGEX REPLACE "([0-9])\\.([0-9])(\\.[0-9])?" "\\1\\2"
        _COMPILER_VERSION ${_COMPILER_VERSION})

    set(${_OUTPUT_VERSION} ${_COMPILER_VERSION} PARENT_SCOPE)
endfunction()

if(CMAKE_COMPILER_IS_GNUCC AND NOT MINGW)
    compiler_dumpversion(GNUCC_VERSION)
    if (NOT GNUCC_VERSION EQUAL 34)
        check_c_compiler_flag("-fvisibility=hidden" WITH_VISIBILITY_HIDDEN)
    endif (NOT GNUCC_VERSION EQUAL 34)
endif(CMAKE_COMPILER_IS_GNUCC AND NOT MINGW)

# DEFINITIONS
if (SOLARIS)
    add_definitions(-D__EXTENSIONS__)
endif (SOLARIS)

# HEADER FILES
check_include_file(assert.h HAVE_ASSERT_H)
check_include_file(dlfcn.h HAVE_DLFCN_H)
check_include_file(inttypes.h HAVE_INTTYPES_H)
check_include_file(malloc.h HAVE_MALLOC_H)
check_include_file(memory.h HAVE_MEMORY_H)
check_include_file(setjmp.h HAVE_SETJMP_H)
check_include_file(signal.h HAVE_SIGNAL_H)
check_include_file(stdarg.h HAVE_STDARG_H)
check_include_file(stddef.h HAVE_STDDEF_H)
check_include_file(stdint.h HAVE_STDINT_H)
check_include_file(stdio.h HAVE_STDIO_H)
check_include_file(stdlib.h HAVE_STDLIB_H)
check_include_file(string.h HAVE_STRING_H)
check_include_file(strings.h HAVE_STRINGS_H)
check_include_file(sys/stat.h HAVE_SYS_STAT_H)
check_include_file(sys/types.h HAVE_SYS_TYPES_H)
check_include_file(unistd.h HAVE_UNISTD_H)


# FUNCTIONS

check_function_exists(strncpy HAVE_STRNCPY)

check_function_exists(calloc HAVE_CALLOC)
check_function_exists(exit HAVE_EXIT)
check_function_exists(fprintf HAVE_FPRINTF)
check_function_exists(free HAVE_FREE)
check_function_exists(longjmp HAVE_LONGJMP)
check_function_exists(malloc HAVE_MALLOC)
check_function_exists(memcpy HAVE_MEMCPY)
check_function_exists(memset HAVE_MEMSET)
check_function_exists(printf HAVE_PRINTF)
check_function_exists(setjmp HAVE_SETJMP)
check_function_exists(signal HAVE_SIGNAL)
check_function_exists(strsignal HAVE_STRSIGNAL)
check_function_exists(sprintf HAVE_SNPRINTF)
check_function_exists(strcmp HAVE_STRCMP)
check_function_exists(strcpy HAVE_STRCPY)
check_function_exists(vsnprintf HAVE_VSNPRINTF)

if (WIN32)
    check_function_exists(_vsnprintf_s HAVE__VSNPRINTF_S)
    check_function_exists(_vsnprintf HAVE__VSNPRINTF)
    check_function_exists(_snprintf HAVE__SNPRINTF)
    check_function_exists(_snprintf_s HAVE__SNPRINTF_S)
endif (WIN32)

set(CMOCKA_REQUIRED_LIBRARIES ${CMAKE_REQUIRED_LIBRARIES} CACHE INTERNAL "cmocka required system libraries")

# OPTIONS

# ENDIAN
if (NOT WIN32)
    test_big_endian(WORDS_BIGENDIAN)
endif (NOT WIN32)
