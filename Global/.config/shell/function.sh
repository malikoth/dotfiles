#!/usr/bin/env sh

aa() {
    echo "alias $1='$2'" >> $SHELLFILES_DIR/alias
}

ee() {
    $EDITOR $SHELLFILES_DIR/$1.sh
}

freeport() {
    lsof -ti tcp:$1 | xargs kill -9
}

mcd() {
    mkdir "$1" && cd "$1";
}

cde() {
    cd "$(dirname $(which $1))"
}

pyclean() {
    find ${*:-'.'} -type f -name "*.py[co]" -delete
    find ${*:-'.'} -type d -name "__pycache__" -delete
}

gstat() {
    git status --porcelain | awk "\$1 == \"$1\" { print \$2 }"
}
