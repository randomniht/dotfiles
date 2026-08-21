rm -rf ~/.config/fastfetch/ 
mkdir -p ~/.config/fastfetch
stow -v --target=$HOME/.config/fastfetch fastfetch
ln -sf ~/dotfiles/fastfetch/28.jsonc ~/.config/fastfetch/config.jsonc

rm -rf ~/.config/foot  && mkdir -p ~/.config/foot/ &&  stow -v --target=$HOME/.config/foot foot/
# test
