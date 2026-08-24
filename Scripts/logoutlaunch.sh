#!/usr/bin/env bash

# Toggle: if the menu is already up, dismiss it rather than stacking a second one
if pgrep -x wlogout >/dev/null; then
    pkill -x wlogout
    exit 0
fi

# wlogout finds ~/.config/wlogout/{layout,style.css} by itself, so there's nothing
# to pass in. -b 1 puts one button per row, i.e. a vertical stack.
exec wlogout -b 1 -c 20 -r 10 -m 450 --protocol layer-shell
