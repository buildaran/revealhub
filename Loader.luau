-- Reveal Hub Loader
if getgenv().RevealHub then
    return getgenv().RevealHub
end

local BaseUrl = "https://raw.githubusercontent.com/buildaran/revealhub/main/"

local RevealHub = {
    Name = "Reveal Hub",
    Legit = true,
    Version = "1.0.0",
}
getgenv().RevealHub = RevealHub

local function LoadRemote(Path)
    local Source = game:HttpGet(BaseUrl .. Path)
    local Chunk, Error = loadstring(Source)
    assert(Chunk, "Reveal Hub failed to compile " .. Path .. ": " .. tostring(Error))
    return Chunk()
end

local function CloneReference(Object)
    if RevealHub.Environment and RevealHub.Environment.cloneref then
        return RevealHub.Environment.cloneref(Object)
    end
    return Object
end

RevealHub.Environment = LoadRemote("Components/Environment.luau")
RevealHub.ESPLibrary = LoadRemote("Components/ESP.luau")
RevealHub.Interface = LoadRemote("Components/Interface.luau")

local GameList = {
    [142823291] = "MurderMystery2",
}

local CurrentGame = GameList[game.GameId] or GameList[game.PlaceId]
if CurrentGame then
    LoadRemote("Games/" .. CurrentGame .. "/Loader.luau")
else
    warn("Reveal Hub: this game is not supported. PlaceId: " .. tostring(game.PlaceId))
end

return RevealHub
