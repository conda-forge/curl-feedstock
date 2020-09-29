cd winbuild

if %ARCH% == 32 (
    set ARCH_STRING=x86
) else (
    set ARCH_STRING=x64
)

set BUILD_PATH=..\builds\libcurl-vc%VS_MAJOR:"=%-%ARCH_STRING%-release-dll-zlib-dll-ssh2-dll-ipv6-sspi-winssl

robocopy %BUILD_PATH%\lib %LIBRARY_LIB% *.* /E
robocopy %BUILD_PATH%\include %LIBRARY_INC% *.* /E
robocopy %BUILD_PATH%\bin\libcurl.dll %LIBRARY_BIN% *.* /E
if %ERRORLEVEL% GTR 3 exit 1

exit 0
