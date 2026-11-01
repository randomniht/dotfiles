#!/bin/bash
cd $HOME/dotfiles
if ! ping -c 1 github.com &> /dev/null; then
    exit 0
fi
d=$(TZ=UTC date '+%Y-%m-%d')
echo "$d" >> logg_green_test.txt
git add . && git commit -m "green_test_$d" && git push origin main
