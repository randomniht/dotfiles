#!/bin/bash

shopt -s extglob

if [ $# -eq 0 ]; then
    PATTERN="*"
else
    IFS="|"
    PATTERN="*.@($*)"
fi

for file in $PATTERN; do
    if [ ! -e "$file" ]; then
        continue
    fi
    
    if [[ "$file" == *.mp3 ]]; then
        continue
    fi

    basename="${file%.*}"

    echo "Converting: $file"
    ffmpeg -i "$file" -b:a 320k "$basename.mp3"
done

echo "Done!"
