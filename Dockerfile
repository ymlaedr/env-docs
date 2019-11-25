FROM node:12-alpine
MAINTAINER YoshimuraMakoto<ymlaedr@gmail.com>

RUN apk add --update --no-cache bash git
RUN yarn global add gatsby-cli
