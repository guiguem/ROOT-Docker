#!/bin/bash

source /setup.sh

mkdir /src
cd /src/
pwd

#echo "Environment variables:"
#env
echo "where are we?"
pwd

#######################################################################
#
# build all dependencies from source
#
########################################################################

# python2.7
echo "python"
cd python
ls
./configure --enable-shared --prefix=${BASEDIR} | tee config_log.txt
make -j3                                             | tee make_log.txt
make -j3 install                                     | tee make_install_log.txt
cd ..

echo "Environment variables after installing python:"
env
echo `which python`
echo `python -V`
echo `gcc --version`
echo `python --version`
echo `which cc`
echo `which g++`
echo `which ld`
echo "LD_LIBRARY_PATH: $LD_LIBRARY_PATH"
echo "LIBRARY_PATH: $LIBRARY_PATH"
echo "LIBDIR: $LIBDIR"
echo "PYTHONPATH: $PYTHONPATH"
echo "Library search path:"
echo `ldconfig -v 2>/dev/null | grep -v ^$'\t'`


# cmake
echo "cmake"
cd cmake/
ls
./configure  --prefix=${BASEDIR}     | tee config_log.txt
make -j3                             | tee make_log.txt
make -j3 install                     | tee make_install_log.txt
cd ..

# Boost
echo 'Boost'
cd boost/
./bootstrap.sh --prefix=${BASEDIR} --with-libraries=date_time,filesystem,program_options,system,thread | tee bootstrap_log.txt
./b2                             | tee b2_log.txt
./b2 install                     | tee b2_install_log.txt
cd ..

# FFTW
echo 'fftw'
cd fftw/
./configure --prefix=${BASEDIR} --enable-shared --enable-threads --with-pic  | tee config_log.txt
make -j3                                                                          | tee make_log.txt
make -j3 install                                                                  | tee make_install_log.txt
cd ..

# ROOT
echo 'ROOT'
cd root/
mkdir -p my_build
cd my_build
cmake -D CMAKE_INSTALL_PREFIX:PATH=${BASEDIR} -D CMAKE_INSTALL_BINDIR:PATH=${BASEDIR}/bin -D CMAKE_INSTALL_LIBDIR:PATH=${BASEDIR}/lib -D CMAKE_INSTALL_INCLUDEDIR:PATH=${BASEDIR}/include -D gnuinstall=ON -D roofit=ON  -D builtin_gsl=ON -D tmva=ON ..  | tee config_log.txt
make -j3                            | tee make_log.txt
make -j3                            | tee make_log.txt
make -j3                            | tee make_log.txt
make -j3 install                    | tee make_install_log.txt
cd /src

# Clean up the source directory
pwd
rm -rf *
