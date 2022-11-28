source /etc/profile.d/modules.sh
module use /opt/nvidia/hpc_sdk/modulefiles
module use /opt/tools-hackathon/arm/compilers/modulefiles
module use /opt/tools-hackathon/arm/forge/modulefiles
module use /opt/tools-hackathon/openmpi/modulefiles

export DEST=$HOME/code_saturne_7.2.0
mkdir -p build && cd build
export CC=mpicc
export CXX=mpicxx
export FC=mpifort

../configure CC="$CC" CXX="$CXX" FC="$FC" --prefix=$DEST --disable-gui --without-med --without-hdf5 --without-cgns--without-metis--disable-salome --without-salome --without-eos --disable-static --enable-long-gnum

make -j7
make install
