COREUTILS_PATH=$(brew --prefix)/opt/coreutils
export PATH="$COREUTILS_PATH/libexec/gnubin:$PATH"
export MANPATH="$COREUTILS_PATH/libexec/gnuman:$(man -w)"
