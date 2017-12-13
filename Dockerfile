FROM resnullius/alpine-armv7l:latest
MAINTAINER Herjan van Eijk <docker@f28.nl>

RUN apk --update --no-cache add libffi libffi-dev ca-certificates python3 python3-dev bash nmap net-tools gcc ffmpeg && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools homeassistant

# Install pychromecast (requires some extra packages)
RUN apk add --update --no-cache linux-headers musl-dev && \
    pip3 install pychromecast

VOLUME /config

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY custom_require.txt requirements_all.txt

RUN apk --update --no-cache add openssl-dev

RUN pip3 install --no-cache-dir -r requirements_all.txt

EXPOSE 8123

# Copy source COPY . .
CMD [ "python3", "-m", "homeassistant", "--config", "/config" ]
