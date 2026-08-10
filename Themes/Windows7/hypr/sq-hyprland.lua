-- Theme: Windows7

hl.config({
    -- Window rounding
    decoration = {
        rounding = 3,
        shadow = {
            range          = 25,
            render_power   = 2,
            offset         = { 5, 5 },
            color_inactive = "rgba(00000000)", -- was 0x00000000
        },
    },

    general = {
        border_size = 5,
        col = {
            inactive_border = "rgba(191c25ff)", -- was 0xFF191C25
            active_border   = "rgba(b3d6fbff)", -- was 0xFFB3D6FB
        },
        gaps_in  = 12, -- gap between windows
        gaps_out = 20, -- gap between borders (global) or (top, right, bottom, left)
    },

    animations = {
        enabled = true,
    },
})

hl.curve("wind",   { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.curve("winIn",  { type = "bezier", points = { {0.1, 1.1},  {0.1, 1.1} } })
hl.curve("winOut", { type = "bezier", points = { {0.3, -0.3}, {0, 1} } })
hl.curve("liner",  { type = "bezier", points = { {1, 1},      {1, 1} } })

-- Note: this theme has no border or borderangle animation, unlike the others.
hl.animation({ leaf = "windows",     enabled = true, speed = 6,  bezier = "wind",   style = "slide" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 6,  bezier = "winIn",  style = "slide" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 5,  bezier = "winOut", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5,  bezier = "wind",   style = "slide" })
hl.animation({ leaf = "fade",        enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 5,  bezier = "wind" })
