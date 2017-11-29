FROM ubuntu:zesty
MAINTAINER Kyle Rich <yutakafrog@gmail.com>

ENV TERM=xterm
ENV SHELL=/usr/bin/zsh
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y

COPY . /root/.dotfiles

RUN apt-get install -y $(cat /root/.dotfiles/config/apt-libraries.txt) $(cat /root/.dotfiles/config/apt-packages.txt)

# Docker
RUN curl -fsSL get.docker.com | sh

# Python
RUN curl -fsSL https://bootstrap.pypa.io/get-pip.py | python3
RUN ln -s /usr/bin/python3.6 /usr/bin/python
# RUN pip list -o --format=columns | cut -d' ' -f1 | tail -n +3 | xargs pip install -U
RUN pip install -r /root/.dotfiles/config/pip.txt

# Setup and configuration
RUN /root/.dotfiles/bin/install.sh
RUN git config --global credential.helper cache
RUN vim +PlugInstall +qall
RUN rm /root/.bashrc && rm /root/.profile

WORKDIR /root
CMD ["/usr/bin/zsh"]
