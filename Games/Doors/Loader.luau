-- SSDoors Doors game router
local BaseUrl = "https://raw.githubusercontent.com/buildaran/ssdoors/main/"

local function LoadRemote(Path)
    local Source = game:HttpGet(BaseUrl .. Path)
    local Chunk, Error = loadstring(Source)

    assert(
        Chunk,
        "SSDoors failed to compile " .. Path .. ": " .. tostring(Error)
    )

    return Chunk()
end

if game.PlaceId == 6516141723 then
    return LoadRemote("Games/Doors/Lobby.luau")
end

return LoadRemote("Games/Doors/Main.luau")
