# Path to your oh-my-zsh installation.
export ZSH=$HOME/.zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="random"
ZSH_THEME=""

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git atom brew brew-cask colored-man colorize common-aliases django github gitignore gnu-utils jira jsontools node npm osx pep8 pip python rsync sudo svn vagrant virtualenv vundle)
source $ZSH/oh-my-zsh.sh

# Run personal setup scripts
INCLUDE=~/.include
. $INCLUDE/vars
for file in $INCLUDE/*; do
    . $file
done

# TODO: Setup prompt for git status

# Prompt
function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '○'
}

autoload -U promptinit && promptinit

local d="%{$FX[reset]$FG[025]%}"
local name="%{$FX[reset]$FG[133]%}%n"
local host="%{$FX[reset]$FG[136]%}%M"
local green="%{$FX[reset]$FG[070]%}"
local white="%{$FX[reset]$FG[012]%}"
local tstamp="%{$FG[037]%}%*"

ZSH_GIT_PROMPT_PREFIX=" [%{$FX[reset]$FG[133]%}"
ZSH_GIT_PROMPT_SUFFIX="%{$FX[reset]$FG[025]%}]"
ZSH_GIT_PROMPT_DIRTY="%{$FX[reset]$FG[070]%}?"
ZSH_GIT_PROMPT_UNTRACKED="%{$FX[reset]$FG[070]%}?"
ZSH_GIT_PROMPT_CLEAN=""

PROMPT='
${d}[${name}${d}@${host}${d}] [${green}$(collapse_pwd)${d}] $(git_prompt_info)
${d}$(virtualenv_prompt_info) ${white}$(prompt_char) '

setopt prompt_subst
RPROMPT="${d}[${tstamp}${d}]${white}"

### Welcome ###
toilet -t -f smslant -d /usr/local/Cellar/figlet/2.2.5/share/figlet/fonts Hello Kyle
echo
fortune
