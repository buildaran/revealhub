-- SSDoors Loader

if ssdoors then
    return
end

local BaseUrl = "https://raw.githubusercontent.com/buildaran/ssdoors/main/"

getgenv().ssdoors = {
    Name = "SSDoors",
    Legit = true,
}

local GameList = {
    [2440500124] = "Doors",
}

local function LoadRemote(Path)
    local Source = game:HttpGet(BaseUrl .. Path)
    local Chunk, Error = loadstring(Source)

    assert(
        Chunk,
        "SSDoors failed to compile " .. Path .. ": " .. tostring(Error)
    )

    return Chunk()
end

local function CloneReference(Object)
    if ssdoors and ssdoors.Environment and ssdoors.Environment.cloneref then
        return ssdoors.Environment.cloneref(Object)
    end

    return Object
end

local Services = setmetatable({}, {
    __index = function(_, Name)
        return CloneReference(game:GetService(Name))
    end,
})

-- Core modules only. Analytics and the old UI-library persistence block were removed.
ssdoors.Environment = LoadRemote("Components/Environment.luau")
ssdoors.ESPLibrary = LoadRemote("Components/ESP.luau")

-- The Interface module is kept because the game loaders may depend on it.
ssdoors.Interface = LoadRemote("Components/Interface.luau")

local CurrentGame = GameList[game.GameId]

if CurrentGame then
    LoadRemote("Games/" .. CurrentGame .. "/Loader.luau")
else
    LoadRemote("Games/Universal/Loader.luau")
end
