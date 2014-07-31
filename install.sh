if [ ! -d home ]; then
    echo "No home folder to install"
    return
fi

mkdir -p ~/.backup
for file in home/*; do
    if [ -f $file ]; then
        mv -f ~/${file##*/} ~/.backup/
        ln $file ~/${file##*/}
    elif [ -d $file ]; then
        mv -f ~/${file##*/} ~/.backup/${file##*/} 
        ln -s $(pwd)/$file ~/${file##*/}
        if [ ! -h ~/${file##*/} ]; then
            cp -npR ~/.backup/${file##*/}/* ~/${file##*/}/
        fi
    fi
done
