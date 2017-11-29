#!/usr/bin/env sh

# File / System
alias la='LC_ALL=C ls -AlhH'
alias lt='la -rt'
alias l.='la -d .*'
alias hl='history P'
alias tree='tree -shC --du P'
alias z='fasd_cd'
alias zz='fasd_cd -i $(fc -nl -1 | awk '"'"'{print $NF}'"'"')'
alias gu='cd "$(git rev-parse --show-toplevel)"'

# System Management
alias apt-up='sudo apt update && sudo apt upgrade -y'
alias brew-up='brew bundle --file=~/.local/packages/Brewfile'
alias bbu='brew bundle dump --force --file=~/.local/packages/Brewfile'
alias bbc='brew bundle cleanup'
alias bbcf='brew bundle cleanup --force'
alias dk-up='docker images | grep -v REPOSITORY | awk '"'"'{print $1}'"'"' | xargs -L1 docker pull'
alias pip-up='pip list | cut -d " " -f 1 | xargs pip install --upgrade'

# Git
alias gcom='git checkout master'
alias gwdnp='git --no-pager diff'
alias gbc='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'  # git branch clean
alias gcb='git checkout -b'
alias grph='git rev-parse HEAD'

# Miscellaneous
alias -- -='cd -'
alias dkhs='docker search'
alias i='invoke'
alias rl="source ${ZDOTDIR}/.zshrc"  # reload shell config
alias rlc='eval $(dircolors ~/.config/dircolors.txt)'
alias ra='ranger'
alias ff='for font in `figlist | head -$(echo $(figlist | grep -n "Figlet control files" | cut -d : -f 1) - 1 | bc) | tail -n +4`; do echo $font; figlet -f $font Hello Kyle; done'
alias pat='pygmentize -O style=monokai -f 16m -g'
alias ws='python3 -m http.server'
alias grep='grep -i --color=auto'
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias path='echo $PATH | tr ":" "\n" | nl'
alias plz='sudo $(fc -ln -1)'

# Zsh -g aliases
alias -g G='| grep'
alias -g J='| python3 -m json.tool'
alias -g L='| ${PAGER:-less}'
alias -g P='| pygmentize -g'
alias -g S='| sort'
alias -g T='| tail'
alias -g Tf='| tail -f'

# Zsh suffix aliases
alias -s git='git clone'

# Uncategorized
