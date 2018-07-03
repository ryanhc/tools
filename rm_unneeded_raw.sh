#!/bin/sh

# removes .cr2 files that do not have matching .jpg in the current directory
# Canon generates .JPG and .CR2 files

for cr2_file in `ls *.CR2`; do
    echo "checking "$cr2_file
    file=${cr2_file%.*}
    if [ ! -e ${file}.JPG ]; then
        echo "rm ${file}.CR2"
        rm ${file}.CR2
    fi
done

