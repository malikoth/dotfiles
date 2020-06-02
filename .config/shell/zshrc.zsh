#!/usr/bin/env zsh

bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^w' backward-kill-word
bindkey '^h' history-incremental-search-backward
bindkey ',h' beginning-of-line
bindkey ',l' end-of-line
bindkey '^k' kill-line
bindkey '^u' vi-change-whole-line
bindkey '^e' edit-command-line
bindkey 'jk' vi-cmd-mode
bindkey -a '!' edit-command-line
bindkey -a 'v' visual-mode

sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N sudo-command-line
bindkey '^s' sudo-command-line

# Initialize pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
