FROM alpine

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update && apk upgrade && apk add \
    bash curl git sudo
RUN echo "%root ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/root

RUN adduser -DG root self
USER self

RUN curl -fsSL yadm.klr.blue | sh

WORKDIR /home/self
CMD ["/bin/zsh"]
