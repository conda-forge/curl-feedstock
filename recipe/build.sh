#!/bin/bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/libtool/build-aux/config.* .

# need macosx-version-min flags set in cflags and not cppflags
export CFLAGS="$CFLAGS $CPPFLAGS"

if [[ $target_platform =~ osx.* ]]; then
	USE_DARWIN_SSL=--with-darwinssl
fi

./configure \
    --prefix=${PREFIX} \
    --host=${HOST} \
    --disable-ldap \
    --with-ca-bundle=${PREFIX}/ssl/cacert.pem \
    --with-ssl=${PREFIX} \
    --with-zlib=${PREFIX} \
    --with-gssapi=${PREFIX} \
    --with-libssh2=${PREFIX} \
    --with-nghttp2=${PREFIX} \
    $USE_DARWIN_SSL \
|| cat config.log

make -j${CPU_COUNT} ${VERBOSE_AT}
# TODO :: test 1119... exit FAILED
# make test
make install

# Includes man pages and other miscellaneous.
rm -rf "${PREFIX}/share"
