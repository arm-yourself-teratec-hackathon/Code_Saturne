#!/usr/bin/env bash

if [[ -n $ZSH_VERSION && $ZSH_EVAL_CONTEXT =~ :file$ ]] || 
  [[ -n $BASH_VERSION ]] && (return 0 2>/dev/null)
then
    :
else
    echo "Usage : source $0" && exit 0
fi


if [ ! -f configure ]; then
echo "No configure ... please run ./sbin/bootstrap";
# ./sbin/bootstrap
return 0
fi

source /etc/profile.d/modules.sh
# module load openmpi/acfl/4.1.4

command -v mpicc >/dev/null 2>&1 || { echo >&2 "mpicc was not found"; return 0; }
command -v mpic++ >/dev/null 2>&1 || { echo >&2 "mpic++ was not found"; return 0; }
command -v mpifort >/dev/null 2>&1 || { echo >&2 "mpifort was not found"; return 0; }

export DEST="$HOME/Code_Saturne/install-openmp"
export CC="mpicc"
export CXX="mpic++"
export FC="mpifort"

mkdir -p build && cd build
../configure CC="$CC" CXX="$CXX" FC="$FC" --prefix="$DEST" --disable-gui --without-med --without-hdf5 --without-cgns --without-metis --disable-salome --without-salome --without-eos --disable-static --enable-long-gnum --enable-openmp-target

make -j7
make install

cd ..
