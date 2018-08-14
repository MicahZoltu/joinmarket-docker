FROM ubuntu:18.04

WORKDIR /app

RUN apt-get update \
	&& apt-get install --yes python-dev python-pip git build-essential automake pkg-config libtool libffi-dev libssl-dev

RUN clone git://github.com/jedisct1/libsodium.git \
	&& cd libsodium \
	&& git checkout tags/1.0.4 \
	&& ./autogen.sh \
	&& ./configure \
	&& make check \
	&& make install

RUN git clone https://github.com/AdamISZ/joinmarket-clientserver \
	&& cd joinmarket-clientserver \
	&& pip install virtualenv \
	&& virtualenv jmvenv \
	&& source jmvenv/bin/activate \
	&& python setupall.py --daemon \
	&& python setupall.py --client-bitcoin

# NOTE: UNTESTED, I got distracted after starting...
