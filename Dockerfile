FROM centos:7
RUN yum update -y
# General tools
RUN yum install -y wget unzip zip which
# Build tools
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && yum install -y gcc62 make gcc git cmake3 gmakectest ctest \
    && ln -s /usr/bin/cmake3 /usr/bin/cmake
# Dependencies
RUN yum install -y libX11-devel libXpm libXpm-devel libXft-devel libXext-devel \
    && yum groupinstall -y "Development tools"
# General build area
RUN mkdir /root-build && mkdir /root-build/build
# Clone repos
RUN git clone https://github.com/root-project/root.git /root-build/root -v \
    && git clone https://github.com/root-project/rootspi.git /root-build/rootspi -v \
    && git clone https://github.com/root-project/roottest.git /root-build/roottest -v
# Build ROOT
#    && LABEL=centos7 COMPILER=native BUILDTYPE=Release EXTERNALS=docker MODE=experimental /root-build/rootspi/jenkins/jk-all

RUN    cd /root-build/build && cmake ../root
RUN    cd /root-build/build && make -j3
RUN    cd /root-build/build && make install

# Start ROOT when
# CMD /root-build/build/bin/root.exe
