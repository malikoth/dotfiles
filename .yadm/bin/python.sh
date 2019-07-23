#! /usr/bin/env sh

# Install and setup Python, pip, and install system packages I like for Python


if [ "$(id -u)" != "0" ] && command -v sudo; then
    SUDO=sudo
fi


if ! command -v python && command -v python3 >/dev/null 2>&1; then
    $SUDO ln -s /usr/bin/python3 /usr/bin/python
fi

# TODO: Install pip iff not installed, upgrade iff not latest, install packages iff not installed, upgrade iff updates available
if command -v python >/dev/null 2>&1; then
    if ! command -v pip >/dev/null 2>&1; then
        curl -fsSL https://bootstrap.pypa.io/get-pip.py | $SUDO python
    fi
    $SUDO python -m pip install --upgrade --force-reinstall pip

    # TODO: Use pipsi here
    $SUDO pip install -r ${HOME}/.config/packages/pip.txt
fi
