# Malikoth's Dotfiles

## Prerequisites
* brew + cask (Darwin)
* zsh
* git

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask
brew install zsh git
```

## Installation

* Clone this repo
* Run installation script
* Install packages from `config` folder (manual step for now.  #TODO: Make this part of `install.sh`)

```bash
git clone http://git.klr.blue/kyle/dotfiles.git ~/.dotfiles
~/.dotfiles/bin/install.sh
```
