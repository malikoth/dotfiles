if [ ! -d home ]; then
    echo "No home folder to install"
    return
fi

# Setup vars
CURR_SHELL=$(ps ch -o command $$ | grep -iv command)

# Set options
if [ $CURR_SHELL = bash ]; then
    shopt -u dotglob
else if [ $CURR_SHELL = zsh ]; then
    setopt no_dot_glob

mkdir -p ~/.backup
for file in home/*; do
    # Archive old version of file / folder
    mv -f ~/${file##*/} ~/.backup/

    if [ -f $file ]; then
        # Hard link new config files in
        ln $file ~/${file##*/}

    elif [ -d $file ]; then
        # Symlink new config dirs in
        ln -s $(pwd)/$file ~/${file##*/}

        if [ ! -h ~/.backup/${file##*/} ]; then
            # If the old directory wasn't already a symlink, copy its contents back
            cp -npR ~/.backup/${file##*/}/* ~/${file##*/}/
        fi
    fi
done

source home/.include/.source
