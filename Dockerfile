FROM scratch
MAINTAINER Zi Shen Lim <zlim.lnx@gmail.com>

ARG BASE_IMAGE=http://cdimage.ubuntu.com/ubuntu-base/releases/16.04/release/ubuntu-base-16.04-core-arm64.tar.gz
ADD $BASE_IMAGE /

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://ports.ubuntu.com/ubuntu-ports/ xenial universe" > /etc/apt/sources.list.d/ubuntu.list

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y -m --no-install-recommends \
  autoconf automake binutils-dev build-essential cmake g++ gawk git \
  libbz2-dev libc-client-dev libldap2-dev \
  libc-client2007e-dev libcap-dev libcurl4-openssl-dev libdwarf-dev libelf-dev \
  libexpat-dev libgd2-xpm-dev libgoogle-glog-dev libgoogle-perftools-dev libicu-dev \
  libjemalloc-dev libmcrypt-dev libmemcached-dev libmysqlclient-dev libncurses-dev \
  libonig-dev libpcre3-dev libreadline-dev libtbb-dev libtool libxml2-dev zlib1g-dev \
  libevent-dev libmagickwand-dev libinotifytools0-dev libiconv-hook-dev libedit-dev \
  libiberty-dev libxslt1-dev ocaml-native-compilers libsqlite3-dev libyaml-dev libgmp3-dev \
  gperf libkrb5-dev libnotify-dev

#RUN apt-get install -y -m --no-install-recommmends \
#  libboost-dev libboost-filesystem-dev libboost-program-options-dev libboost-regex-dev \
#  libboost-system-dev libboost-thread-dev libboost-context-dev

ARG LIBBOOST=http://downloads.sourceforge.net/project/boost/boost/1.61.0/boost_1_61_0.tar.bz2
ADD $LIBBOOST /tmp

# For pyconfig.h
RUN apt-get install -y -m --no-install-recommends python-dev

WORKDIR /tmp/boost_1_61_0
RUN ./bootstrap.sh && ./b2 install

ENTRYPOINT [ "/bin/bash" ]
