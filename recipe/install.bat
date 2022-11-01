cd winbuild

if %ARCH% == 32 (
    set ARCH_STRING=x86
) else (
    set ARCH_STRING=x64
)

REM install static library
if "%PKG_NAME%" == "libcurl-static" (
    copy ..\builds\libcurl-vc%VS_MAJOR:"=%-%ARCH_STRING%-release-static-zlib-dll-ssh2-dll-ipv6-sspi-schannel\lib\libcurl_a.lib %LIBRARY_PREFIX%\lib\libcurl_a.lib
    if %ERRORLEVEL% GTR 3 exit 1
)

REM install everything else
robocopy ..\builds\libcurl-vc%VS_MAJOR:"=%-%ARCH_STRING%-release-dll-zlib-dll-ssh2-dll-ipv6-sspi-schannel\ %LIBRARY_PREFIX% *.* /E
if %ERRORLEVEL% GTR 3 exit 1

if not "%PKG_NAME%" == "curl" (
    del /f %LIBRARY_PREFIX%\bin\curl.exe
    if %ERRORLEVEL% GTR 3 exit 1
)

exit 0
