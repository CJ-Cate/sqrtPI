#!/bin/bash

# sqrtPI theme switcher script
# Usage: ./theme-switcher.sh <theme-name>
# or the rofi wrapper

if [ -z "$1" ]; then
    echo "Usage: $0 <theme-name>"
    exit 1
fi

THEME_NAME="$1"
THEMES_DIR="$HOME/sqrtPI/Themes"
THEME="$THEMES_DIR/$THEME_NAME"
CONF="$HOME/.config"

if [ ! -d "$THEME" ]; then
    echo "Error: Theme directory '$THEME' does not exist"
    exit 1
fi

# Build the theme's inheritance chain. A theme directory may contain a
# '.from' file naming another theme it should fall back to; this is
# followed recursively (A -> B -> C -> ...) until a theme with no '.from'
# is reached, at which point Hyprland is used as the ultimate default.
# Any cycle (or a '.from' pointing at an unknown theme) also falls back
# to Hyprland.
declare -a THEME_CHAIN=()
declare -A SEEN=()
current="$THEME_NAME"
while [[ -n "$current" && -z "${SEEN[$current]:-}" ]]; do
    THEME_CHAIN+=("$current")
    SEEN["$current"]=1

    from_file="$THEMES_DIR/$current/.from"
    if [[ -f "$from_file" ]]; then
        read -r parent < "$from_file"
    else
        parent="Hyprland"
    fi

    if [[ -z "$parent" ]]; then
        parent="Hyprland"
    fi

    if [[ ! -d "$THEMES_DIR/$parent" ]]; then
        echo "Warning: '$current/.from' points to unknown theme '$parent', falling back to Hyprland" >&2
        parent="Hyprland"
    fi

    current="$parent"
done

# Guarantee Hyprland is always in the chain, even if a cycle kept it from
# being reached naturally.
if [[ -z "${SEEN[Hyprland]:-}" ]]; then
    THEME_CHAIN+=("Hyprland")
fi

update_symlink() {
    local rel_path="$1"
    local remote="$2"
    local theme_name supply

    for theme_name in "${THEME_CHAIN[@]}"; do
        supply="$THEMES_DIR/$theme_name/$rel_path"
        if [[ -e "$supply" ]]; then
            mkdir -p "$(dirname "$remote")"
            ln -sf "$supply" "$remote"
            return 0
        fi
    done

    echo "$rel_path not found in theme chain (${THEME_CHAIN[*]}), skipping update on $remote"
    return 1
}

# Update mutagen
export THEME_NAME
envsubst < "$HOME/sqrtPI/Scripts/sq-matugen" > "$CONF/matugen/config.toml"
# Update all the matugen symlinks
update_symlink ".live/matugen-hyprland.conf" "$CONF/hypr/matugen-hyprland.conf"
#
#
# Finally, run matugen
matugen image "$THEME/media/background"* # wildcard image type, good luck!

# Hyprland: https://wiki.hypr.land/Configuring/
# Hyprland's config is Lua now; hyprlock and hyprpaper below are still hyprlang.
if update_symlink "hypr/sq-hyprland.lua" "$CONF/hypr/sq-hyprland.lua"; then
    hyprctl reload
fi

# Hyprlock: https://wiki.hypr.land/Hypr-Ecosystem/hyprlock/
update_symlink "hypr/sq-hyprlock.conf" "$CONF/hypr/sq-hyprlock.conf"

# Direct bind to the config file
# Hyprpaper: https://wiki.hypr.land/Hypr-Ecosystem/hyprpaper/
if update_symlink "hypr/sq-hyprpaper.conf" "$CONF/hypr/sq-hyprpaper.conf"; then
    # Unconditional relaunch: killall fails when hyprpaper is already down, and
    # an && here would then skip the restart and leave it down for good.
    killall hyprpaper 2>/dev/null; hyprpaper & disown
    #hyprctl hyprpaper reload , "$Theme/media/background*"
fi

# Fastfetch: https://github.com/fastfetch-cli/fastfetch/wiki/Configuration
update_symlink "sq-fastfetch.jsonc" "$CONF/fastfetch/config.jsonc"

# alacritty
update_symlink "sq-alacritty.conf" "$CONF/kitty/sq-alacritty.conf"

# Tmux
if update_symlink "sq-tmux.conf" "$HOME/.sq-tmux.conf"; then
    tmux source-file ~/.sq-tmux.conf 2>/dev/null
fi

# Direct bind to the config file
# Waybar - config.jsonc
if update_symlink "waybar/sq-config.jsonc" "$CONF/waybar/config.jsonc"; then
    #killall -12 waybar 2>/dev/null # reload signal # doesnt work depending on what changes
    killall waybar; waybar & disown
fi

# Direct bind to the config file
# Waybar - style.css
if update_symlink "waybar/sq-style.css" "$CONF/waybar/style.css"; then
    kill -12 waybar 2>/dev/null # reload signal
fi

# Rofi
update_symlink "sq-rofi.rasinc" "$CONF/rofi/sq-theme.rasinc"

# Zsh (shell)
if update_symlink "sq-zshrc" "$HOME/.sq-zshrc"; then
    zsh -c "source ~/.sq-zshrc"
fi

# Direct bind to the config file
# Dunst (notification manager thing)
update_symlink "sq-dunstrc" "$CONF/dunst/dunstrc"

# NeoVim
#update_symlink "vim" "$HOME/.vim/sq-colors.vim"

# Vesktop
#update_symlink "better-discord" "$CONF/BetterDiscord/sq-theme"

# LibreWolf (firefox): https://www.userchrome.org/
# This needs to be set to your browsers profile, unique to you.
# Browser needs to be restarted to reflect changes.
#update_symlink "userChrome.css" "$HOME/.librewolf/lirl03ec.default-default/chrome/userChrome.css"

# Obsidian
#update_symlink "obsidian" "$HOME/Documents/cybersec/.obsidian/themes"

# GRUB (probably wont do)
#if update_symlink "grub" "/etc/default/sq-grub-theme"; then
#    # GRUB requires: sudo grub-mkconfig -o /boot/grub/grub.cfg
#fi
