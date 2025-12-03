RegisterNetEvent("CNFramework:server:playerClientHasLoaded", function()
    local src = source

    -- Check if cached data is init
    if ServerCache.playersCachedData[src] == nil or ServerCache.playersCachedData[src].isClientLoaded == true then
        CNF.methods.Log("error", tostring("CNFramework:server:playerClientHasLoaded client's player has already loaded. (serverId: "..src.." with playerId: "..CNF.repositories["Player"]:getPlayerByServerId(src):getId()..")"))
        DropPlayer(src, "Anticheat : You're already loaded on the server.")
        return
    end

    local playerDiscordId = CNF.methods.GetDiscordIdByServerId(src)
    
    local player = CNF.repositories["Player"]:getPlayerByDiscordId(playerDiscordId)

    if not CNF.methods.ValidateType(player, CNF.classes["Player"]) then
        DropPlayer(src, "You're not registered on the server as a player (contact the server owner).")
    end

    CNF.methods.Log("info",tostring(player:getName().."'s client has loaded. serverId : "..src.." playerId : "..player:getId()))

    ServerCache.playersCachedData[src].isClientLoaded = true

    -- This is a client-side version of the player's global data
    -- It meant to be used client side.
    local data = {
        id = player:getId(),
        name = player:getName(),
        data = player:getAllData(),
        roles = player:getRoles(),
    }

    TriggerClientEvent("CNFramework:client:updatePlayerData", src, data)

    -- Player's statebag
    local stateBag = Player(src).state

    stateBag["playerId"] = data.id
    stateBag["playerName"] = data.name

    -- Character Selection
    -- TODO
end)