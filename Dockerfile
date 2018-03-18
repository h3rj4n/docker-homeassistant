#FROM arm32v6/alpine
FROM arm64v8/alpine:latest
MAINTAINER Herjan van Eijk <docker@f28.nl>

RUN apk --update --no-cache add libffi libffi-dev ca-certificates \
    python3 python3-dev bash nmap net-tools gcc g++ ffmpeg autoconf openssl-dev \
    linux-headers musl-dev make \
    openzwave-dev openzwave openzwave-libs eudev-dev && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 --no-cache-dir install pychromecast Cython

VOLUME /config

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY custom_require.txt requirements_all.txt
# After the copy nothing can be cached, so install homeassistant now.
RUN pip3 install --no-cache-dir --upgrade pip setuptools homeassistant && \
    pip3 install --no-cache-dir -r requirements_all.txt

EXPOSE 8123

# Copy source COPY . .
CMD [ "python3", "-m", "homeassistant", "--config", "/config" ]
