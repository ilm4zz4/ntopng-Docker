FROM ubuntu:19.10

RUN apt-get update && \
    apt-get install -y \
	build-essential \
	git \
	bison \
	flex \
	libxml2-dev \
	libpcap-dev \
	libtool \
	libtool-bin \
	rrdtool \
	librrd-dev \
	autoconf \
	pkg-config \
	automake \
	autogen \
	redis-server \
	wget \
	libsqlite3-dev \
	libhiredis-dev \
	libmaxminddb-dev \
	libcurl4-openssl-dev \
	libpango1.0-dev \
	libcairo2-dev \
	libnetfilter-queue-dev \
	zlib1g-dev \
	libssl-dev \
	libcap-dev \
	libnetfilter-conntrack-dev \
	libreadline-dev \
	libjson-c-dev \
	libldap2-dev \
	geoipupdate \
	libmysqlclient-dev \
	libzmq3-dev \
	debhelper \
	dpkg-sig \
	dkms

WORKDIR /workspace
COPY . /workspace
RUN cd ntopng && ./autogen.sh && ./configure  && make -j3
