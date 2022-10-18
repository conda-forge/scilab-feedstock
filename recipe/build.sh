#!/bin/bash

export CPPFLAGS="-I${PREFIX}/include ${CPPFLAGS}"
export LDFLAGS="-L${PREFIX}/lib -Wl,-rpath,${PREFIX}/lib ${LDFLAGS}"
export FFLAGS="$FFLAGS -std=legacy"

if [[ `uname` == 'Darwin' ]]; then
  EXTRA_CONFIGURE_ARGS="--disable-dependency-tracking"
  export LDFLAGS="${LDFLAGS//-Wl,-dead_strip_dylibs/}"
  export CPPFLAGS="-DNDEBUG ${CPPFLAGS}"
fi

cd scilab
./configure --prefix=${PREFIX} \
            --without-javasci \
            --without-gui \
            --disable-build-help \
            --with-eigen-include=${PREFIX}/include/eigen3 \
            --without-modelica \
            --without-tk

make -j${CPU_COUNT}
make install
