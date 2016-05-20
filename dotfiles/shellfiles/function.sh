function aa {
    echo "alias $1='$2'" >> $INCLUDE_DIR/alias
}

function ee {
    $EDITOR $INCLUDE_DIR/$1.sh
}

function freeport {
    lsof -it tcp:$1 | xargs kill -9
}

function mcd {
    mkdir -p "$1" && cd "$1";
}

function cde {
    cd "$(dirname $(which $1))"
}

function pyclean {
    find ${*:-'.'} -type f -name "*.py[co]" -delete
    find ${*:-'.'} -type d -name "__pycache__" -delete
}

sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N sudo-command-line
bindkey "\e\e" sudo-command-line
