FROM ubuntu
MAINTAINER Kyle Rich <yutakafrog@gmail.com>

RUN apt update && apt upgrade -y

# Docker
RUN apt install -y apt-transport-https ca-certificates
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list
RUN apt update && apt install -y docker-engine

# My packages
RUN apt install -y curl figlet git htop inxi irssi m4 ncdu pwgen python3 silversearcher-ag tree vim w3m wget zsh
RUN curl -L https://bootstrap.pypa.io/get-pip.py | python3
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN pip install httpie invoke Pygments

# Configuration and setup
RUN curl --create-dirs -Lo /root/.vim/vimrc http://git.klr.blue/kyle/osinit/raw/master/osinit/dotfiles/.vimrc
RUN vim +PlugInstall +qall
RUN git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
COPY ./prezto.sh /tmp/prezto.sh
RUN /bin/zsh /tmp/prezto.sh
RUN sed -i "s/sorin/clint/" /root/.zpreztorc

WORKDIR /root/dev
ENTRYPOINT ["/bin/zsh"]

