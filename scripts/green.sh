#!/bin/bash
cd $HOME/dotfiles
export TZ=UTC
d=$(TZ=UTC date '+%Y-%m-%d')
echo $(d) >> logg_green_test.txt
git add . && git commit -m "green_test_$(d)" && git push origin main
