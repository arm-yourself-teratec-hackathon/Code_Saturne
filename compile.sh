#!/bin/bash

if [[ -n $ZSH_VERSION && $ZSH_EVAL_CONTEXT =~ :file$ ]] || 
  [[ -n $BASH_VERSION ]] && (return 0 2>/dev/null)
then
    :
else
    echo "Usage : source $0" && exit 0
fi

export DEST="$HOME/code_saturne_7.2.0"
export CC="mpicc"
export CXX="mpic++"
export FC="mpifort"

mkdir -p build && cd build
../configure CC="$CC" CXX="$CXX" FC="$FC" --prefix="$DEST" --disable-gui --without-med --without-hdf5 --without-cgns --without-metis --disable-salome --without-salome --without-eos --disable-static --enable-long-gnum

make -j7
make install