if CNF.isReady then
    return
end

--error("debug me")

local startTime = os.nanotime()

-- Server Population
SetRoutingBucketPopulationEnabled(0, Config.enablePopulation)

-- Waiting for MySQL
while MySQL.isReady() == false do
    Wait(0)
end

------
-- Repositories
------

CNF.repositories["Player"] = CNF.classes["PlayerRepository"]:new()
-- Depends on PlayerRepository
CNF.repositories["Character"] = CNF.classes["CharacterRepository"]:new()
-- Depends on PlayerRepository, CharacterRepository
CNF.repositories["NetworkPlayer"] = CNF.classes["NetworkPlayerRepository"]:new()

-- Repository loader (can take a while due to deserialization)
ServerCache.loadedRepositories["Player"] = CNF.repositories["Player"]:init()
ServerCache.loadedRepositories["Character"] = CNF.repositories["Character"]:init()
ServerCache.loadedRepositories["NetworkPlayer"] = CNF.repositories["NetworkPlayer"]:init()

-- Catch loader errors
for repositoryName, status in pairs(ServerCache.loadedRepositories) do
    if status == false then
        CNF.methods.Log("critical",tostring("CNFramework:server:init repository '"..repositoryName.."' failed to load."))
    end
end

------
-- Server Ready
------
CNF.isReady = true

print("CNFramework has loaded within "..string.format("%.3f", (os.nanotime() - startTime) / 1e9).."s.\nWelcome !")