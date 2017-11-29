# Run personal setup scripts
# echo $(dirname $(readlink -f "$0"))
SHELLFILES_DIR=~/.config/shell

# Source scripts
for file in ${SHELLFILES_DIR}/*.*sh; do
    source $file
done
