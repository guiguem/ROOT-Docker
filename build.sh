#!/bin/bash

source /setup.sh

cd /src/

#echo "Environment variables:"
#env
echo "where are we?"
pwd
echo "content"
ls -altr

#######################################################################
#
# build all dependencies from source
#
########################################################################

# python
echo "Installing python"
cd python
./configure --enable-shared --prefix=${BASEDIR} | tee config_log.txt
make -j3                                             | tee make_log.txt
make -j3 install                                     | tee make_install_log.txt
wget https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py pip setuptools wheel
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
echo "Installing cmake"
cd cmake/
ls
./configure  --prefix=${BASEDIR}     | tee config_log.txt
make -j3                             | tee make_log.txt
make -j3 install                     | tee make_install_log.txt
cd ..

# Boost
echo 'Installing Boost'
cd boost/
./bootstrap.sh --prefix=${BASEDIR} --with-libraries=date_time,filesystem,program_options,system,thread | tee bootstrap_log.txt
./b2                             | tee b2_log.txt
./b2 install                     | tee b2_install_log.txt
cd ..

# FFTW
echo 'Installing fftw'
cd fftw/
./configure --prefix=${BASEDIR} --enable-shared --enable-threads --with-pic  | tee config_log.txt
make -j3                                                                          | tee make_log.txt
make -j3 install                                                                  | tee make_install_log.txt
cd ..

# ROOT
pwd
ls -altr
echo 'Installing ROOT'
cd root
mkdir -p my_build
cd my_build
cmake -D CMAKE_INSTALL_PREFIX:PATH=${BASEDIR} -D CMAKE_INSTALL_BINDIR:PATH=${BASEDIR}/bin -D CMAKE_INSTALL_LIBDIR:PATH=${BASEDIR}/lib -D CMAKE_INSTALL_INCLUDEDIR:PATH=${BASEDIR}/include -DPYTHON_EXECUTABLE=/build/bin/python -D gnuinstall=ON -D roofit=ON  -D builtin_gsl=ON -D tmva=ON ..  | tee config_log.txt
make -j3                            | tee make_log.txt
make -j3                            | tee make_log.txt
make -j1                            | tee make_log.txt
make -j3 install                    | tee make_install_log.txt
cd ../..

# Clean up the source directory
rm -rf /src
