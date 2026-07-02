# By knightfall01 on Github as a part of https://github.com/Knightfall01/Hyprland-config.

if status is-interactive
    # Commands to run in interactive sessions can go here
end
#starship init fish | source
set -U fish_greeting ""
#cat ~/.cache/wal/sequences
#sh ~/.bin/colorscripts/crunchbang-mini

 fish_add_path ~/.bin/
 fish_add_path ~/.config/emacs/bin/
 fish_add_path ~/.local/bin/



function update_bridges
    echo "Скачивание свежих мостов с GitHub..."
    curl -sL "https://raw.githack.com/igareck/vpn-configs-for-russia/main/TOR-BRIDGES/TOR_BRIDGES_TOP100.txt" -o ~/.local/share/onionhop/my_bridges.txt
    echo "Готово! Файл обновлен."
end



# function update_bridges
#     echo "Скачивание свежих мостов с GitHub..."
#     curl -sL "https://gitea.com/igareck/vpn-configs-for-russia/raw/branch/main/TOR-BRIDGES/TOR_BRIDGES_ALL.txt" -o ~/.local/share/onionhop/my_bridges.txt
#     echo "Готово! Файл обновлен."
# end
# connect --smart off --mode tun --bridges on --bridge-type custom --bridge-source offline
function onitun
    sudo ~/.local/share/onionhop/OnionHopV3.Cli connect --smart off --mode tun --bridges on --bridge-type obfs4 --bridge-source offline --hold on
end



function wgup
    if test -f $argv
        sudo wg-quick up (realpath $argv)
    else if test -f "$argv.conf"
        sudo wg-quick up (realpath "$argv.conf")
    else
        set -l interface (string replace -r '\.conf$' '' $argv)
        sudo wg-quick up $interface
    end
end

function wgdw
    if test -f $argv
        sudo wg-quick down (realpath $argv)
    else if test -f "$argv.conf"
        sudo wg-quick down (realpath "$argv.conf")
    else
        set -l interface (string replace -r '\.conf$' '' $argv)
        sudo wg-quick down $interface
    end
end
# git add . && git commit -m "" && git push origin main

function gitsp
    git add . && git commit -m "$argv[1]" && git push origin main
end    

function stowm
    rm -rf ~/.config/"$argv[1]"  && mkdir -p ~/.config/"$argv[1]"/ &&  stow -v --target=$HOME/.config/"$argv[1]"  "$argv[1]"/
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
# zapret_discord_youtube.service = service
alias uzapon="/home/$USER/programs/zapret-discord-youtube-linux/service.sh service start"
alias uzapinf="/home/$USER/programs/zapret-discord-youtube-linux/service.sh service status"
alias uzapof="/home/$USER/programs/zapret-discord-youtube-linux/service.sh service stop"



alias chway="killall -USR1 waybar"
alias confish="micro ~/dotfiles/fish/config.fish"
alias upwall="sudo ./bash_fish_skr/wallpaper.sh"
alias fastfetch='fastfetch -c 28.jsonc'
alias ft='clear && fastfetch'
alias muxff="$HOME/dotfiles/scripts/mux_vlc/mux_inter.fish"
alias ipnow="curl ipinfo.io"
alias onihop="~/.local/share/onionhop/OnionHopV3.Cli"
alias v2str="sudo systemctl start v2raya xray"
alias v2stp="sudo systemctl stop v2raya xray"
