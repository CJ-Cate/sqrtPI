-- SqrtPI Keybinds v0
-- Converted from keybindings.conf. Flag letters map to bind options:
--   d -> description, l -> locked, e -> repeating, m -> mouse

local mainMod  = "SUPER" -- this is the windows key, icon key, etc.
local scrPath  = os.getenv("HOME") .. "/sqrtPI/Scripts"

-- local TERMINAL = "alacritty"
local TERMINAL = "ghostty"
-- local EDITOR   = "code" -- not implemented yet
local EXPLORER = "dolphin"
local BROWSER  = "librewolf"

-- CRITICAL
-- warning: this DOES cause system problems but it is totally worth it
-- hl.bind("L", hl.dsp.exec_cmd(scrPath .. "/lizard.sh"))
-- hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(scrPath .. "/lizard.sh"))

--------------------
---- LAUNCHERS -----
--------------------

hl.bind(mainMod .. " + T",         hl.dsp.exec_cmd(TERMINAL), { description = "[Launcher|Apps] terminal emulator" })
-- hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(EXPLORER), { description = "[Launcher|Apps] file explorer" })
hl.bind(mainMod .. " + B",         hl.dsp.exec_cmd(BROWSER),  { description = "[Launcher|Apps] web browser" })
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(BROWSER .. " --private-window"), { description = "[Launcher|Apps] web browser (private)" })

-- Exit hyprla-
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exit())

-- Screenshot tool -> hyprshot
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region -o " .. os.getenv("HOME") .. "/Pictures/Screenshots"),
        { description = "live screenshot" })

-- Application launcher
hl.bind(mainMod .. " + space",     hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofilaunch.sh"), { description = "[Launcher|Rofi menus] application finder" })
hl.bind(mainMod .. " + SHIFT + t", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofitheme.sh"),  { description = "[Launcher|Rofi menus] theme switche" })
-- hl.bind(mainMod .. " + slash",     hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/keybinds_hint.sh c"), { description = "keybindings hint" })
-- hl.bind(mainMod .. " + V",         hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/cliphist.sh -c"),     { description = "clipboard" })
-- hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/cliphist.sh"),        { description = "clipboard manager" })

--------------------
---- MEDIA ---------
--------------------

-- (first two toggle between media play and pause)
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, description = "[Launcher|Rofi menus] play media" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, description = "[Launcher|Rofi menus] pause media" })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true, description = "[Launcher|Rofi menus] play next" })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true, description = "[Launcher|Rofi menus] play previous" })

-- Adjust Audio
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o d"), { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o i"), { locked = true, repeating = true })

------------------------------------------------------
---- Boilerplate window movement, less interesting ----
------------------------------------------------------

-- Steam's X11 window treats close as quit, so hide it instead of killing it.
-- Ported from dontkillsteam.sh, which only existed because the old .conf config
-- could not branch on window class.
local function close_window()
    local w = hl.get_active_window()
    if w and w.class == "Steam" then
        hl.exec_cmd("xdotool getactivewindow windowunmap")
    else
        hl.dispatch(hl.dsp.window.close())
    end
end

hl.bind(mainMod .. " + Q",        close_window,                                    { description = "[Window Management] close focused window" })
-- hl.bind("ALT + F4",            close_window,                                    { description = "[Window Management] close focused window" })
hl.bind("SHIFT + F11",            hl.dsp.window.fullscreen(),                      { description = "[Window Management] toggle fullscreen" })
hl.bind(mainMod .. " + W",        hl.dsp.window.float({ action = "toggle" }),      { description = "[Window Management] toggle floating window" })
hl.bind(mainMod .. " + S",        hl.dsp.layout("togglesplit"),                    { description = "[Window Management] toggle split" })
hl.bind("CONTROL + ALT + Delete", hl.dsp.exec_cmd(scrPath .. "/logoutlaunch.sh"),  { description = "[Window Management] logout menu" })

-- Move/Resize focused window with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true, description = "[Window Management|Move & Resize with mouse] hold to move window" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "[Window Management|Move & Resize with mouse] hold to resize window" })

-- Move/Change window focus
local directions = {
    { key = "Left",  dir = "l", name = "left" },
    { key = "Right", dir = "r", name = "right" },
    { key = "Up",    dir = "u", name = "up" },
    { key = "Down",  dir = "d", name = "down" },
}

-- Arrow keys swap windows
for _, d in ipairs(directions) do
    hl.bind(mainMod .. " + " .. d.key, hl.dsp.window.swap({ direction = d.name }))
end

-- Vim keybinds move focus
local vim_keys = {
    { key = "H", name = "left" },
    { key = "J", name = "down" },
    { key = "K", name = "up" },
    { key = "L", name = "right" },
}

for _, d in ipairs(vim_keys) do
    hl.bind(mainMod .. " + " .. d.key, hl.dsp.focus({ direction = d.name }))
end

-- Alt tab
-- no alt tab x.x

--------------------
---- WORKSPACES ----
--------------------

-- Switch workspaces, and move the focused window to a workspace.
-- 7-10 were commented out in the .conf; the loop bound stays at 6.
for i = 1, 6 do
    hl.bind(mainMod .. " + " .. i,             hl.dsp.focus({ workspace = i }),
            { description = "[Workspaces|Navigation] navigate to workspace " .. i })
    hl.bind(mainMod .. " + SHIFT + " .. i,     hl.dsp.window.move({ workspace = i }),
            { description = "[Workspaces|Move window to workspace] move window to workspace " .. i })
end
