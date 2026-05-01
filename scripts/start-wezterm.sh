#!/bin/sh
exec /usr/bin/wezterm start -- fish -c "clear && fastfetch; exec fish"
