if [ ! -d home ]; then
    echo "No home folder to install"
    return
fi

mkdir -p ~/.backup
for file in home/*; do
    if [ -f $file ]; then
        # Archive old files, hard link new ones in
        mv -f ~/${file##*/} ~/.backup/
        ln $file ~/${file##*/}

    elif [ -d $file ]; then
        # Archive old folders, symlink new ones in
        mv -f ~/${file##*/} ~/.backup/${file##*/} 
        ln -s $(pwd)/$file ~/${file##*/}

        if [ ! -h ~/${file##*/} ]; then
            # If the old folder wasn't already a symlink, copy its contents back
            cp -npR ~/.backup/${file##*/}/* ~/${file##*/}/
        fi
    fi
done
