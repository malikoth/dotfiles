# gnupg
export GNUPGHOME=${XDG_CONFIG_HOME}/gnupg

# httpie
export HTTPIE_CONFIG_DIR="${XDG_CONFIG_HOME}/httpie"

# less
export LESSHISTFILE="${XDG_CONFIG_HOME}/less/history"
export LESSKEY="${XDG_CONFIG_HOME}/less/keys"

# tmux
alias tmux='TERM=xterm-256color tmux -f "${XDG_CONFIG_HOME}"/tmux/tmux.conf'

# vim
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
