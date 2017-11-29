FROM ubuntu:artful
MAINTAINER Kyle Rich <yutakafrog@gmail.com>

ENV TERM=xterm
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y && apt-get install -y curl git sed

# Docker
RUN curl -fsSL get.docker.com | sh

RUN curl -fsSL 'https://github.com/TheLocehiliosan/yadm/raw/master/yadm' | bash -s -- clone --bootstrap http://git.klr.blue/kyle/dotfiles.git

WORKDIR /root
CMD ["/usr/bin/zsh"]
