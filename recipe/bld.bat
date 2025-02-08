cd winbuild

if %ARCH% == 32 (
    set ARCH_STRING=x86
) else (
    set ARCH_STRING=x64
)

REM This is implicitly using WinSSL.  See Makefile.vc for more info.
cmake -G "Ninja" ^
    %CMAKE_ARGS% ^
    -A x64 ^
    -D CMAKE_BUILD_TYPE:STRING="Release" ^
    -D CMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -D CMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON ^
    -D BUILD_SHARED_LIBS:BOOL=ON ^
    -D CURL_ZLIB:BOOL=ON ^
    -D CURL_USE_LIBSSH2:BOOL=ON ^
    -D USE_WIN32_IDN:BOOL=OFF ^
    -D CURL_WINDOWS_SSPI:BOOL=ON ^
    "%SRC_DIR%"
if errorlevel 1 exit 1
cmake --build . --target install --config Release -- -v
if errorlevel 1 exit 1

REM This is implicitly using WinSSL.  See Makefile.vc for more info.
cmake -G "Ninja" ^
    %CMAKE_ARGS% ^
    -A x64 ^
    -D CMAKE_BUILD_TYPE:STRING="Release" ^
    -D CMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -D CMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON ^
    -D BUILD_SHARED_LIBS:BOOL=OFF ^
    -D CURL_ZLIB:BOOL=ON ^
    -D CURL_USE_LIBSSH2:BOOL=ON ^
    -D USE_WIN32_IDN:BOOL=OFF ^
    -D CURL_WINDOWS_SSPI:BOOL=ON ^
    "%SRC_DIR%"
if errorlevel 1 exit 1
cmake --build . --target install --config Release -- -v

exit 0
