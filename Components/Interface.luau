local ObsidianUrl = "https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/"

local Interface = {
	Library = loadstring(game:HttpGet(ObsidianUrl .. "Library.lua"))(),
	SaveManager = loadstring(game:HttpGet(ObsidianUrl .. "addons/SaveManager.lua"))(),
	ThemeManager = loadstring(game:HttpGet(ObsidianUrl .. "addons/ThemeManager.lua"))(),

	-- SSDoors no longer uses the old Abysall home/info or settings tabs.
	ApplyInfoTab = function() end,
	ApplySettingsTab = function() end,
}

Interface.ThemeManager.BuiltInThemes = {
	["Default"]        = { 1,  { FontColor = "ffffff", MainColor = "1c1c1c", AccentColor = "00aaff", BackgroundColor = "141414", OutlineColor = "323232" } },
	["BBot"]           = { 2,  { FontColor = "ffffff", MainColor = "1e1e1e", AccentColor = "00aaff", BackgroundColor = "232323", OutlineColor = "141414" } },
	["Fatality"]       = { 3,  { FontColor = "ffffff", MainColor = "1e1842", AccentColor = "00aaff", BackgroundColor = "191335", OutlineColor = "3c355d" } },
	["Jester"]         = { 4,  { FontColor = "ffffff", MainColor = "242424", AccentColor = "00aaff", BackgroundColor = "1c1c1c", OutlineColor = "373737" } },
	["Mint"]           = { 5,  { FontColor = "ffffff", MainColor = "242424", AccentColor = "00aaff", BackgroundColor = "1c1c1c", OutlineColor = "373737" } },
	["Tokyo Night"]    = { 6,  { FontColor = "ffffff", MainColor = "191925", AccentColor = "00aaff", BackgroundColor = "16161f", OutlineColor = "323232" } },
	["Ubuntu"]         = { 7,  { FontColor = "ffffff", MainColor = "3e3e3e", AccentColor = "00aaff", BackgroundColor = "323232", OutlineColor = "191919" } },
	["Quartz"]         = { 8,  { FontColor = "ffffff", MainColor = "232330", AccentColor = "00aaff", BackgroundColor = "1d1b26", OutlineColor = "27232f" } },
	["Nord"]           = { 9,  { FontColor = "eceff4", MainColor = "3b4252", AccentColor = "00aaff", BackgroundColor = "2e3440", OutlineColor = "4c566a" } },
	["Dracula"]        = { 10, { FontColor = "f8f8f2", MainColor = "44475a", AccentColor = "00aaff", BackgroundColor = "282a36", OutlineColor = "6272a4" } },
	["Monokai"]        = { 11, { FontColor = "f8f8f2", MainColor = "272822", AccentColor = "00aaff", BackgroundColor = "1e1f1c", OutlineColor = "49483e" } },
	["Gruvbox"]        = { 12, { FontColor = "ebdbb2", MainColor = "3c3836", AccentColor = "00aaff", BackgroundColor = "282828", OutlineColor = "504945" } },
	["Solarized"]      = { 13, { FontColor = "839496", MainColor = "073642", AccentColor = "00aaff", BackgroundColor = "002b36", OutlineColor = "586e75" } },
	["Catppuccin"]     = { 14, { FontColor = "d9e0ee", MainColor = "302d41", AccentColor = "00aaff", BackgroundColor = "1e1e2e", OutlineColor = "575268" } },
	["One Dark"]       = { 15, { FontColor = "abb2bf", MainColor = "282c34", AccentColor = "00aaff", BackgroundColor = "21252b", OutlineColor = "5c6370" } },
	["Cyberpunk"]      = { 16, { FontColor = "f9f9f9", MainColor = "262335", AccentColor = "00aaff", BackgroundColor = "1a1a2e", OutlineColor = "413c5e" } },
	["Oceanic Next"]   = { 17, { FontColor = "d8dee9", MainColor = "1b2b34", AccentColor = "00aaff", BackgroundColor = "16232a", OutlineColor = "343d46" } },
	["Material"]       = { 18, { FontColor = "eeffff", MainColor = "212121", AccentColor = "00aaff", BackgroundColor = "151515", OutlineColor = "424242" } },
}

return Interface
