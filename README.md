# Installation
```bash
curl -fsSL yadm.klr.blue | sh
```

# Prerequisites
* bash
* curl
* git

Here are some snippets for installing the prerequisites on systems that I currently use.

### OSX
```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install bash curl git
```

### Debian
```bash
apt update && apt install -y bash curl git
```

### Alpine
```bash
apk add --no-cache bash curl git
```

# Devenv
The development environment is usable via Docker.  Launch a container with `docker-compose run --name devenv devenv`.

Reattach to the container later with `docker start -ai devenv`
