set CMAKE_CONFIG=Release

:: Create CMake build directory
mkdir build_%CMAKE_CONFIG%
if errorlevel 1 exit 1
pushd build_%CMAKE_CONFIG%
if errorlevel 1 exit 1

:: This is implicitly using WinSSL.  See Makefile.vc for more info.
cmake -G "Ninja" ^
    %CMAKE_ARGS% ^
    -D CMAKE_BUILD_TYPE:STRING="%CMAKE_CONFIG%" ^
    -D CMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -D CMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON ^
    -D BUILD_SHARED_LIBS:BOOL=ON ^
    -D CURL_ZLIB:BOOL=ON ^
    -D CURL_USE_LIBPSL:BOOL=OFF ^
    -D CURL_USE_LIBSSH2:BOOL=ON ^
    -D USE_WIN32_IDN:BOOL=OFF ^
    -D CURL_WINDOWS_SSPI:BOOL=ON ^
    "%SRC_DIR%"
if errorlevel 1 exit 1
cmake --build . --target install --config Release -- -v
if errorlevel 1 exit 1

:: This is implicitly using WinSSL.  See Makefile.vc for more info.
cmake -G "Ninja" ^
    %CMAKE_ARGS% ^
    -D CMAKE_BUILD_TYPE:STRING="%CMAKE_CONFIG%" ^
    -D CMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -D CMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON ^
    -D BUILD_SHARED_LIBS:BOOL=OFF ^
    -D CURL_ZLIB:BOOL=ON ^
    -D CURL_USE_LIBPSL:BOOL=OFF ^
    -D CURL_USE_LIBSSH2:BOOL=ON ^
    -D USE_WIN32_IDN:BOOL=OFF ^
    -D CURL_WINDOWS_SSPI:BOOL=ON ^
    "%SRC_DIR%"
if errorlevel 1 exit 1
cmake --build . --target install --config Release -- -v
if errorlevel 1 exit 1

popd
if errorlevel 1 exit 1
