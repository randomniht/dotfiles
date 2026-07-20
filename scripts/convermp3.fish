#!/usr/bin/env fish

echo "Hi! What file extension do you want to convert? (Type extensions separated by space, or press Enter / type * for ALL):"
read -l user_input

if test -z "$user_input" -o "$user_input" = "*"
    set files_to_convert *
else
    set extensions (string split " " $user_input)
    for ext in $extensions
        set files_to_convert $files_to_convert *.$ext
    end
end

set converted_count 0

for file in $files_to_convert
    if not test -f "$file"
        continue
    end
    
    if string match -q "*.mp3" "$file"
        continue
    end

    set basename (string replace -r '\.[^.]+$' '' "$file")

    echo "Converting: $file"
    ffmpeg -i "$file" -b:a 320k "$basename.mp3"
    set converted_count (math $converted_count + 1)
end

if test $converted_count -eq 0
    echo "No matching files found to convert."
else
    echo "Done! Successfully converted $converted_count files."
end
