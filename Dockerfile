FROM ubuntu:20.04

RUN apt -y update
RUN apt -y install vim cmake wget

WORKDIR /opt/
RUN wget https://releases.linaro.org/components/toolchain/binaries/6.3-2017.05/aarch64-linux-gnu/gcc-linaro-6.3.1-2017.05-x86_64_aarch64-linux-gnu.tar.xz
RUN wget https://dl.bintray.com/boostorg/release/1.69.0/source/boost_1_69_0.tar.gz
RUN tar -xf gcc-linaro-6.3.1-2017.05-x86_64_aarch64-linux-gnu.tar.xz
RUN tar -xzf boost_1_69_0.tar.gz
RUN rm gcc-linaro-6.3.1-2017.05-x86_64_aarch64-linux-gnu.tar.xz boost_1_69_0.tar.gz

COPY .bashrc /root/

WORKDIR /root/