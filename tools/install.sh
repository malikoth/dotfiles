#!/usr/bin/env sh

DOTFILES=${HOME}/.dotfiles/Global
ZDOTDIR=${HOME}/.config/zsh

ln -si ${DOTFILES}/.config/ ${HOME}/.config
ln -si ${DOTFILES}/.ssh/ ${HOME}/.ssh
ln -si ${DOTFILES}/.vim/ ${HOME}/.vim
ln -si ${DOTFILES}/.zshenv ${HOME}/.zshenv

git clone --recursive https://github.com/sorin-ionescu/prezto.git ${ZDOTDIR}/.zprezto
zsh ${DOTFILES}/tools/prezto.zsh