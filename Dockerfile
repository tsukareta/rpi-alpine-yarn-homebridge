FROM hypriot/rpi-alpine:latest

RUN echo -e 'http://dl-cdn.alpinelinux.org/alpine/edge/main\nhttp://dl-cdn.alpinelinux.org/alpine/edge/community\nhttp://dl-cdn.alpinelinux.org/alpine/edge/testing' > /etc/apk/repositories \
  && apk add --no-cache --virtual .build-deps curl g++ libffi-dev make openssl-dev python \
  && apk --no-cache add avahi-compat-libdns_sd avahi-dev dbus nodejs-current openrc tzdata yarn \
  && yarn global add node-gyp \
  && yarn global add homebridge@latest \
  && yarn cache clean \
  && mkdir -p /homebridge /home/root/homebridge /init.d \
  && apk del .build-deps \
  && rm -rf /var/cache/apk/*

WORKDIR /homebridge

COPY default.package.json /home/root/homebridge
COPY default.config.json /home/root/homebridge
COPY init.d/ /init.d

VOLUME /homebridge

EXPOSE 49196 49198 51826 51828 56700/udp 63523/udp

ENTRYPOINT ["/init.d/entrypoint.sh"]

CMD ["homebridge", "-U", "/homebridge", "-P", "/homebridge/node_modules"] 
