#!/bin/sh

# removes .cr2 files that do not have matching .jpeg

base_dir=`pwd`
jpeg_dir=$base_dir"/"$1
raw_dir=$base_dir"/"$2

for jpeg_file in `ls $jpeg_dir`; do
    echo "checking "$jpeg_file
    jpeg=${jpeg_file%.*}
    if [ ! -e $raw_dir"/"$jpeg".cr2" ]; then
        echo "rm $raw_dir'/'$jpeg'.cr2'"
    fi
done
