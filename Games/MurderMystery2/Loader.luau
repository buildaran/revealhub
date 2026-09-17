local Start = tick()
local RevealHub = getgenv().RevealHub
local Library = RevealHub.Interface.Library
local Toggles = Library.Toggles
local Options = Library.Options

local BLUE = Color3.fromRGB(0, 170, 255)

local Window = Library:CreateWindow({
    Title = "Reveal Hub",
    Footer = "Murder Mystery 2",
    NotifySide = "Right",
    AutoShow = true,
    Center = true,
    TabPadding = 4,
    MenuFadeTime = 0.15,
    CornerRadius = 4,
})

local Main = Window:AddTab("Main", "home")
local Visuals = Window:AddTab("Visuals", "eye")
local Settings = Window:AddTab("Settings", "settings")

local MainBox = Main:AddLeftGroupbox("Reveal Hub")
MainBox:AddLabel("MM2 support loaded successfully.")
MainBox:AddDivider()
MainBox:AddButton({
    Text = "Unload Reveal Hub",
    DoubleClick = true,
    Func = function()
        if RevealHub.ESPLibrary then
            RevealHub.ESPLibrary:Unload()
        end
        Library:Unload()
        getgenv().RevealHub = nil
    end,
})

local PlayerBox = Visuals:AddLeftGroupbox("Player Visuals")
PlayerBox:AddToggle("PlayerESP", {
    Text = "Highlight Players",
    Default = false,
    Tooltip = "Adds a blue outline and name label to visible players.",
})
Toggles.PlayerESP:AddColorPicker("PlayerESPColor", {
    Text = "Highlight Color",
    Default = BLUE,
    Transparency = 0,
})

PlayerBox:AddToggle("ShowDistance", {
    Text = "Show Distance",
    Default = false,
    Tooltip = "Adds approximate distance to the player label.",
})

local function ClearPlayers()
    for _, Player in ipairs(game:GetService("Players"):GetPlayers()) do
        if Player ~= game:GetService("Players").LocalPlayer and Player.Character then
            RevealHub.ESPLibrary:RemoveESP(Player.Character)
        end
    end
end

local function UpdatePlayers()
    ClearPlayers()
    if not Toggles.PlayerESP.Value then return end
    for _, Player in ipairs(game:GetService("Players"):GetPlayers()) do
        if Player ~= game:GetService("Players").LocalPlayer and Player.Character then
            local Root = Player.Character:FindFirstChild("HumanoidRootPart")
            if Root then
                RevealHub.ESPLibrary:AddESP({
                    Object = Player.Character,
                    Text = Player.DisplayName,
                    Color = Options.PlayerESPColor.Value,
                })
            end
        end
    end
end

Toggles.PlayerESP:OnChanged(UpdatePlayers)
Options.PlayerESPColor:OnChanged(UpdatePlayers)
Toggles.ShowDistance:OnChanged(function(Value)
    RevealHub.ESPLibrary:SetShowDistance(Value)
end)

local SettingsBox = Settings:AddLeftGroupbox("Appearance")
SettingsBox:AddToggle("MenuToggle", {
    Text = "Reveal Hub Menu",
    Default = true,
    Tooltip = "Shows or hides the Reveal Hub window.",
})
Toggles.MenuToggle:AddKeyPicker("MenuKeybind", {
    Default = "RightShift",
    Mode = "Toggle",
    SyncToggleState = true,
    Text = "Toggle Menu",
})

SettingsBox:AddButton({
    Text = "Reset Visuals",
    Func = function()
        ClearPlayers()
        UpdatePlayers()
    end,
})

Library.ToggleKeybind = Options.MenuKeybind

Library:OnUnload(function()
    if RevealHub.ESPLibrary then
        RevealHub.ESPLibrary:Unload()
    end
end)

local Notify = function(Title, Body)
    pcall(function()
        Library:Notify({Title = Title, Description = Body})
    end)
end

Notify("Reveal Hub", string.format("MM2 module loaded in %.2fs", tick() - Start))

return true
