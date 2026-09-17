local Environment = {}
local Results = {}
local Passed = 0
local Tested = 0

local function expose(Name, Value)
    Environment[Name] = Value
    return Value
end

expose("cloneref", cloneref)
expose("gethui", gethui)
expose("identifyexecutor", identifyexecutor)
expose("getgenv", getgenv)
expose("getrenv", getrenv)
expose("getgc", getgc)
expose("request", request or http_request)
expose("fireproximityprompt", fireproximityprompt)
expose("fireclickdetector", fireclickdetector)
expose("firetouchinterest", firetouchinterest)
expose("newcclosure", newcclosure)
expose("hookfunction", hookfunction)
expose("restorefunction", restorefunction)
expose("isfunctionhooked", isfunctionhooked)
expose("isexecutorclosure", isexecutorclosure)
expose("getnamecallmethod", getnamecallmethod)
expose("hookmetamethod", hookmetamethod)
expose("getrawmetatable", getrawmetatable)
expose("setrawmetatable", setrawmetatable)
expose("isreadonly", isreadonly)
expose("setreadonly", setreadonly)
expose("Drawing", Drawing)
expose("writefile", writefile)
expose("readfile", readfile)
expose("appendfile", appendfile)
expose("loadfile", loadfile)
expose("delfile", delfile)
expose("isfile", isfile)
expose("makefolder", makefolder)
expose("delfolder", delfolder)
expose("isfolder", isfolder)
expose("listfiles", listfiles)
expose("getcustomasset", getcustomasset)

local function test(Name, Callback)
    Tested += 1
    local ok, err = pcall(Callback)
    if ok then
        Passed += 1
        Results[Name] = true
    else
        Results[Name] = false
        warn("Reveal Hub environment: " .. Name .. " unavailable: " .. tostring(err))
    end
end

-- Only lightweight capability checks; unsupported globals are simply reported.
test("identifyexecutor", function()
    assert(type(Environment.identifyexecutor) == "function")
end)

test("cloneref", function()
    assert(type(Environment.cloneref) == "function")
end)

test("gethui", function()
    assert(type(Environment.gethui) == "function")
end)

test("request", function()
    assert(type(Environment.request) == "function")
end)

test("fireproximityprompt", function()
    assert(type(Environment.fireproximityprompt) == "function")
end)

Environment.Results = Results
Environment.Passed = function()
    return Passed
end
Environment.Tested = function()
    return Tested
end
Environment.PrintResults = function()
    print("Reveal Hub Environment Test")
    for Name, DidPass in pairs(Results) do
        print((DidPass and "[OK] " or "[--] ") .. Name)
    end
    print(string.format("Capabilities: %d/%d", Passed, Tested))
end
Environment.Name = "Reveal Hub Environment"

return Environment
