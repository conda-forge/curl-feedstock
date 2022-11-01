#!/bin/bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/libtool/build-aux/config.* .

# need macosx-version-min flags set in cflags and not cppflags
export CFLAGS="$CFLAGS $CPPFLAGS"

if [[ "${PKG_NAME}" == "libcurl-securetransport-static" ]]; then
    USESSL="--with-secure-transport"
    STATIC_BUILD="--enable-static --disable-shared"
else
    USESSL="--with-openssl=${PREFIX}"
fi
./configure \
    --prefix=${PREFIX} \
    --host=${HOST} \
    --disable-ldap \
    --with-ca-bundle=${PREFIX}/ssl/cacert.pem \
    $USESSL $STATIC_BUILD \
    --with-zlib=${PREFIX} \
    --with-gssapi=${PREFIX} \
    --with-libssh2=${PREFIX} \
    --with-nghttp2=${PREFIX} \
|| cat config.log

make -j${CPU_COUNT} ${VERBOSE_AT}

# TODO :: test 1119... exit FAILED
# make test
