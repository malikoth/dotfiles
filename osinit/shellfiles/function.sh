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

function ws {
    python -m SimpleHTTPServer $1
}

function extract {
	unset REMOVE_ARCHIVE

	if test "$1" = "-r"; then
		REMOVE_ARCHIVE=1
		shift
	fi
	if [[ -f $1 ]]; then
		case $1 in
		*.tar.bz2) tar xvjf $1;;
		*.tar.gz) tar xvzf $1;;
		*.tar.xz) tar xvJf $1;;
		*.tar.lzma) tar --lzma -xvf $1;;
		*.lzma) unlzma $1;;
		*.bz2) bunzip $1;;
		*.rar) unrar x -ad $1;;
		*.gz) gunzip $1;;
		*.tar) tar xvf $1;;
		*.tbz2) tar xvjf $1;;
		*.tgz) tar xvzf $1;;
		*.zip) unzip $1;;
		*.Z) uncompress $1;;
		*.7z) 7z x $1;;
		*.xz) unxz $1;;
		*.exe) cabextract $1;;
		*) echo "'$1' cannot be extracted via extract";;
		esac

		if [[ $REMOVE_ARCHIVE -eq 1 ]]; then
			echo Removing "$1";
			/bin/rm "$1";
		fi

	else
		echo "'$1' is not a valid file"
	fi
}
