FROM ubuntu:latest


RUN apt-get update \
    && apt-get install -y python3-pip python3-dev git \
    && cd /usr/local/bin \
    && ln -s /usr/bin/python3 python \
    && pip3 install --upgrade pip

ENTRYPOINT ["python3"]

RUN apt-get install -y cmake
RUN apt-get install -y wget

# Clone repos
# RUN git clone https://github.com/root-project/root.git /root-build/root -v \
#    && git clone https://github.com/root-project/rootspi.git /root-build/rootspi -v \
# && git clone https://github.com/root-project/roottest.git /root-build/roottest -v
RUN wget https://root.cern.ch/download/root_v6.10.02.source.tar.gz \
    && gunzip root_v6.10.02.source.tar.gz  \
    && tar -xf root_v6.10.02.source.tar

RUN mkdir /root-build
RUN mkdir /root-build/build
RUN apt-get install -y libx11-dev libxpm-dev libxft-dev libxext-dev
RUN cd /root-build/build && cmake ../../root-6.10.02
RUN cd /root-build/build && make -j3
RUN cd /root-build/build && make install
