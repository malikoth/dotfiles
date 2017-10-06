#!/usr/bin/env bash

DOTFILES=${HOME}/.dotfiles
GLOBAL=${DOTFILES}/Global
SYSTEM=${DOTFILES}/$(uname -s)
ZDOTDIR=${HOME}/.config/zsh

create_link () {
    if [ ! -e ${1} ]; then
        return
    fi

    if [ -d ${1} ]; then
        mkdir -p ${2}/${1##*/}
        for file2 in ${1}/{*,.[!.]*}; do
            create_link ${file2} ${2}/${1##*/}
        done
    elif [ -f ${1} ]; then
        ln -sT ${1} ${2}/${1##*/}
    fi
}

for file in ${SYSTEM}/{*,.[!.]*} ${GLOBAL}/{*,.[!.]*}; do
    create_link ${file} ${HOME}
done

git clone --recursive https://github.com/sorin-ionescu/prezto.git ${ZDOTDIR}/.zprezto
zsh ${DOTFILES}/bin/prezto.zsh || true