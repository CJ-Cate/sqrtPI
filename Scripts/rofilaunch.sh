#!/usr/bin/env bash

# Kill existing rofi instance if running
pkill rofi && exit 0

# Set rofi mode
r_mode="drun"

# Get the current hyprland settings to apply them to this window
hypr_border=$(hyprctl -j getoption decoration:rounding | jq -r '.int') # corner rounding integer
hypr_color=#$(hyprctl -j getoption general:col.active_border | jq -r '.custom' | cut -c 3-8) # active border colours
hypr_width=$(hyprctl -j getoption general:border_size | jq -r '.int') # border width

# Build rofi arguments
rofi_args=(
    -show-icons
    -icon-theme "Papirus"
#    -theme style_1
    -theme-str "window {border-radius: ${hypr_border}px;} element {border-radius: ${hypr_border}px;}"
    -theme-str "element selected.normal {border-color: ${hypr_color};}"
    -theme-str "window {border: ${hypr_width}; border-color: ${hypr_color}; border-radius: ${hypr_border}px;}"
)

# Get monitor info to detect vertical orientation. Untested because I dont have a vertical monitor setup.
#mon_data=$(hyprctl -j monitors)
#is_vertical=$(jq -e '.[] | select(.focused==true) | if (.transform % 2 == 0) then .width / .height else .height / .width end < 1' <<<"${mon_data}")
#if [[ "$is_vertical" == "true" ]]; then
#    echo "Monitor is vertical"
#fi

# Launch rofi
rofi -show "${r_mode}" "${rofi_args[@]}" &
