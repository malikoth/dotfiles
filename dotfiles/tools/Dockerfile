FROM ubuntu
MAINTAINER Kyle Rich <yutakafrog@gmail.com>

ENV ZDOTDIR /root/.config/zsh

RUN apt update && apt upgrade -y

# Docker
RUN apt install -y apt-transport-https ca-certificates
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list
RUN apt update && apt install -y docker-engine

# My packages
RUN apt install -y build-essential curl figlet git htop inxi irssi m4 man ncdu pwgen python3 silversearcher-ag tig tree vim w3m wget zsh
RUN curl -L https://bootstrap.pypa.io/get-pip.py | python3
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN pip install httpie invoke Pygments

# Other
RUN git clone https://github.com/rkitover/vimpager.git /opt/vimpager && cd /opt/vimpager && make install
RUN git clone https://github.com/clvv/fasd.git /opt/fasd && cd /opt/fasd && make install

# Kyle's dotfiles
RUN git clone http://git.klr.blue/kyle/dotfiles.git /root/.dotfiles
RUN ln -sf /root/.dotfiles/dotfiles/dotfiles/.config /root/.config
RUN ln -sf /root/.dotfiles/dotfiles/dotfiles/.vim /root/.vim
RUN vim +PlugInstall +qall

# Zsh and Prezto
RUN git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
RUN /bin/zsh /root/.dotfiles/dotfiles/tools/prezto.zsh || true

# Other again
RUN rm /root/.bashrc && rm /root/.profile

WORKDIR /root/dev
ENTRYPOINT ["/bin/zsh"]
