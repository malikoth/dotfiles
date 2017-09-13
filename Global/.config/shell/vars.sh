#!/usr/bin/env sh

# TODO: Make PATH specific to which shell or box I'm on
export PATH="$HOME/.local/bin:${PATH}"
export EDITOR='vim'
export VISUAL=$EDITOR
export GREP_COLOR='01;34'
export GREP_COLORS="mt=$GREP_COLOR"
export CLICOLOR='1'
export LESS='-g -i -M -R -S -z-4'
export PROJECT_HOME=$HOME/dev
export HTTPIE_CONFIG_DIR=$HOME/.config/httpie

eval "$(dircolors ~/.config/dircolors.txt)"
