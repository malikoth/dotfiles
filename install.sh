if [ ! -d home ]; then
    echo "No home folder to install"
    exit
fi

# Setup vars
CURR_SHELL=$(ps ch -o command $$ | grep -iv command)

(
    # Set options
    shopt -s dotglob
    shopt -s nullglob

    mkdir -p ~/.backup
    for file in home/*; do
        # Archive old version of file / folder
        if [ -e ~/${file##*/} ]; then
            mv -f ~/${file##*/} ~/.backup/
        fi

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
)
