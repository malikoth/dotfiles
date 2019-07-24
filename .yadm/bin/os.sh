#! /usr/bin/env sh

# This script assumes the pre-installation of curl and sed
# This will install packages and do other OS-specific stuff


if [ "$(id -u)" != "0" ] && command -v sudo; then
    SUDO=sudo
fi


# MacOS
#######

# Install Homebrew
if [ "$(uname -s)" = "Darwin" ] && ! command -v brew >/dev/null 2>&1; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


# Install packages via Homebrew
if command -v brew >/dev/null 2>&1; then
    brew bundle --file=${HOME}/.config/packages/Brewfile
fi


install_ripgrep() {
    RIPGREP_VERSION=11.0.1
    RIPGREP=ripgrep-${RIPGREP_VERSION}-x86_64-unknown-linux-musl
    RIPGREP_OPT=${HOME}/.local/opt/ripgrep

    rm -rf ${RIPGREP_OPT}
    mkdir -p ${RIPGREP_OPT}
    curl -fsSL https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VERSION}/${RIPGREP}.tar.gz | tar xzC ${RIPGREP_OPT} --strip-components=1 ${RIPGREP}
    ln -sf ${RIPGREP_OPT}/rg ${HOME}/.local/bin/rg
    mkdir -p ${HOME}/.local/share/man/man1
    ln -sf ${RIPGREP_OPT}/rg.1 ${HOME}/.local/share/man/man1/rg.1
    mandb >/dev/null 2>&1
}

install_git() {
    $SUDO add-apt-repository -y ppa:git-core/ppa
    $SUDO apt-get update
    $SUDO apt-get install git
}


# Debian-like
#############

if command -v apt >/dev/null 2>&1; then
    $SUDO apt update && $SUDO apt install -y $(sed -e '/\s*#.*/d' ${HOME}/.config/packages/apt.txt)
    install_ripgrep
    install_git
fi


# Alpine
########

if command -v apk >/dev/null 2>&1; then
    $SUDO apk add --no-cache $(sed -e '/\s*#.*/d' ${HOME}/.config/packages/apk.txt)
    install_ripgrep
fi
