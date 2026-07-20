#!/bin/bash

echo "Hi! What file extension do you want to convert? (Type extensions separated by space, or press Enter / type * for ALL):"
read -r user_input

shopt -s extglob

if [ -z "$user_input" ] || [ "$user_input" = "*" ]; then
    PATTERN="*"
else
    # Превращаем введенные через пробел расширения в формат: wav|flac|ogg
    extensions=$(echo "$user_input" | tr ' ' '|')
    PATTERN="*.@($extensions)"
fi

converted_count=0

# Отключаем разделение элементов цикла по пробелам (чтобы не ломались файлы с пробелами в именах)
IFS=$'\n'

for file in $PATTERN; do
    if [ ! -f "$file" ]; then
        continue
    fi
    
    if [[ "$file" == *.mp3 ]]; then
        continue
    fi

    basename="${file%.*}"

    echo "Converting: $file"
    ffmpeg -i "$file" -b:a 320k "$basename.mp3"
    ((converted_count++))
done

if [ $converted_count -eq 0 ]; then
    echo "No matching files found to convert."
else
    echo "Done! Successfully converted $converted_count files."
fi
