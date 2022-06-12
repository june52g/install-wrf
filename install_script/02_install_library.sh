#!/bin/bash
## WRF installation with parallel process.

/bin/bash -c "source /opt/intel/oneapi/setvars.sh"

mkdir -p /data/downloads
cd /data/downloads
wget -c https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.5/src/hdf5-1.10.5.tar.gz
wget -c -O netcdf-c-4.7.1.tar.gz https://github.com/Unidata/netcdf-c/archive/refs/tags/v4.7.1.tar.gz
wget -c https://downloads.unidata.ucar.edu/netcdf-fortran/4.5.1/netcdf-fortran-4.5.1.zip
wget -c http://www.mpich.org/static/downloads/3.3.1/mpich-3.3.1.tar.gz
wget -c https://download.sourceforge.net/libpng/libpng-1.6.37.tar.gz
wget -c https://www.ece.uvic.ca/~frodo/jasper/software/jasper-1.900.1.zip
wget -c http://mvapich.cse.ohio-state.edu/download/mvapich/mv2/mvapich2-2.3.7.tar.gz

# Compilers
export DIR=/wrf/Library
export CC=icc
export FC=ifort
export F90=ifort
export CXX=icpc

mkdir -p /wrf/BUILD

# zlib
cd /wrf/BUILD
cp /data/downloads/zlib-1.2.11.tar.gz /wrf/BUILD
tar -xvzf zlib-1.2.11.tar.gz
cd zlib-1.2.11/
./configure --prefix=$DIR
make
make install
sleep 10

# hdf5 library for netcdf4 functionality
cd /wrf/BUILD
cp /data/downloads/hdf5-1.10.5.tar.gz /wrf/BUILD
tar -xvzf hdf5-1.10.5.tar.gz
cd hdf5-1.10.5
./configure --prefix=$DIR --with-zlib=$DIR --enable-fortran
make
make install
sleep 10

export HDF5=$DIR
export LD_LIBRARY_PATH=$DIR/lib:$LD_LIBRARY_PATH

## Install NETCDF C Library
cd /wrf/BUILD
cp /data/downloads/netcdf-c-4.7.1.tar.gz /wrf/BUILD
tar -xvzf netcdf-c-4.7.1.tar.gz
cd netcdf-c-4.7.1/
export CPPFLAGS=-I$DIR/include
export LDFLAGS=-L$DIR/lib
./configure --prefix=$DIR --disable-dap
make
make install
sleep 10

export PATH=$DIR/bin:$PATH
export NETCDF=$DIR

## NetCDF fortran library
cd /wrf/BUILD
cp /data/downloads/netcdf-fortran-4.5.1.zip /wrf/BUILD
unzip netcdf-fortran-4.5.1.zip
cd netcdf-fortran-4.5.1/
export LD_LIBRARY_PATH=$DIR/lib:$LD_LIBRARY_PATH
export CPPFLAGS=-I$DIR/include
export LDFLAGS=-L$DIR/lib
export LIBS="-lnetcdf -lhdf5_hl -lhdf5 -lz"
./configure --prefix=$DIR --disable-shared
make
make install
sleep 10

# libpng
cd /wrf/BUILD
cp /data/downloads/libpng-1.6.37.tar.gz /wrf/BUILD
export LDFLAGS=-L$DIR/lib
export CPPFLAGS=-I$DIR/include
tar -xvzf libpng-1.6.37.tar.gz
cd libpng-1.6.37/
./configure --prefix=$DIR
make
make install
sleep 10

# JasPer
unzip jasper-1.900.1.zip
cd jasper-1.900.1/
autoreconf -i
./configure --prefix=$DIR
make
make install
export JASPERLIB=$DIR/lib
export JASPERINC=$DIR/include
sleep 10


unset F90
cd /wrf/BUILD
cp /data/downloads/mvapich2-2.3.7.tar.gz /wrf/BUILD
gzip -dc mvapich2-2.3.7.tar.gz | tar -x
cd mvapich2-2.3.7
./configure --prefix=$DIR
make -j4
make install
export MV2_SMP_USE_CMA=0
export F90=ifort
