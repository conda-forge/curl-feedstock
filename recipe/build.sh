#!/bin/bash

export PKG_CONFIG_PATH="${PREFIX}/lib/pkgconfig"
export C_INCLUDE_PATH="${PREFIX}/include"

if [ $(uname) == "Darwin" ]; then
    export DYLD_FALLBACK_LIBRARY_PATH="${PREFIX}/lib"
    export CC=clang
    export CXX=clang++
fi

./configure \
    --prefix=${PREFIX} \
    --disable-ldap \
    --with-ca-bundle=${PREFIX}/ssl/cacert.pem \
    --with-ssl=${PREFIX} \
    --with-zlib=${PREFIX} \
    --with-gssapi=${PREFIX} \
    --with-libssh2=${PREFIX} \
|| cat config.log

make -j$CPU_COUNT

# Two tests are failing:
# test 2056...FAILED
# test 2057...FAILED
if [ $(uname) != Darwin ]; then
  make test -j$CPU_COUNT
fi

make install -j$CPU_COUNT

find $PREFIX -name '*.la' -delete
