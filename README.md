# Home Assistant Docker Image

## Description

Small docker image with [home assistant](https://home-assistant.io/) based on [Alpine Linux](https://hub.docker.com/_/alpine/).

[![](https://images.microbadger.com/badges/image/pstauffer/homeassistant.svg)](https://microbadger.com/images/pstauffer/homeassistant)

## Usage
```
docker run -d --name homeassistant -p 80:8123 pstauffer/homeassistant:latest
```

### Configuration

It's recommended to map a directory into the container to configure home assistant. Make sure the owner of the config directory on the docker host is equal to the user in the docker container. The default uid/gid is `666`.

```
-v /tmp/blaaa:/home/homeassistant/.homeassistant
```


### Discovery

https://home-assistant.io/components/discovery/

`--net=host` option...





## Doug


docker run -d --name homeassistant --net=host -v /tmp/blaaa:/home/homeassistant/.homeassistant -it -p 8080:8123 pstauffer/homeassistant:latest


http:
  api_password: login

light:
  platform: hue
  host: 10.0.5.117




  https://home-assistant.io/components/media_player.itunes/
  https://home-assistant.io/components/media_player.samsungtv/
  https://home-assistant.io/components/media_player.plex/
  https://home-assistant.io/components/light.hue/
  https://home-assistant.io/components/notify.slack/
  https://home-assistant.io/components/sensor.deutsche_bahn/
  https://home-assistant.io/components/sensor.swiss_public_transport/
  https://home-assistant.io/components/notify.telegram/
  https://home-assistant.io/components/device_tracker.icloud/
  https://home-assistant.io/components/switch.mfi/
  https://home-assistant.io/components/sensor.mfi/

  http://10.0.5.200:8123/states
  

  
## License
This project is licensed under `MIT <http://opensource.org/licenses/MIT>`_.
