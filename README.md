# Malikoth's Dotfiles

## Prerequisites
* brew + cask (Darwin)
* curl
* git
* zsh

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask
brew install git zsh
```

or in Debian:

```bash
apt-get update && apt-get install -y curl git zsh
```

## Installation

* Clone this repo
* Run installation script
* Install packages from `config` folder (manual step for now.  #TODO: Make this part of `install.sh`)

```bash
curl -fsSL 'https://tinyurl.com/yadm-bootstrap' | bash
```
