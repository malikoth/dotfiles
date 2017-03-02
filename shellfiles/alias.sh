# File / System
alias la='ls -AlhH'
alias lt='la -tr'
alias l.='la -d .*'
alias hl='history P'
alias tree='tree -shC --du P'
alias z='fasd_cd'
alias zz='fasd_cd -i $(fc -nl -1 | awk '"'"'{print $NF}'"'"')'

# Git
alias gcam='git commit -am'
alias gCl='git diff --name-only --diff-filter=U | cat'
alias gbv='git branch -vv'
alias gii='git update-index --assume-unchanged'
alias giI='git update-index --no-assume-unchanged'

# Docker
alias di="docker images"
alias dp="docker ps"
alias dpa="docker ps -a"
alias dh="docker history"
alias din="docker inspect"
alias dr="docker run -it --rm"
alias dre="docker run -it --rm --entrypoint /bin/bash"
alias dc='docker rm $(docker ps -qaf status=exited)'
alias dci='docker rmi $(docker images -qf dangling=true)'

# Miscellaneous
alias -- -='cd -'
alias i='invoke'
alias rl="source ${ZDOTDIR}/.zshrc"  # reload
alias sa='alias G -i'
alias ff='for font in `figlist | head -$(echo $(figlist | grep -n "Figlet control files" | cut -d : -f 1) - 1 | bc) | tail -n +4`; do echo $font; figlet -f $font Hello Kyle; done'
alias pat='pygmentize -g'
alias ws='python3 -m http.server'
alias grep='grep -i --color=auto'
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias bubu='brew update && brew upgrade && brew cleanup'
alias apt-up='apt update && sudo apt upgrade -y'
alias pip-up='pip list | cut -d " " -f 1 | xargs pip install --upgrade'
alias path='echo $PATH | tr ":" "\n"'

# Zsh -g aliases
alias -g G='| grep'
alias -g P='| pygmentize -g'
alias -g L='| less'
alias -g J='| python3 -m json.tool'
alias -g P='| ${PAGER:-less}'
alias -g S='| sort'
alias -g T='| tail'
alias -g Tf='| tail -f'

# Zsh suffix aliases
alias -s git='git clone'

# Uncategorized
