#!/usr/bin/env bash

# Kill existing rofi instance if running.
# -x matches the process name exactly: an unanchored "rofi" also matches
# power-profiles-daemon ("p[rofi]les") and other incidental substrings.
pkill -x rofi && exit 0

# Set rofi mode
r_mode="drun"

# Get the current hyprland settings to apply them to this window
hypr_border=$(hyprctl -j getoption decoration:rounding | jq -r '.int') # corner rounding integer
hypr_width=$(hyprctl -j getoption general:border_size | jq -r '.int') # border width

# Active border colour. hyprctl reports gradients as "AARRGGBB <angle>deg" under
# .gradient (it used to be .custom) - drop the angle, drop the alpha, keep RGB.
# The final guard matters: without it a renamed field yields an unparseable
# colour, and rofi shows an "error while parsing theme" dialog instead of the menu.
hypr_color=$(hyprctl -j getoption general:col.active_border | jq -r '.gradient // .custom // empty' | cut -d' ' -f1)
hypr_color=${hypr_color#0x}
hypr_color="#${hypr_color:2:6}"
[[ $hypr_color =~ ^#[0-9a-fA-F]{6}$ ]] || hypr_color="#cba6f7" # fall back to @main-br

# Build rofi arguments
rofi_args=(
    -show-icons
    -icon-theme "Papirus"
    -theme style_1
    -theme-str "window {border-radius: ${hypr_border}px;} element {border-radius: ${hypr_border}px;}"
    -theme-str "element selected.normal {border-color: ${hypr_color};}"
    -theme-str "window {border: ${hypr_width}px; border-color: ${hypr_color}; border-radius: ${hypr_border}px;}"
)

# Get monitor info to detect vertical orientation. Untested because I dont have a vertical monitor setup.
#mon_data=$(hyprctl -j monitors)
#is_vertical=$(jq -e '.[] | select(.focused==true) | if (.transform % 2 == 0) then .width / .height else .height / .width end < 1' <<<"${mon_data}")
#if [[ "$is_vertical" == "true" ]]; then
#    echo "Monitor is vertical"
#fi

# Launch rofi
rofi -show "${r_mode}" "${rofi_args[@]}" &
