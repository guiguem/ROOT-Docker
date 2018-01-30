FROM ubuntu:14.04

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install \
    make g++ gcc git libx11-dev libxpm-dev libxft-dev libxext-dev lsb-release locales libxml2-dev libgsl0-dev ccache wget python-dev python-pip

# download
ADD ./dependency_urls.txt /dependency_urls_root.txt
ADD ./download_pkg.sh /download_pkg_root.sh
ADD ./setup.sh /setup.sh
ADD build.sh /build_root.sh
RUN chmod +x download_pkg_root.sh &&\
    ./download_pkg_root.sh &&\
    chmod +x setup.sh &&\
    chmod +x build_root.sh &&\
    ./build_root.sh
