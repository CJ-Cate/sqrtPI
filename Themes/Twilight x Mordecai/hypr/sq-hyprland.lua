-- Theme: Twilight x Mordecai
--
-- Dropped the vestigial `source = ./matugen-hyprland.conf` (declared $colour
-- variables that nothing in this theme used).

hl.config({
    -- Window rounding
    decoration = {
        rounding = 10,
    },

    general = {
        border_size = 5,
        col = {
            active_border = {
                colors = { "rgb(C99DCE)", "rgb(9B5A9E)", "rgb(0761BE)", "rgb(0761BE)" },
                angle  = 0,
            },
        },
    },

    animations = {
        enabled = true,
    },
})

hl.curve("wind",   { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.curve("winIn",  { type = "bezier", points = { {0.1, 1.1},  {0.1, 1.1} } })
hl.curve("winOut", { type = "bezier", points = { {0.3, -0.3}, {0, 1} } })
hl.curve("liner",  { type = "bezier", points = { {1, 1},      {1, 1} } })

-- Note: this theme has no borderangle animation, unlike the others.
hl.animation({ leaf = "windows",     enabled = true, speed = 6,  bezier = "wind",   style = "slide" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 6,  bezier = "winIn",  style = "slide" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 5,  bezier = "winOut", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5,  bezier = "wind",   style = "slide" })
hl.animation({ leaf = "border",      enabled = true, speed = 1,  bezier = "liner" })
hl.animation({ leaf = "fade",        enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 5,  bezier = "wind" })
