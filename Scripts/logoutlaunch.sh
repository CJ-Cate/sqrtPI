#!/usr/bin/env bash

# Kill existing wlogout if running
if pgrep -x "wlogout" >/dev/null; then
    pkill -x "wlogout"
    exit 0
fi

# Config paths
confDir="$HOME/.config"
wLayout="${confDir}/wlogout/layout"
wlTmplt="${confDir}/wlogout/style.css"

# Get monitor info
y_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
hypr_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')

# Get Hyprland styling
hypr_border=$(hyprctl -j getoption decoration:rounding | jq -r '.int')
hypr_color="#$(hyprctl -j getoption general:col.active_border | jq -r '.custom' | cut -d' ' -f1 | cut -c 5-10)"

# Process template
#wlStyle="$(envsubst <"${wlTmplt}")"

# Launch wlogout (4 buttons in a row)
#wlogout -b 1 -c 20 -r 10 -m 450 --layout "${wLayout}" --css ${wlTmplt} --protocol layer-shell 
wlogout -b 1 -c 20 -r 10 -m 450 --protocol layer-shell 
