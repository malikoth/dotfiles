# File / System
alias la='ls -AlhH --color=always'
alias lg='la --group-directories-first'
alias lt='la -rt'
alias hl='history | less'
alias ht='history | tail'
alias tree='tree -shC --du | less'

# Git
alias gcam='git commit -am'
alias gsh='git show'
alias gcf='git diff --name-only --diff-filter=U | cat'
alias gbv='git branch -v'
alias gt='git tag'

# Docker
alias di="docker images"
alias dp="docker ps"
alias dpa="docker ps -a"
alias dh="docker history"
alias din="docker inspect"
alias dr="docker run -it --rm"
alias dre="docker run -it --rm --entrypoint /bin/bash"
alias dc='docker rm $(docker ps -a | grep Exited | awk '"'"'{ print $1 }'"'"')'
alias dci='docker rmi $(docker images -f dangling=true -q)'

# Miscellaneous
alias -- -='cd -'
alias rl="source ${ZDOTDIR}/.zshrc"  # reload
alias sa='alias | grep -i'
alias ff='for font in `figlist | head -$(echo $(figlist | grep -n "Figlet control files" | cut -d : -f 1) - 1 | bc) | tail -n +4`; do echo $font; figlet -f $font Hello Kyle; done'
alias pat='pygmentize -g'
alias ws='python3 -m http.server'
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias bubu='brew update && brew upgrade --all && brew cleanup'
alias apt-up='apt update && sudo apt upgrade -y'
alias pip-up='pip list | cut -d " " -f 1 | xargs pip install --upgrade'

# Zsh -g aliases
alias -g G='| grep'
alias -g P='| pat'
alias -g L='| less'

# Uncategorized
