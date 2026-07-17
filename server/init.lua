if CNF.isReady then
    return
end

-- Entity Lockdown
SetRoutingBucketEntityLockdownMode(0,"inactive")

-- Waiting for MySQL
while MySQL.isReady() == false do
    Wait(0)
end

local startTime = os.nanotime()

------
-- Repositories
------

CNF.repositories["Player"] = CNF.classes["PlayerRepository"]:new()
-- Depends on PlayerRepository
CNF.repositories["NetworkPlayer"] = CNF.classes["NetworkPlayerRepository"]:new()
-- Depends on nothing
CNF.repositories["Instance"] = CNF.classes["InstanceRepository"]:new()

-- Repository loader (can take a while due to deserialization)
ServerCache.loadedRepositories["Player"] = CNF.repositories["Player"]:init()
ServerCache.loadedRepositories["NetworkPlayer"] = CNF.repositories["NetworkPlayer"]:init()
ServerCache.loadedRepositories["Instance"] = CNF.repositories["Instance"]:init()

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

print([[
   _____ _   _ ______                                           _    
  / ____| \ | |  ____|                                         | |   
 | |    |  \| | |__ _ __ __ _ _ __ ___   _____      _____  _ __| | __
 | |    | . ` |  __| '__/ _` | '_ ` _ \ / _ \ \ /\ / / _ \| '__| |/ /
 | |____| |\  | |  | | | (_| | | | | | |  __/\ V  V / (_) | |  |   < 
  \_____|_| \_|_|  |_|  \__,_|_| |_| |_|\___| \_/\_/ \___/|_|  |_|\_\]].."\n\nEverything has loaded within "..string.format("%.3f", (os.nanotime() - startTime) / 1e9).."s.\nWelcome !")