# Malikoth's Dotfiles

## Prerequisites
* curl
* git

### Install prereqs on OSX:
```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install curl git
```

### Install prereqs on Debian:

```bash
apt-get update && apt-get install -y curl git
```

## Installation

* Bootstrap this repo via YADM

```bash
curl -fsSL 'https://github.com/TheLocehiliosan/yadm/raw/master/yadm' | bash -s -- clone --bootstrap http://git.klr.blue/kyle/dotfiles.git
```
