#!/bin/bash

export CPPFLAGS="-I${PREFIX}/include ${CPPFLAGS}"
export LDFLAGS="-L${PREFIX}/lib -Wl,-rpath,${PREFIX}/lib ${LDFLAGS}"
export FFLAGS="$FFLAGS -std=legacy"

cd scilab
./configure --prefix=${PREFIX} \
            --without-javasci \
            --without-gui \
            --disable-build-help \
            --with-eigen-include=${PREFIX}/include/eigen3 \
            --without-modelica \
            --without-matio \
            --without-tk

make -j${CPU_COUNT}
make install
