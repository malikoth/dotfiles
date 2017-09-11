# Run personal setup scripts
# echo $(dirname $(readlink -f "$0"))
SHELLFILES_DIR=~/.config/shell

# Source scripts
for file in ${SHELLFILES_DIR}/*; do
    source $file

done

# Platform dependant
for file in ${SHELLFILES_DIR}-$(uname -s)/*; do
    source $file
done
