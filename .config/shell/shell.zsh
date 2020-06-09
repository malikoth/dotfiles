# Run personal setup scripts
SHELLFILES_DIR=~/.config/shell

setopt extended_glob

# Source scripts
for file in ${SHELLFILES_DIR}/*.*sh~**/shell.zsh; do
    source $file
done

if [[ -s "${HOME}/.localrc" ]]; then
    source "${HOME}/.localrc"
fi

cd
