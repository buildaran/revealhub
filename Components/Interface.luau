local ObsidianUrl = "https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/"

local Interface = {
    Library = loadstring(game:HttpGet(ObsidianUrl .. "Library.lua"))(),
    SaveManager = loadstring(game:HttpGet(ObsidianUrl .. "addons/SaveManager.lua"))(),
    ThemeManager = loadstring(game:HttpGet(ObsidianUrl .. "addons/ThemeManager.lua"))(),
}

Interface.ThemeManager.BuiltInThemes = {
    ["Reveal Blue"] = { 1, {
        FontColor = "ffffff",
        MainColor = "161b22",
        AccentColor = "00aaff",
        BackgroundColor = "0f1318",
        OutlineColor = "25303b",
    } },
}

return Interface
