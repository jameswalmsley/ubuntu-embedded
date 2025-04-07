FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && apt-get -y full-upgrade && \
    apt-get -y install \
        build-essential \
        git \
        pv \
        cpio \
        device-tree-compiler \
        flex \
        bison \
        bc \
        gcc-aarch64-linux-gnu \
        libssl-dev \
        rsync \
        xxd \
        arch-install-scripts \
        debootstrap \
        uuid-dev \
        libgnutls28-dev \
        ;

ENV USER=root

RUN git config --global --add safe.directory /work

