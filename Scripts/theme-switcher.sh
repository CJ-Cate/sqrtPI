#!/bin/bash

# sqrtPI theme switcher script
# Usage: ./theme-switcher.sh <theme-name>
# or the rofi wrapper

if [ -z "$1" ]; then
    echo "Usage: $0 <theme-name>"
    exit 1
fi

THEME_NAME="$1"
THEME="$HOME/sqrtPI/Themes/$THEME_NAME"
CONF="$HOME/.config"

if [ ! -d "$THEME" ]; then
    echo "Error: Theme directory '$THEME' does not exist"
    exit 1
fi

update_symlink() {
    local supply="$1"
    local remote="$2"
    
    # Try to fallback to a default if input file doesn't exist
    if [[ ! -e "$supply" ]]; then
        echo "$supply not found! trying default."
        local default_supply="${supply/$THEME_NAME/Hyprland}"
        if [[ -e "$default_supply" ]]; then
            supply="$default_supply"
        else
            echo "$default_supply not found either! skipping update on $remote"
            return 1
        fi
    fi
    
    mkdir -p "$(dirname "$remote")"
    ln -sf "$supply" "$remote"
    return 0
}

# Update mutagen
export THEME_NAME
envsubst < "$HOME/sqrtPI/Scripts/sq-matugen" > "$CONF/matugen/config.toml"
# Update all the matugen symlinks
update_symlink "$THEME/.live/matugen-hyprland.conf" "$CONF/hypr/matugen-hyprland.conf"
#
#
# Finally, run matugen
mutagen image "$THEME/media/background"* # wildcard image type, good luck!

# Hyprland: https://wiki.hypr.land/Configuring/
if update_symlink "$THEME/hypr/sq-hyprland.conf" "$CONF/hypr/sq-hyprland.conf"; then
    hyprctl reload
fi

# Hyprlock: https://wiki.hypr.land/Hypr-Ecosystem/hyprlock/
update_symlink "$THEME/hypr/sq-hyprlock.conf" "$CONF/hypr/sq-hyprlock.conf"

# Direct bind to the config file
# Hyprpaper: https://wiki.hypr.land/Hypr-Ecosystem/hyprpaper/
if update_symlink "$THEME/hypr/sq-hyprpaper.conf" "$CONF/hypr/sq-hyprpaper.conf"; then
    killall hyprpaper 2>/dev/null && hyprpaper &
    #hyprctl hyprpaper reload , "$Theme/media/background*"
fi

# Fastfetch: https://github.com/fastfetch-cli/fastfetch/wiki/Configuration
update_symlink "$THEME/sq-fastfetch.jsonc" "$CONF/fastfetch/config.jsonc"

# alacritty
update_symlink "$THEME/sq-alacritty.conf" "$CONF/kitty/sq-alacritty.conf"

# Tmux
if update_symlink "$THEME/sq-tmux.conf" "$HOME/.sq-tmux.conf"; then
    tmux source-file ~/.sq-tmux.conf 2>/dev/null
fi

# Direct bind to the config file
# Waybar - config.jsonc
if update_symlink "$THEME/waybar/sq-config.jsonc" "$CONF/waybar/config.jsonc"; then
    #killall -12 waybar 2>/dev/null # reload signal # doesnt work depending on what changes
    killall waybar; waybar & disown
fi

# Direct bind to the config file
# Waybar - style.css
if update_symlink "$THEME/waybar/sq-style.css" "$CONF/waybar/style.css"; then
    kill -12 waybar 2>/dev/null # reload signal
fi

# Rofi
update_symlink "$THEME/sq-rofi.rasinc" "$CONF/rofi/sq-theme.rasinc"

# Zsh (shell)
if update_symlink "$THEME/sq-zshrc" "$HOME/.sq-zshrc"; then
    zsh -c "source ~/.sq-zshrc"
fi

# Direct bind to the config file
# Dunst (notification manager thing)
update_symlink "$THEME/sq-dunstrc" "$CONF/dunst/dunstrc"

# NeoVim
#update_symlink "$THEME/vim" "$HOME/.vim/sq-colors.vim"

# Vesktop
#update_symlink "$THEME/better-discord" "$CONF/BetterDiscord/sq-theme"

# LibreWolf (firefox): https://www.userchrome.org/
# This needs to be set to your browsers profile, unique to you.
# Browser needs to be restarted to reflect changes.
#update_symlink "$THEME/userChrome.css" "$HOME/.librewolf/lirl03ec.default-default/chrome/userChrome.css"

# Obsidian
#update_symlink "$THEME/obsidian" "$HOME/Documents/cybersec/.obsidian/themes"

# GRUB (probably wont do)
#if update_symlink "$THEME/grub" "/etc/default/sq-grub-theme"; then
#    # GRUB requires: sudo grub-mkconfig -o /boot/grub/grub.cfg
#fi
