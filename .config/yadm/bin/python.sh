#! /usr/bin/env sh

# Install and setup Python, pip, and install system packages I like for Python


if [ "$(id -u)" != "0" ] && command -v sudo >/dev/null 2>&1; then
    SUDO=sudo
fi


# TODO: Install pyenv
# TODO: Install latest CPython via pyenv and set it as global
# TODO: Install pip iff not installed, upgrade iff not latest, install packages iff not installed, upgrade iff updates available
if command -v python >/dev/null 2>&1; then
    if ! command -v pip >/dev/null 2>&1; then
        curl -fsSL https://bootstrap.pypa.io/get-pip.py | $SUDO python3
    fi
    $SUDO python3 -m pip install --upgrade --force-reinstall pip

    for package in $(cat ${HOME}/.config/packages/pipx.txt); do
        pipx install $package
    done
fi
