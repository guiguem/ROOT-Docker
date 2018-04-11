#!/bin/sh

export BASEDIR=/build

export PATH=${BASEDIR}/bin:${PATH}
export INCLUDE_PATH=${BASEDIR}/include:${INCLUDE_PATH}
export LIBRARY_PATH=${BASEDIR}/lib:${LIBRARY_PATH}
export LIBRARY_PATH=${BASEDIR}/lib64:${LIBRARY_PATH}
export LD_LIBRARY_PATH=${BASEDIR}/lib:${LIBRARY_PATH}
export LD_LIBRARY_PATH=${BASEDIR}/lib64:${LIBRARY_PATH}

export LIBDIR=${LD_LIBRARY_PATH}:${LIBDIR}

export MANPATH=${BASEDIR}/share/man/man1:${MANPATH}
export PKG_CONFIG_PATH=${BASEDIR}/lib/pkgconfig:${PKG_CONFIG_PATH}

export PYTHONPATH=${BASEDIR}/lib/root:${BASEDIR}/lib:${BASEDIR}:${PYTHONPATH}
export XDG_DATA_DIRS=${BASEDIR}/share:${XDG_DATA_DIRS}

export CC=`which cc`
export CXX=`which g++`
export LD=`which ld`

if [ -e ${BASEDIR}/bin/thisroot.sh ]; then
	source ${BASEDIR}/bin/thisroot.sh
fi
