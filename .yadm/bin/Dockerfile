FROM ubuntu:artful
MAINTAINER Kyle Rich <yutakafrog@gmail.com>

ENV TERM=xterm
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y

# Docker
RUN curl -fsSL get.docker.com | sh

RUN curl -fsSL 'https://tinyurl.com/yadm-bootstrap' | bash -s -- --bootstrap http://git.klr.blue/kyle/dotfiles.git

WORKDIR /root
CMD ["/usr/bin/zsh"]
