RegisterNetEvent("CNFramework:server:playerClientHasLoaded", function()
    local src = source
    local networkPlayer = CNF.repositories["NetworkPlayer"]:getNetworkPlayerByServerId(src)

    -- Check if cached data is init
    if (networkPlayer == nil) == false then
        if networkPlayer:isClientLoaded() then
            CNF.methods.Log("error", tostring("CNFramework:server:playerClientHasLoaded client's player has already loaded. (serverId: "..src.." with playerId: "..CNF.repositories["Player"]:getPlayerByServerId(src):getId()..")"))
            DropPlayer(src, "Anticheat : You're already loaded on the server.")
            return
        end
    end
    
    local player = CNF.repositories["Player"]:getPlayerByServerId(src)

    if not CNF.methods.InstanceOf(player, CNF.classes["Player"]) then
        DropPlayer(src, "You're not registered on the server as a player (contact the server owner).")
    end

    networkPlayer = CNF.repositories["NetworkPlayer"]:createNetworkPlayer(src, player:getId())

    networkPlayer:clientHasLoaded()

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

    -- Trigger a server event when player as finally loaded and ready
    TriggerEvent("CNFramework:server:playerHasLoaded", src, player:getId())
end)