#!/bin/bash
cd $HOME/dotfiles
export TZ=UTC
git add . && git commit -m "green_test_$(date '+%Y-%m-%d')" && git push origin main
