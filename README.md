# rpi-alpine-yarn-homebridge

homebridge on alpine installed with yarn for arm
tested on a raspberry pi 3B

base image: hypriot/rpi-alpine-node
large portions egregiously lifted from: https://github.com/oznu/docker-homebridge (oznu/homebridge)


currently being run like this (lifx,wemo, and wink accessories):

docker run -d \
--name homebridge \
--net=host \
-p 49196:49196 \
-p 49198:49198 \
-p 51826:51826 \
-p 51828:51828 \
-p 56700:56700/udp \
-p 63523:63523/udp \
--restart=unless-stopped \
umetaro/rpi-alpine-yarn-homebridge:latest
