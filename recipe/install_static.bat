cd winbuild

if %ARCH% == 32 (
    set ARCH_STRING=x86
) else (
    set ARCH_STRING=x64
)

COPY ..\builds\libcurl-vc%VS_MAJOR:"=%-%ARCH_STRING%-release-static-zlib-dll-ssh2-dll-ipv6-sspi-schannel-obj-lib\lib\libcurl_a.lib %LIBRARY_PREFIX%\lib\libcurl_a.lib
if %ERRORLEVEL% GTR 3 exit 1

exit 0
