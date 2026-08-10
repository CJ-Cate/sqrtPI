-- SqrtPI Rice v0
-- Migrated from hyprland.conf. Hyprland 0.56.2 prefers hyprland.lua and only
-- falls back to the .conf tree when no Lua config is found -- which is also the
-- rollback path: rename this file and the old .conf setup takes over again.

local scrPath = os.getenv("HOME") .. "/sqrtPI/Scripts"

-- Source things at the top so they can be overwritten if needed
require("hyprselect")
require("keybindings")   -- Keyboard Shortcuts
require("windowrules")
require("monitors")      -- Monitor configuration (machine-local, not in the repo)
require("sq-hyprland")   -- Active theme, symlinked in by theme-switcher.sh

local CURSOR_THEME = "Bibata-Modern-Ice"
local CURSOR_SIZE  = 24

--------------------
---- AUTOSTART -----
--------------------

hl.on("hyprland.start", function()
    -- System thingys
    hl.exec_cmd("hyprctl setcursor " .. CURSOR_THEME .. " " .. CURSOR_SIZE)
    hl.exec_cmd("waybar")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpaper")

    -- From the hyprland tutorial to get screenshare working (may or may not work)
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    -- hl.exec_cmd("xwaylandvideobridge")

    -- From https://www.lorenzobettini.it/2023/07/hyprland-getting-started-part-2/
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    -- From troubleshooting
    hl.exec_cmd("/usr/lib/hyprpolkitagent")
end)

-- Run to fix OBS virtual cam (not in this file, its just the process)
-- Automatically on startup forever: echo "v4l2loopback" | sudo tee /etc/modules-load.d/load-v4l2loopback.conf
-- Manually for the current session: sudo modprobe v4l2loopback

----------------------------------------------
---- Hyprland Variable Configurations       ---
---- https://wiki.hypr.land/Configuring/    ---
----------------------------------------------

hl.config({
    dwindle = {
        preserve_split = true,
    },

    general = {
        no_focus_fallback = true, -- Stops focus wrapping, which is usually unintuitive
        layout            = "dwindle",
    },

    input = {
        -- kb_layout = "us",
        -- follow_mouse = 1,
        force_no_accel = true,   -- mouse accelleration is evil
        accel_profile  = "flat", -- mouse accelleration is evil x2
        -- numlock_by_default = true,

        -- See https://wiki.hypr.land/Configuring/Variables/#touchpad
        touchpad = {
            natural_scroll = true,
            scroll_factor  = 0.2,
        },

        sensitivity = 0, -- -1.0 to 1.0
    },
})

-- 3-finger swipe to move between workspaces
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
