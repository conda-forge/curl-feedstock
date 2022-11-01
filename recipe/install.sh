# TODO :: test 1119... exit FAILED
# make test
make install

# Includes man pages and other miscellaneous.
rm -rf "${PREFIX}/share"

if [[ "${PKG_NAME}" == "libcurl" ]]; then
	rm $PREFIX/lib/libcurl.a
	rm $PREFIX/bin/curl
elif [[ "${PKG_NAME}" == "libcurl-static" || "${PKG_NAME}" == "libcurl-securetransport-static" ]]; then
	rm $PREFIX/bin/curl
elif [[ "${PKG_NAME}" == "curl" ]]; then
	rm $PREFIX/lib/libcurl.a
fi