#FROM arm32v6/alpine
FROM arm64v8/python:3-alpine
#FROM alpine:latest
MAINTAINER Herjan van Eijk <docker@f28.nl>

VOLUME /config

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY custom_require.txt requirements_all.txt

RUN apk --update --no-cache add libffi ca-certificates \
      bash nmap net-tools eudev yaml musl openssl ffmpeg mariadb-client mariadb-connector-c && \
    apk --update --no-cache add --virtual .build-dependencies eudev-dev yaml-dev make \
      linux-headers musl-dev gcc g++ autoconf libressl-dev libffi-dev mariadb-dev && \
    pip3 --no-cache-dir install pychromecast Cython wheel six mysqlclient setuptools homeassistant && \
    pip3 install --no-cache-dir -r requirements_all.txt && \
    apk del .build-dependencies

#python3 -m ensurepip && \
#rm -r /usr/lib/python*/ensurepip && \

EXPOSE 8123

# Copy source COPY . .
CMD [ "python3", "-m", "homeassistant", "--config", "/config" ]

# First image 451MB,

# CalDAV: py3-lxml && \ libxml2-dev libxslt-dev && \
