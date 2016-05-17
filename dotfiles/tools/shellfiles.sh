# Run personal setup scripts

#echo $(dirname $(readlink -f "$0"))
INCLUDE_DIR=~/.dotfiles/dotfiles/shellfiles
CURR_SHELL=$(ps ch -o command $$ | grep -iv command)

# Source scripts
for file in $INCLUDE_DIR/*; do
    source $file
done

# Platform dependant
for file in $INCLUDE_DIR/$(uname -s)/*; do
    source $file
done
