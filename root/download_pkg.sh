#!/bin/bash

########################################################################
#
# collect source distributions for all dependencies
#
########################################################################

# get into the parent directory for all the source code and build proucts
mkdir /src
cd src/
pwd

# download current (on 2015/09/16) versions of all dependencies
echo "Downloading source files"
wget --input-file=/dependency_urls_root.txt --output-file=wget_log.txt --tries=3
echo "Download: complete!"
ls

gunzip cmake-3.4.3.tar.gz             # cmake
tar -xf cmake-3.4.3.tar
ln -s cmake-3.4.3 cmake

mv download boost_1_59_0.tar.gz       # boost
gunzip boost_1_59_0.tar.gz
tar -xf boost_1_59_0.tar
ln -s boost_1_59_0 boost

gunzip fftw-3.3.4.tar.gz              # fftw
tar -xf fftw-3.3.4.tar
ln -s fftw-3.3.4 fftw

gunzip root_v6.10.06.source.tar.gz    # root
tar -xf root_v6.10.06.source.tar
ln -s root-6.10.06 root