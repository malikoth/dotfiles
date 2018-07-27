#!/usr/bin/env sh

# File / System
alias la='LC_ALL=C ls -AlhH'
alias lt='la -rt'
alias l.='la -d .*'
alias hl='history P'
alias tree='tree -shC --du P'
alias z='fasd_cd'
alias zz='fasd_cd -i $(fc -nl -1 | awk '"'"'{print $NF}'"'"')'

# System Management
alias apt-up='sudo apt update && sudo apt upgrade -y'
alias apt-down='sudo apt autoremove -y'
alias bbu='brew bundle --file=~/.config/packages/Brewfile'
alias bbc='brew bundle cleanup'
alias bbd='brew bundle dump --force --file=~/.config/packages/Brewfile'
alias bbC='brew bundle cleanup --force'
alias brew-up='brew update && brew upgrade && brew cleanup'
alias cask-up='brew cask outdated | cut -d " " -f 1 | xargs brew cask install --force'
alias dk-up='docker images | awk '"'"'(NR > 1) && ($2 !~ /none/) {print $1 ":" $2}'"'"' | xargs -L1 docker pull'
alias dkc-up='docker-compose pull && docker-compose up -d'
alias pip-up='pip list | cut -d " " -f 1 | xargs pip install --upgrade'
alias yau="yadm add -u ${HOME}"

# Git
alias gbc='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'  # git branch clean
alias gcb='git checkout -b'
alias gcom='git checkout master'
alias gmr='git mr'
alias gnp='git --no-pager'
alias grph='git rev-parse HEAD'
alias gu='cd "$(git rev-parse --show-toplevel)"'
alias gwdnp='git --no-pager diff'

# Miscellaneous
alias -- -='cd -'
alias csv='column -t -n -s,'
alias dkhs='docker search'
alias ff='for font in `figlist | head -$(echo $(figlist | grep -n "Figlet control files" | cut -d : -f 1) - 1 | bc) | tail -n +4`; do echo $font; figlet -f $font Hello Kyle; done'
alias grep='grep -i --color=auto'
alias i='invoke'
alias pat='pygmentize -O style=monokai -f 16m -g'
alias path='echo $PATH | tr ":" "\n" | nl'
alias plz='sudo $(fc -ln -1)'
alias ra='ranger'
alias rl="source ${ZDOTDIR}/.zshrc"  # reload shell config
alias rlc='eval $(dircolors ~/.config/dircolors.txt)'
alias rg="rg --ignore-file ${HOME}/.config/ripgrep/ignore"
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias v='vagrant'
alias ws='python3 -m http.server'

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
