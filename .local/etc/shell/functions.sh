#!/usr/bin/env sh

aa() {
    # Add alias
    echo "alias $1='$2'" >> $XDG_CONFIG_HOME/shell/aliases.sh
}

ee() {
    # Edit environment variables
    $EDITOR $XDG_CONFIG_HOME/shell/$1.sh
}

freeport() {
    # Free a port by killing whatever process has it open
    lsof -ti tcp:$1 | xargs kill -9
}

mcd() {
    # Make and change to a directory
    mkdir "$1" && cd "$1";
}

cde() {
    # Change to directory in which an executable resides
    cd "$(dirname $(which $1))"
}

pyclean() {
    # Clean up random Python cruft
    find ${*:-'.'} -type f -name "*.py[co]" -delete
    find ${*:-'.'} -type d -name "__pycache__" -delete
}

gstat() {
    git status --porcelain | awk "\$1 == \"$1\" { print \$2 }"
}

gcod() {
    # git-checkout by date
    git checkout $(git rev-list -1 --before="$1" $2)
}

keygen() {
    # Generate a new SSH key
    # $1 is the name of the server or service the key is for
    # $2 is an email address to associate with the key, and/or comment about the key
    # Both are concatenated along with the date to form the whole comment
    mkdir -p ~/.ssh/keys
    ssh-keygen -t ed25519 -a 100 -f ~/.ssh/keys/$1 -C "$1 $2 $(date +%Y-%m-%d)"
}

h() {
    # Peruse history
    fc -lim "*$@*" 1
}

nkill() {
    # Kill process by name
    ps ax | awk "/$1/ && !/awk/ {print \$1}" | xargs kill -9
}
