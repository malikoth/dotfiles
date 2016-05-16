# Config
# alias ${CURR_SHELL}rc='$EDITOR'" ~/.${CURR_SHELL}rc"
alias rl="source ~/.${CURR_SHELL}rc"

# Alias Management
alias sa='alias | grep -i'

# File / System
alias la='ls -AlhH --color=always'
alias lg='ls -AlhH --color=always --group-directories-first'
alias lt='ls -AlhHrt --color=always'
alias hl='history | less'
alias tree='tree -shC --du | less'
alias ht='history | tail'

# Git
alias gcam='git commit -am'
alias gsh='git show'
alias gcf='git diff --name-only --diff-filter=U | cat'
alias gbv='git branch -v'
alias gt='git tag'

# Miscellaneous
alias ff='for font in `figlist | head -$(echo $(figlist | grep -n "Figlet control files" | cut -d : -f 1) - 1 | bc) | tail -n +4`; do echo $font; figlet -f $font Hello Kyle; done'
alias pip-up='pip list | cut -d " " -f 1 | xargs pip install --upgrade'
alias pat='pygmentize -g'

# Uncategorized
