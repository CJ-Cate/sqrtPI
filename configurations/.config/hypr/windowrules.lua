-- █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█   █▀█ █░█ █░░ █▀▀ █▀
-- ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀   █▀▄ █▄█ █▄▄ ██▄ ▄█
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
--
-- Merged from windowrules.conf (repo) and windowrules.conf.bak during the Lua
-- migration. On conflict the repo copy won; .bak contributed Factorio and
-- alacritty. The old `$& = override` shorthand is now the literal word
-- "override" inside the opacity string, which is what Hyprland's parser wants.

--------------------
---- IDLE INHIBIT --
--------------------

hl.window_rule({
    name         = "idle-inhibit-video",
    match        = { class = [[^(.*celluloid.*)$|^(.*mpv.*)$|^(.*vlc.*)$]] },
    idle_inhibit = "fullscreen",
})
hl.window_rule({
    name         = "idle-inhibit-spotify",
    match        = { class = [[^(.*[Ss]potify.*)$]] },
    idle_inhibit = "fullscreen",
})
hl.window_rule({
    name         = "idle-inhibit-browsers",
    match        = { class = [[^(.*LibreWolf.*)$|^(.*floorp.*)$|^(.*firefox.*)$]] },
    idle_inhibit = "fullscreen",
})
-- from windowrules.conf.bak
hl.window_rule({
    name         = "idle-inhibit-factorio",
    match        = { class = [[[Ff]actorio]] },
    idle_inhibit = "fullscreen",
})

--------------------------
---- PICTURE IN PICTURE --
--------------------------

hl.window_rule({
    name  = "picture-in-picture",
    match = { title = [[^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$]] },

    float             = true,
    keep_aspect_ratio = true,
    move              = "((monitor_w*0.73)) ((monitor_h*0.72))",
    size              = "(monitor_w*0.25) (monitor_h*0.25)",
    pin               = true,
})
hl.window_rule({
    name  = "firefox-pip-float",
    match = { class = [[^(firefox)$]], title = [[^(Picture-in-Picture)$]] },
    float = true,
})

---------------
---- OPACITY --
---------------

-- hl.window_rule({ name = "brave-opacity",     match = { class = [[^(brave-browser)$]] }, opacity = "0.90 override 0.90 override 1" })
-- hl.window_rule({ name = "librewolf-opacity", match = { class = [[^(librewolf)$]] },     opacity = "0.90 override 0.90 override 1" }) -- I dont want my browser transparent

local opacity_rules = {
    { name = "firefox",          class = [[^(firefox)$]],                                    opacity = "0.90 override 0.90 override 1" },
    { name = "obsidian",         class = [[^([Oo]bsidian)$]],                                opacity = "1 override 0.94 override 1" },
    { name = "code-oss",         class = [[^(code-oss)$]],                                   opacity = "0.92 override 0.86 override 1" },
    { name = "code",             class = [[^([Cc]ode)$]],                                    opacity = "0.92 override 0.86 override 1" },
    { name = "code-url",         class = [[^(code-url-handler)$]],                           opacity = "0.92 override 0.86 override 1" },
    { name = "code-insiders",    class = [[^(code-insiders-url-handler)$]],                  opacity = "0.92 override 0.86 override 1" },
    { name = "kitty",            class = [[^([Kk]itty)]],                                    opacity = "0.95 override 0.90 override 1" },
    -- from windowrules.conf.bak
    { name = "alacritty",        class = [[^([Aa]lacritty)]],                                opacity = "0.95 override 0.90 override 1" },
    { name = "dolphin",          class = [[^(org.kde.dolphin)$]],                            opacity = "0.92 override 0.86 override 1" },
    { name = "portal-gtk",       class = [[^(org.freedesktop.impl.portal.desktop.gtk)$]],    opacity = "0.92 override 0.86 override 1" },
    { name = "portal-hyprland",  class = [[^(org.freedesktop.impl.portal.desktop.hyprland)$]], opacity = "0.92 override 0.86 override 1" },
    { name = "steamwebhelper",   class = [[^(steamwebhelper)$]],                             opacity = "0.92 override 0.86 override 1" },
    -- if not work try append "free" or "premium"
    { name = "spotify",          class = [[^([Ss]potify)$]],                                 opacity = "0.92 override 0.86 override 1" },
    { name = "polkit-gnome",     class = [[^(polkit-gnome-authentication-agent-1)$]],        opacity = "0.92 override 0.86 override 1" },
    { name = "vesktop",          class = [[^(vesktop)$]],                                    opacity = "0.95 0.90" },
    -- Discord-Electron, personal reminder not to use
    { name = "discord",          class = [[^(discord)$]],                                    opacity = "1 0.50" },
    -- GTK Apps (personally vetted)
    { name = "obs",              class = [[^(com.obsproject.Studio)$]],                      opacity = "0.80 0.80" },
    { name = "missioncenter",    class = [[^(io.missioncenter.MissionCenter)$]],             opacity = "0.80 0.80" },
    { name = "flatseal",         class = [[^(com.github.tchx84.Flatseal)$]],                 opacity = "0.80 0.80" },
    { name = "videodownloader",  class = [[^(com.github.unrud.VideoDownloader)$]],           opacity = "0.80 0.80" },
    { name = "warehouse",        class = [[^(io.github.flattool.Warehouse)$]],               opacity = "0.80 0.80" },
}

for _, r in ipairs(opacity_rules) do
    hl.window_rule({
        name    = r.name .. "-opacity",
        match   = { class = r.class },
        opacity = r.opacity,
    })
end

-- Opacity + float together
local opacity_float_rules = {
    { name = "ark",          class = [[^(org.kde.ark)$]],                                opacity = "0.92 override 0.86 override 1" },
    { name = "nwg-look",     class = [[^(nwg-look)$]],                                   opacity = "0.92 override 0.86 override 1" },
    { name = "qt5ct",        class = [[^(qt5ct)$]],                                      opacity = "0.92 override 0.86 override 1" },
    { name = "qt6ct",        class = [[^(qt6ct)$]],                                      opacity = "0.92 override 0.86 override 1" },
    { name = "kvantum",      class = [[^(kvantummanager)$]],                             opacity = "0.92 override 0.86 override 1" },
    { name = "pavucontrol",  class = [[^(org.pulseaudio.pavucontrol)$]],                 opacity = "0.92 override 0.86 override 1" },
    { name = "blueman",      class = [[^(blueman-manager)$]],                            opacity = "0.92 override 0.86 override 1" },
    { name = "nm-applet",    class = [[^(nm-applet)$]],                                  opacity = "0.92 override 0.86 override 1" },
    { name = "nm-conn-edit", class = [[^(nm-connection-editor)$]],                       opacity = "0.92 override 0.86 override 1" },
    { name = "polkit-kde",   class = [[^(org.kde.polkit-kde-authentication-agent-1)$]],  opacity = "0.92 override 0.86 override 1" },
    { name = "yad",          class = [[^(yad)$]],                                        opacity = "0.80 0.80" }, -- Protontricks-Gtk
    { name = "clapper",      class = [[^(com.github.rafostar.Clapper)$]],                opacity = "0.90 0.90" }, -- Clapper-Gtk
    { name = "planify",      class = [[^(io.github.alainm23.planify)$]],                 opacity = "0.80 0.80" },
    { name = "upscaler",     class = [[^(io.gitlab.theevilskeleton.Upscaler)$]],         opacity = "0.80 0.80" },
    { name = "impression",   class = [[^(io.gitlab.adhami3310.Impression)$]],            opacity = "0.80 0.80" },
}

for _, r in ipairs(opacity_float_rules) do
    hl.window_rule({
        name    = r.name .. "-opacity-float",
        match   = { class = r.class },
        opacity = r.opacity,
        float   = true,
    })
end

-- Steam explicitly wants opacity but NOT floating
hl.window_rule({
    name    = "steam-opacity",
    match   = { class = [[^([Ss]team)$]] },
    opacity = "0.92 override 0.86 override 1",
    float   = false,
})

-- hl.window_rule({ name = "signal", match = { class = [[^(Signal)$]] }, opacity = "0.80 0.80", float = true }) -- not installed rn

------------------
---- FLOAT RULES --
------------------

-- common modals
local float_titles = {
    [[^(Open)$]],
    [[^(Authentication Required)$]],
    [[^(Add Folder to Workspace)$]],
    -- [[^(Open File)$]] on initialtitle -- this broke for some reason
    [[^(Choose Files)$]],
    [[^(Save As)$]],
    [[^(Confirm to replace files)$]],
    [[^(File Operation Progress)$]],
    [[^(File Upload)(.*)$]],
    [[^(Choose wallpaper)(.*)$]],
    [[^(Library)(.*)$]],
    [[^(.*dialog.*)$]],
    [[^(About Mozilla Firefox)$]],
}

for i, t in ipairs(float_titles) do
    hl.window_rule({ name = "float-title-" .. i, match = { title = t }, float = true })
end

local float_classes = {
    [[^([Xx]dg-desktop-portal-gtk)$]],
    [[^(.*dialog.*)$]],
    [[^(eog)$]],                            -- Imageviewer-Gtk
    [[^(com.github.unrud.VideoDownloader)$]], -- VideoDownloader-Gtk
    [[^(vlc)$]],
}

for i, c in ipairs(float_classes) do
    hl.window_rule({ name = "float-class-" .. i, match = { class = c }, float = true })
end

-- class + title pairs
hl.window_rule({ name = "float-firefox-library", match = { class = [[^(firefox)$]], title = [[^(Library)$]] }, float = true })
hl.window_rule({ name = "float-kitty-top",       match = { class = [[^(kitty)$]],   title = [[^(top)$]] },     float = true })
hl.window_rule({ name = "float-kitty-btop",      match = { class = [[^(kitty)$]],   title = [[^(btop)$]] },    float = true })
hl.window_rule({ name = "float-kitty-htop",      match = { class = [[^(kitty)$]],   title = [[^(htop)$]] },    float = true })

-----------------
---- WORKAROUNDS --
-----------------

-- jetbrains IDEs dropdowns/popups cause flickering
hl.window_rule({
    name             = "jetbrains-popup-flicker",
    match            = { class = [[^(.*jetbrains.*)$]], title = [[^(win[0-9]+)$]] },
    no_initial_focus = true,
})

-- freerdp3 functionality: https://github.com/hyprwm/Hyprland/issues/6427
hl.window_rule({
    name        = "freerdp3-tile",
    match       = { class = "sdl-freerdp3" },
    tile        = true,
    no_max_size = true,
})

-- Overwatch (Steam appid 2357570) runs under XWayland in Borderless Windowed and
-- re-applies its window state on scene changes, which dropped Hyprland out of
-- fullscreen on every respawn. Hyprland owns the fullscreen state here instead.
hl.window_rule({
    name             = "overwatch-own-fullscreen",
    match            = { class = [[^(steam_app_2357570)$]] },
    fullscreen_state = "2 -1",
    sync_fullscreen  = false,
    suppress_event   = "fullscreen maximize",
})

-- █░░ ▄▀█ █▄█ █▀▀ █▀█   █▀█ █░█ █░░ █▀▀ █▀
-- █▄▄ █▀█ ░█░ ██▄ █▀▄   █▀▄ █▄█ █▄▄ ██▄ ▄█

hl.layer_rule({ name = "blur-rofi",          match = { namespace = "rofi" },          blur = true, ignore_alpha = 0 })
hl.layer_rule({ name = "blur-notifications", match = { namespace = "notifications" }, blur = true, ignore_alpha = 0 })
-- hl.layer_rule({ name = "blur-swaync-notification", match = { namespace = "swaync-notification-window" }, blur = true, ignore_alpha = 0 })
-- hl.layer_rule({ name = "blur-swaync-control",      match = { namespace = "swaync-control-center" },      blur = true, ignore_alpha = 0 })
hl.layer_rule({ name = "blur-logout",        match = { namespace = "logout_dialog" }, blur = true })
