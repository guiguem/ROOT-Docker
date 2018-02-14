#!/bin/bash

########################################################################
#
# collect source distributions for all dependencies
#
########################################################################

# get into the parent directory for all the source code and build proucts
mkdir /src
cd /src
pwd

# download current (on 2015/09/16) versions of all dependencies
echo "Downloading source files"
wget --input-file=/dependency_urls_root.txt --output-file=wget_log.txt --tries=3
echo "Download: complete!"
ls

mv Python-*.tgz Python-x.y.tgz
tar -xf Python-x.y.tgz
rm Python-x.y.tgz
mv Python-* Python-x.y                # python
ln -s Python-x.y python

gunzip cmake-3.10.2.tar.gz             # cmake
tar -xf cmake-3.10.2.tar
rm cmake-3.10.2.tar
ln -s cmake-3.10.2 cmake

tar -xvzf boost_1_66_0.tar.gz            # boost
rm boost_1_66_0.tar.gz
ln -s boost_1_66_0 boost

gunzip fftw-3.3.4.tar.gz              # fftw
tar -xf fftw-3.3.4.tar
rm fftw-3.3.4.tar
ln -s fftw-3.3.4 fftw

mv -v root*.source.tar.gz root-x.y.source.tar.gz
gunzip root-x.y.source.tar.gz         # root
tar -xf root-x.y.source.tar
rm root-x.y.source.tar
mv -v root-* root-x.y
ln -s root-x.y root


