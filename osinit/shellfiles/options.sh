if [ $CURR_SHELL = zsh ]; then

    # Globbing
    setopt NO_DOT_GLOB
    setopt NULL_GLOB
    setopt EXTENDED_GLOB

    setopt KSH_GLOB
    setopt NO_HIST_VERIFY
    setopt CSH_JUNKIE_HISTORY

else

    # Globbing
    shopt -u dotglob
    shopt -s extglob

    shopt -s autocd

fi
