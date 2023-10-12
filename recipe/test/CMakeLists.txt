cmake_minimum_required(VERSION 3.20)

project(test-libcurl LANGUAGES C)

add_executable(test-libcurl test.c)

find_path(libcurl_INCLUDE_DIR NAMES curl/curl.h)
find_library(libcurl_LIBRARY NAMES "${LIB_NAME}")
target_link_libraries(test-libcurl PRIVATE ${libcurl_LIBRARY})
target_include_directories(test-libcurl PRIVATE ${libcurl_INCLUDE_DIR})

enable_testing()
add_test(NAME test-libcurl COMMAND test-libcurl https://google.com)
