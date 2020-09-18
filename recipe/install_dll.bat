cd winbuild

if %ARCH% == 32 (
    set ARCH_STRING=x86
) else (
    set ARCH_STRING=x64
)

robocopy ..\builds\libcurl-vc%VS_MAJOR:"=%-%ARCH_STRING%-release-dll-zlib-dll-ssh2-dll-ipv6-sspi-schannel-obj-lib\ %LIBRARY_PREFIX% *.* /E
if %ERRORLEVEL% GTR 3 exit 1

del /f %LIBRARY_BIN%\curl.exe

exit 0
