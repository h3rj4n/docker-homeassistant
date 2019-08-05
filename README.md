# Home Assistant Docker Image

## Description

Prebuild [home assistant](https://home-assistant.io/) docker imgae based on [Alpine Linux](https://hub.docker.com/_/alpine/) (specific for ARM64v8). Contains
preinstalled packages.

## Usage
Build this image
```
docker build -t herjan/homeassistant .
```

Next, run this image as daemon.

```
docker run -d --name homeassistant \
  -v ~/homeassistant:/config -p 8080:8123 \
  herjan/homeassistant:latest
```

## Configuration

This build of Home Assistant does not contain all the packages. Only the packages defined in the custom_require.txt.
It was not possible to install all the packages because ARM / Alphine / Odroid did not support all require python packages.

## License
This project is licensed under `MIT <http://opensource.org/licenses/MIT>`.
