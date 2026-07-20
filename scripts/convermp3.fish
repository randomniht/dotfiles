#!/usr/bin/env fish

if test (count $argv) -eq 0
    set PATTERN *
else
    set ext_list (string join "," $argv)
    set PATTERN *.{$ext_list}
end

for file in (eval echo $PATTERN)
    if not test -e "$file"
        continue
    end
    
    if string match -q "*.mp3" "$file"
        continue
    end

    set basename (string replace -r '\.[^.]+$' '' "$file")

    echo "Converting: $file"
    ffmpeg -i "$file" -b:a 320k "$basename.mp3"
end

echo "Done!"
