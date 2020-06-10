# XDG Definitions
export XDG_LOCAL_HOME="$HOME/.local"
export XDG_CONFIG_HOME="$XDG_LOCAL_HOME/etc"
export XDG_CACHE_HOME="$XDG_LOCAL_HOME/cache"
export XDG_DATA_HOME="$XDG_LOCAL_HOME/share"
export XDG_VAR_HOME="$XDG_LOCAL_HOME/var"
export XDG_OPT_HOME="$XDG_LOCAL_HOME/opt"

# fasd
export _FASD_DATA="$XDG_VAR_HOME/fasd/history"
export _FASD_VIMINFO="$XDG_CACHE_HOME/vim/viminfo"

# gnupg
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"

# httpie
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME/httpie"

# ipython
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"

# less
export LESSHISTFILE="$XDG_VAR_HOME/less/history"
export LESSKEY="$XDG_CONFIG_HOME/less/keys"

# pipenv
export WORKON_HOME="$XDG_VAR_HOME/venvs"

# pipx
export PIPX_HOME="$XDG_VAR_HOME/pipx"

# pyenv
export PYENV_ROOT="$XDG_OPT_HOME/pyenv"

# tmux
alias tmux='TERM=xterm-256color tmux -f "$XDG_CONFIG_HOME/tmux/tmux.conf"'

# vim
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

