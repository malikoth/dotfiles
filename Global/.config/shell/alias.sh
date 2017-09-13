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
alias brew-up='brew update && brew upgrade && brew cleanup'
alias cask-up='brew cask outdated | cut -d " " -f 1 | xargs brew cask install --force'
alias apt-up='apt update && sudo apt upgrade -y'
alias pip-up='pip list | cut -d " " -f 1 | xargs pip install --upgrade'

# Miscellaneous
alias -- -='cd -'
alias i='invoke'
alias rl="source ${ZDOTDIR}/.zshrc"  # reload shell config
alias rlc='eval $(dircolors ~/.config/dircolors.txt)'
alias rli='~/.dotfiles/bin/install.sh'
alias ra='ranger'
alias ff='for font in `figlist | head -$(echo $(figlist | grep -n "Figlet control files" | cut -d : -f 1) - 1 | bc) | tail -n +4`; do echo $font; figlet -f $font Hello Kyle; done'
alias pat='pygmentize -g'
alias ws='python3 -m http.server'
alias grep='grep -i --color=auto'
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias path='echo $PATH | tr ":" "\n" | nl'
alias gcom='git checkout master'
alias gwdnp='git --no-pager diff'
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
