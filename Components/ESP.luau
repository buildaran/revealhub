local Blue = Color3.fromRGB(0, 170, 255)

local Library = {
    Font = Enum.Font.GothamBold,
    TextSize = 18,
    TextTransparency = 0,
    TextOutlineTransparency = 0,
    FillTransparency = 0.85,
    OutlineTransparency = 0,
    OutlineColor = Blue,
    ShowDistance = false,
    MatchColors = true,
    Tracers = false,
    Unloaded = false,
    Highlights = {},
    Labels = {},
    Frames = {},
    Lines = {},
    Colors = {},
    Texts = {},
    Connections = {},
    Objects = {},
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local GuiParent = (gethui and gethui()) or (LocalPlayer and LocalPlayer:FindFirstChildOfClass("PlayerGui")) or CoreGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RevealHubESP"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = GuiParent

local HighlightsFolder = Instance.new("Folder")
HighlightsFolder.Name = "Highlights"
HighlightsFolder.Parent = ScreenGui

local LabelsFolder = Instance.new("Folder")
LabelsFolder.Name = "Labels"
LabelsFolder.Parent = ScreenGui

local function NewLabel(Object, Text, Color)
    local Billboard = Instance.new("BillboardGui")
    Billboard.Name = "RevealLabel"
    Billboard.AlwaysOnTop = true
    Billboard.Size = UDim2.fromOffset(250, 40)
    Billboard.StudsOffset = Vector3.new(0, 3, 0)
    Billboard.Adornee = Object:IsA("Model") and Object.PrimaryPart or Object
    Billboard.Parent = LabelsFolder

    local Label = Instance.new("TextLabel")
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.fromScale(1, 1)
    Label.Font = Library.Font
    Label.TextSize = Library.TextSize
    Label.TextStrokeTransparency = Library.TextOutlineTransparency
    Label.TextColor3 = Color or Blue
    Label.Text = Text
    Label.Parent = Billboard

    return Billboard, Label
end

function Library:AddESP(Parameters)
    if self.Unloaded then return end
    local Object = Parameters.Object
    if not Object or not Object:IsDescendantOf(game) then return end
    if self.Objects[Object] then return end

    local Color = Parameters.Color or Blue
    local Text = Parameters.Text or Object.Name

    local Highlight = Instance.new("Highlight")
    Highlight.Adornee = Object
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Highlight.FillTransparency = self.FillTransparency
    Highlight.OutlineTransparency = self.OutlineTransparency
    Highlight.FillColor = Color
    Highlight.OutlineColor = self.MatchColors and Color or self.OutlineColor
    Highlight.Parent = HighlightsFolder

    local Billboard, Label = NewLabel(Object, Text, Color)

    self.Highlights[Object] = Highlight
    self.Frames[Object] = Billboard
    self.Labels[Object] = Label
    self.Colors[Object] = Color
    self.Texts[Object] = Text
    self.Objects[Object] = true
    self.Connections[Object] = {}

    table.insert(self.Connections[Object], RunService.RenderStepped:Connect(function()
        if self.Unloaded or not Object:IsDescendantOf(game) then
            self:RemoveESP(Object)
            return
        end

        local ActiveColor = self.Colors[Object] or Blue
        local BaseText = self.Texts[Object] or Object.Name
        local DistanceText = ""
        if self.ShowDistance and Camera then
            local Pos = Object:GetPivot().Position
            local Distance = math.floor((Camera.CFrame.Position - Pos).Magnitude)
            DistanceText = " [" .. Distance .. "]"
        end

        Label.Text = BaseText .. DistanceText
        Label.TextColor3 = ActiveColor
        Highlight.FillColor = ActiveColor
        Highlight.OutlineColor = self.MatchColors and ActiveColor or self.OutlineColor
    end))
end

function Library:RemoveESP(Object)
    local Highlight = self.Highlights[Object]
    if Highlight then Highlight:Destroy() end
    local Billboard = self.Frames[Object]
    if Billboard then Billboard:Destroy() end

    local Conns = self.Connections[Object]
    if Conns then
        for _, Conn in ipairs(Conns) do
            Conn:Disconnect()
        end
    end

    self.Highlights[Object] = nil
    self.Frames[Object] = nil
    self.Labels[Object] = nil
    self.Colors[Object] = nil
    self.Texts[Object] = nil
    self.Objects[Object] = nil
    self.Connections[Object] = nil
end

function Library:UpdateObjectColor(Object, Color)
    if self.Objects[Object] then
        self.Colors[Object] = Color
    end
end

function Library:UpdateObjectText(Object, Text)
    if self.Objects[Object] then
        self.Texts[Object] = Text
    end
end

function Library:SetFont(Font)
    self.Font = Font
    for _, Label in pairs(self.Labels) do
        Label.Font = Font
    end
end

function Library:SetTextSize(Size)
    self.TextSize = Size
    for _, Label in pairs(self.Labels) do
        Label.TextSize = Size
    end
end

function Library:SetShowDistance(Value)
    self.ShowDistance = Value
end

function Library:SetMatchColors(Value)
    self.MatchColors = Value
end

function Library:Unload()
    if self.Unloaded then return end
    self.Unloaded = true
    for Object in pairs(self.Objects) do
        self:RemoveESP(Object)
    end
    if ScreenGui then
        ScreenGui:Destroy()
    end
end

if getgenv then
    getgenv().RevealHubESP = Library
end

return Library
