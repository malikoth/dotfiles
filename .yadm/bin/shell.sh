# Run personal setup scripts
SHELLFILES_DIR=~/.config/shell

# Source scripts
for file in ${SHELLFILES_DIR}/*.*sh; do
    source $file
done
