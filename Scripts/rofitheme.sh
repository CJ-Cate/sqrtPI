#!/usr/bin/env bash

# Kill existing rofi instance if running
pkill rofi && exit 0

THEMES_DIR="$HOME/sqrtPI/Themes"

# Get available themes
themes=()
while IFS= read -r theme_dir; do
    theme_name=$(basename "$theme_dir")
    themes+=("$theme_name")
done < <(find "$THEMES_DIR" -mindepth 1 -maxdepth 1 -type d | sort)

# Exit if no themes found
[[ ${#themes[@]} -eq 0 ]] && exit 1

# Get current hyprland settings
hypr_border=$(hyprctl -j getoption decoration:rounding | jq -r '.int')
hypr_width=$(hyprctl -j getoption general:border_size | jq -r '.int')

# Build rofi menu
menu=""
for theme in "${themes[@]}"; do
    menu+="$theme\n"
done

# Launch rofi
selected=$(echo -e "$menu" | rofi -dmenu \
    -show-icons \
    -icon-theme "Papirus" \
#    -theme style_1 \
    -theme-str "window {border-radius: ${hypr_border}px;} element {border-radius: ${hypr_border}px;}" \
    -theme-str "window {border: ${hypr_width};}" \
    -p "Select Theme" \
    -format 's')

# Apply selected theme
if [[ -n "$selected" ]]; then
    "$HOME/sqrtPI/Scripts/theme-switcher.sh" "$selected"
fi
