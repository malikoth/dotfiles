FROM alpine

# ENV TERM=xterm
# ARG DEBIAN_FRONTEND=noninteractive

# RUN apt-get update && apt-get upgrade -y && apt-get install -y curl git sed
RUN apk update && apk upgrade && apk add bash curl docker git sed sudo
RUN echo "%root ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/root

# Docker
# RUN curl -fsSL get.docker.com | sh

RUN adduser -DG root self
USER self

RUN curl -fsSL yadm.klr.blue | sh

WORKDIR /home/self
CMD ["/usr/bin/zsh"]
