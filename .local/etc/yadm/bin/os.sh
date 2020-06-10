#! /usr/bin/env sh

# This script assumes the pre-installation of curl and sed
# This will install packages and do other OS-specific stuff


if [ "$(id -u)" != "0" ] && command -v sudo &> /dev/null; then
    SUDO=sudo
fi


# MacOS
#######

# Install Homebrew
if [ "$(uname -s)" = "Darwin" ] && ! command -v brew &> /dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


# Install packages via Homebrew
if command -v brew &> /dev/null; then
    brew bundle --file=$XDG_CONFIG_HOME/packages/Brewfile
fi


# Debian-like
#############

if command -v apt-get &> /dev/null; then
    $SUDO apt update && $SUDO apt install -y $(sed -e '/\s*#.*/d' $XDG_CONFIG_HOME/packages/apt.txt)

    # Git
    $SUDO add-apt-repository -y ppa:git-core/ppa
    $SUDO apt-get update
    $SUDO apt-get install -y git
fi


# Alpine
########

if command -v apk &> /dev/null; then
    $SUDO apk add --no-cache $(sed -e '/\s*#.*/d' $XDG_CONFIG_HOME/packages/apk.txt)
fi
