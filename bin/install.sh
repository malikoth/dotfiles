#!/usr/bin/env sh

DOTFILES=${HOME}/.dotfiles
GLOBAL=${DOTFILES}/Global
SYSTEM=${DOTFILES}/$(uname -s)
ZDOTDIR=${HOME}/.config/zsh

for file in ${GLOBAL}/*; do
    if [[ -d $file ]]; then
        echo ${file:h}
    else
        /bin/true
    fi
done

#ln -s ${GLOBAL}/.config/ ${HOME}/.config
#ln -s ${GLOBAL}/.ssh/ ${HOME}/.ssh
#ln -s ${GLOBAL}/.vim/ ${HOME}/.vim
#ln -s ${GLOBAL}/.zshenv ${HOME}/.zshenv
#
#git clone --recursive https://github.com/sorin-ionescu/prezto.git ${ZDOTDIR}/.zprezto
#zsh ${DOTFILES}/bin/prezto.zsh || true