# Malikoth's Dotfiles

## Prerequisites
* curl
* git
* zsh

### Install prereqs on OSX:
```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask
brew install curl git zsh
```

### Install prereqs on Debian:

```bash
apt-get update && apt-get install -y curl git zsh
```

## Installation

* Bootstrap this repo via YADM

```bash
curl -fsSL 'https://tinyurl.com/yadm-bootstrap' | bash -s -- --bootstrap http://git.klr.blue/kyle/dotfiles.git
```
