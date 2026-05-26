# By knightfall01 on Github as a part of https://github.com/Knightfall01/Hyprland-config.

if status is-interactive
    # Commands to run in interactive sessions can go here
end
starship init fish | source
set -U fish_greeting ""
#cat ~/.cache/wal/sequences
#sh ~/.bin/colorscripts/crunchbang-mini

 fish_add_path ~/.bin/
 fish_add_path ~/.config/emacs/bin/
 fish_add_path ~/.local/bin/

function wgup
    sudo wg-quick up $argv[1]
end

function wgdw
    sudo wg-quick down $argv[1]
end

function v2a
    echo "Запуск служб v2rayA..."
    sudo systemctl start v2raya xray
    sleep 1
    echo "Panel now on http://localhost:2017 (miht)"
end
function v2as
    echo "Остановка служб v2rayA..."
    sudo systemctl stop v2raya xray
    echo "Прокси выключен."
end


alias l="ls -lh"
alias ls="exa"
alias nivm="nvim"
alias open="xdg-open"
alias findme="grep -nr"
alias nano="micro"
alias zapon="sudo systemctl start zapret"
alias zapinf="sudo systemctl status zapret"
alias zapof="sudo systemctl stop zapret"
alias chway="killall -USR1 waybar"
alias confish="micro ~/dotfiles/fish/config.fish"
alias upwall="sudo ./bash_fish_skr/wallpaper.sh"
alias fastfetch='fastfetch -c 28.jsonc'
alias ft='clear && fastfetch'
alias muxff="$HOME/dotfiles/scripts/mux_vlc/mux_inter.fish"
alias ipnow="curl ipinfo.io"
