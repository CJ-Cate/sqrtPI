-- Theme: Fjell

-- Remove all opacity, it doesnt look good on this one
hl.window_rule({
    name    = "theme-no-opacity",
    match   = { class = ".*" },
    opacity = "1 override",
})

hl.config({
    -- Window rounding
    decoration = {
        rounding = 6,
    },

    general = {
        border_size = 3,
        col = {
            active_border   = "rgba(09aec8ff)", -- was 0xFF09AEC8
            inactive_border = "rgba(8a70ff88)", -- was 0x888A70FF
        },
    },

    animations = {
        enabled = true,
    },
})

hl.curve("wind",   { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.curve("winIn",  { type = "bezier", points = { {0.1, 1},    {0.1, 1} } })
hl.curve("winOut", { type = "bezier", points = { {0.3, -0.3}, {0, 1} } })
hl.curve("liner",  { type = "bezier", points = { {1, 1},      {1, 1} } })

hl.animation({ leaf = "windows",     enabled = true, speed = 6,  bezier = "wind",   style = "slide" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 6,  bezier = "winIn",  style = "slide" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 5,  bezier = "winOut", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5,  bezier = "wind",   style = "slide" })
hl.animation({ leaf = "border",      enabled = true, speed = 1,  bezier = "liner" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "liner",  style = "once" })
hl.animation({ leaf = "fade",        enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 5,  bezier = "wind" })
