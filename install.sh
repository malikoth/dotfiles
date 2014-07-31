for file in home/*; do
    if [ -f $file ]; then
        ln $file ~/${file##*/}
    fi
done
