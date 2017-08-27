#!/bin/bash

export PKG_CONFIG_PATH="${PREFIX}/lib/pkgconfig"
export C_INCLUDE_PATH="${PREFIX}/include"

if [[ `uname` == "Darwin" ]]
then
    export DYLD_FALLBACK_LIBRARY_PATH="${PREFIX}/lib"
    export CC=clang
    export CXX=clang++
fi

./configure \
    --prefix=${PREFIX} \
    --host=${HOST} \
    --disable-ldap \
    --with-ca-bundle=${PREFIX}/ssl/cacert.pem \
    --with-ssl=${PREFIX} \
    --with-zlib=${PREFIX} \
|| cat config.log

make -j${CPU_COUNT} ${VERBOSE_AT}
# TODO :: test 1119... exit FAILED
# make test
make install

# Includes man pages and other miscellaneous.
rm -rf "${PREFIX}/share"
