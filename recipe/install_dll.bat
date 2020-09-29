cd winbuild

if %ARCH% == 32 (
    set ARCH_STRING=x86
) else (
    set ARCH_STRING=x64
)

set BUILD_FOLDER=..\builds\libcurl-vc%VS_MAJOR:"=%-%ARCH_STRING%-release-dll-zlib-dll-ssh2-dll-ipv6-sspi-winssl

robocopy %BUILD_FOLDER%\ %LIBRARY_PREFIX% *.* /E /XF %BUILD_FOLDER%\curl.exe*
if %ERRORLEVEL% GTR 3 exit 1

exit 0
