# Run personal setup scripts

# Setup vars.sh
CURR_SHELL=$(ps ch -o command $$ | grep -iv command)
# INCLUDE_DIR=$(dirname $(readlink -f "$0"))
INCLUDE_DIR=~/.include

# Source scripts
for file in $INCLUDE_DIR/*; do
    source $file
done

# Platform dependant
case $( uname -s ) in
    Darwin ) # Mac

        ;;
    Linux ) # Everything else

        ;;
esac
