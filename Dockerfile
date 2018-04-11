FROM debian:jessie

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install \
    make g++ gcc git libx11-dev libxpm-dev libxft-dev libxext-dev lsb-release locales libxml2-dev libgsl0-dev ccache wget python-dev python-pip libssl-dev \
    && apt-get autoremove

COPY ./dependency_urls.txt /dependency_urls_root.txt
COPY ./download_pkg.sh /download_pkg_root.sh
COPY ./setup.sh /setup.sh
COPY build.sh /build_root.sh
RUN chmod +x download_pkg_root.sh &&\
    ./download_pkg_root.sh &&\
    chmod +x setup.sh &&\
    chmod +x build_root.sh &&\
    ./build_root.sh
