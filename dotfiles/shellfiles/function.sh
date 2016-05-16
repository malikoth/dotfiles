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
