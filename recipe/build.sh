#!/bin/bash

export CPPFLAGS="-I${PREFIX}/include ${CPPFLAGS}"
export LDFLAGS="-L${PREFIX}/lib -Wl,-rpath,${PREFIX}/lib ${LDFLAGS}"

if [[ `uname` == 'Darwin' ]]; then
  EXTRA_CONFIGURE_ARGS="--without-tk --enable-code-coverage=no"
  # Disable warnings to prevent travis error w.r.t. log length.
  # "The job exceeded the maximum log length, and has been terminated."
  export CPPFLAGS="-w ${CPPFLAGS}"
fi

cd scilab
./configure --prefix=${PREFIX} \
            --without-javasci \
            --without-gui \
            --disable-build-help \
            --with-eigen-include=${PREFIX}/include/eigen3 \
            --without-modelica \
            ${EXTRA_CONFIGURE_ARGS}

if [[ `uname` == 'Darwin' ]]; then
  patch -p1 < ${RECIPE_DIR}/osx-make-patch.patch
fi

make -j${CPU_COUNT}

make install
