#!/usr/bin/env bash

set -e

[ -d freetype ] || git clone --recurse-submodules https://github.com/freetype/freetype --depth=1

echo "Building freetype.."
cd freetype
./autogen.sh
./configure --with-zlib=no --with-bzip2=yes --with-png=yes --with-harfbuzz=yes --with-librsvg=yes --with-brotli=yes --enable-shared=no --enable-year2038
if [ $(uname -s) = 'Darwin' ]; then
    make -j$(sysctl -n hw.ncpu)
    LIB_EXT=darwin
else
    make -j$(nproc)
    LIB_EXT=linux
fi

cp objs/.libs/libfreetype.a ../freetype.$LIB_EXT.a
