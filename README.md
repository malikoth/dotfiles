# Malikoth's Dotfiles

## Prerequisites
* brew + cask (Darwin)

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask
```

* zsh
* git

## Installation

```bash
git clone https://github.com/malikoth/dotfiles.git ~/.dotfiles
```
* Clone this repo
* Clone ZPrezto

```bash
git clone https://github.com/sorin-ionescu/prezto.git ~/.config/zsh/prezto
```
* Install Prezto runcoms

```bash
~/.dotfiles/prezto.zsh
```
* Perform symlinks

### Darwin Specific
* Install cask
* Install all brews
* Install all taps
* Install all casks

### Linux specific
* Install packages
