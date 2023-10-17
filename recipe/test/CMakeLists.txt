cmake_minimum_required(VERSION 3.20)

project(test-libcurl LANGUAGES C)

add_executable(test-libcurl test.c)

find_path(libcurl_INCLUDE_DIR NAMES curl/curl.h)
target_include_directories(test-libcurl PRIVATE ${libcurl_INCLUDE_DIR})

if(BUILD_SHARED_LIBS)
    if(WIN32)
        set(required_deps libcurl)
    elseif(APPLE)
        set(required_deps libcurl.dylib)
    else()
        set(required_deps libcurl.so)
    endif()
else()
    if(WIN32)
        set(required_deps libcurl_a)
    else()
        # Order matters; dependent before dependency
        set(
            required_deps
            # curl
            libcurl.a
            # krb5
            libgssapi_krb5.a
            libkrb5.a
            libk5crypto.a
            libkrb5support.a
            libcom_err.a
            # openssl
            libssl.a
            libcrypto.a
            # Misc dependencies
            libnghttp2.a
            libssh2.a
            libzstd.a
            libz.a
        )
        if(APPLE)
            list(APPEND required_deps resolv)
        else()
            list(APPEND required_deps dl pthread resolv)
        endif()
    endif()
endif()

foreach(dep ${required_deps})
    set(dep_LIBRARY "${dep}-NOTFOUND")
    find_library(dep_LIBRARY NAMES "${dep}" REQUIRED)
    message(STATUS "Found library ${dep_LIBRARY}")
    target_link_libraries(test-libcurl PRIVATE ${dep_LIBRARY})
endforeach()

if(APPLE)
    target_link_libraries(
        test-libcurl
        PRIVATE
            "-framework CoreFoundation"
            "-framework CoreServices"
            "-framework Security"
            "-framework Kerberos"
    )
endif()

if(NOT BUILD_SHARED_LIBS)
    target_compile_definitions(test-libcurl PRIVATE CURL_STATICLIB)
endif()

enable_testing()
add_test(NAME test-libcurl COMMAND test-libcurl https://google.com)
