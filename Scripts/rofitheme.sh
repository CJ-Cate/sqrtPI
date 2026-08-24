#!/usr/bin/env bash

# Kill existing rofi instance if running.
# -x matches the process name exactly: an unanchored "rofi" also matches
# power-profiles-daemon ("p[rofi]les") and other incidental substrings.
pkill -x rofi && exit 0

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

# Build rofi arguments.
# Kept as an array rather than backslash-continued arguments: a commented-out
# line in a continuation swallows its own trailing backslash, which silently
# splits the command in two. Comments inside an array are safe.
rofi_args=(
    -dmenu
    -show-icons
    -icon-theme "Papirus"
    -theme style_1
    -theme-str "window {border-radius: ${hypr_border}px;} element {border-radius: ${hypr_border}px;}"
    -theme-str "window {border: ${hypr_width}px;}"
    -p "Select Theme"
    -format 's'
)

# Launch rofi
selected=$(echo -e "$menu" | rofi "${rofi_args[@]}")

# Apply selected theme
if [[ -n "$selected" ]]; then
    "$HOME/sqrtPI/Scripts/theme-switcher.sh" "$selected"
fi
