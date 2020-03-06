FROM node:13.8.0-alpine as deps
MAINTAINER YoshimuraMakoto<ymlaedr@gmail.com>

ENV LANG C.UTF-8

RUN apk \
    add \
    --update-cache \
    --virtual .setup-timezone-dependencies \
    tzdata

FROM node:13.8.0-alpine as dev
MAINTAINER YoshimuraMakoto<ymlaedr@gmail.com>

ENV LANG C.UTF-8
WORKDIR /root

RUN apk \
    add \
    --update-cache \
    --virtual .setup-node-gyp-dependencies \
    python \
    make \
    g++

COPY --from=deps /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
