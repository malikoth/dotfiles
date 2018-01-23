FROM ubuntu:bionic
MAINTAINER Kyle Rich <yutakafrog@gmail.com>

ENV TERM=xterm
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y && apt-get install -y curl git sed

# Docker
RUN curl -fsSL get.docker.com | sh

RUN curl -fsSL yadm.klr.blue | sh

WORKDIR /root
CMD ["/usr/bin/zsh"]
