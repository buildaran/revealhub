-- SSDoors Doors Lobby entry
-- This module intentionally does not initialize the game features in the lobby.

local Environment = ssdoors and ssdoors.Environment
local Container = (Environment and Environment.gethui and Environment.gethui()) or game:GetService("CoreGui")

local Gui = Instance.new("ScreenGui")
Gui.Name = "SSDoorsLobby"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.DisplayOrder = 32767
Gui.Parent = Container

local Frame = Instance.new("Frame")
Frame.Size = UDim2.fromOffset(360, 86)
Frame.Position = UDim2.new(0.5, -180, 0.5, -43)
Frame.BackgroundColor3 = Color3.fromRGB(18, 24, 32)
Frame.BackgroundTransparency = 0.05
Frame.BorderSizePixel = 0
Frame.Parent = Gui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = Frame

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(0, 170, 255)
Stroke.Thickness = 1.5
Stroke.Transparency = 0.1
Stroke.Parent = Frame

local Accent = Instance.new("Frame")
Accent.Size = UDim2.new(0, 4, 1, 0)
Accent.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Accent.BorderSizePixel = 0
Accent.Parent = Frame

local AccentCorner = Instance.new("UICorner")
AccentCorner.CornerRadius = UDim.new(0, 8)
AccentCorner.Parent = Accent

local Label = Instance.new("TextLabel")
Label.BackgroundTransparency = 1
Label.Size = UDim2.new(1, -36, 1, -20)
Label.Position = UDim2.fromOffset(20, 10)
Label.Font = Enum.Font.GothamBold
Label.TextSize = 16
Label.TextColor3 = Color3.fromRGB(235, 245, 255)
Label.TextXAlignment = Enum.TextXAlignment.Center
Label.TextYAlignment = Enum.TextYAlignment.Center
Label.TextWrapped = true
Label.Text = "SSDoors cannot run in the lobby."
Label.Parent = Frame

task.delay(4, function()
    if Gui and Gui.Parent then
        Gui:Destroy()
    end
end)
