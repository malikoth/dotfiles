# Run personal setup scripts

setopt extended_glob

# Source scripts
for file in $XDG_CONFIG_HOME/shell/*.*sh~**/shell.zsh; do
    source $file
done

if [[ -s "$HOME/.localrc" ]]; then
    source "$HOME/.localrc"
fi

cd
