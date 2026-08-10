-- hyprselect plugin (https://github.com/jmanc3/hyprselect)
--
-- The plugin is loaded at runtime, so `plugin.hyprselect.*` config keys do not
-- exist when this file is evaluated -- `hl.config` rejects them with
-- "unknown config key". hyprlang tolerated that; the Lua config manager does not.
-- So the options are applied with `hyprctl keyword` immediately after the plugin
-- loads, which is guaranteed to work because the keys exist by then.
--
-- If a future Hyprland registers plugin keys at parse time, this collapses to:
--   hl.plugin.load("/home/cj/Programs/hyprselect/hyprselect.so")
--   hl.config({ plugin = { hyprselect = { should_round = false, ... } } })

local plugin_path = os.getenv("HOME") .. "/Programs/hyprselect/hyprselect.so"

local options = {
    ["should_round"]   = "false",
    ["col.main"]       = "rgba(0085e625)",
    ["col.border"]     = "rgba(0085e6ff)",
    ["fade_time_ms"]   = "65.0",
    ["should_blur"]    = "false",
    ["blur_power"]     = "1.0",  -- range: 0.0 -> 1.0
    ["border_size"]    = "-1.0", -- negative number (-1.0) means automatic
    ["rounding"]       = "6",
    ["rounding_power"] = "2.0",
}

hl.on("hyprland.start", function()
    local cmd = "hyprctl plugin load " .. plugin_path
    for key, value in pairs(options) do
        cmd = cmd .. " && hyprctl keyword plugin:hyprselect:" .. key .. " " .. value
    end
    hl.exec_cmd(cmd)
end)
