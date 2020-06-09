# XDG Definitions
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_LOCAL_HOME="$HOME/.local"
export XDG_DATA_HOME="$XDG_LOCAL_HOME/share"

# fasd

export _FASD_DATA="$XDG_LOCAL_HOME/var/fasd"

# gnupg
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"

# httpie
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME/httpie"

# ipython
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"

# less
export LESSHISTFILE="$XDG_CONFIG_HOME/less/history"
export LESSKEY="$XDG_CONFIG_HOME/less/keys"

# pyenv
export PYENV_ROOT="$XDG_LOCAL_HOME/opt/pyenv"

# tmux
alias tmux='TERM=xterm-256color tmux -f "$XDG_CONFIG_HOME/tmux/tmux.conf"'

# vim
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

