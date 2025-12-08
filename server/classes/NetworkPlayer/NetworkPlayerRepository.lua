local Repository = lib.class("NetworkPlayerRepository")
local NetworkPlayer = require "server.classes.NetworkPlayer.NetworkPlayer"

function Repository:constructor()
    -- key : int (serverId)
    -- value : NetworkPlayer object
    self.private.networkPlayers = {}
end

function Repository:getNetworkPlayers() -- table
    return self.private.networkPlayers
end

-- serverId : int
-- playerId : int
function Repository:createNetworkPlayer(serverId, playerId) -- NetworkPlayer / false
    if not CNF.methods.ValidateType(serverId, "number") or serverId < 1 then
        error("NetworkPlayerRepository:createNetworkPlayer invalid serverId input.")
    end
    
    if not CNF.methods.ValidateType(playerId, "number") or playerId < 1 then
        error("NetworkPlayerRepository:createNetworkPlayer invalid playerId input.")
    end
    
    local networkPlayer = NetworkPlayer:new(serverId, playerId)

    -- Adds the player to the repository
    self:addNetworkPlayer(networkPlayer)

    return networkPlayer
end

-- networkPlayer : NetworkPlayer
function Repository:addNetworkPlayer(networkPlayer) -- bool
    if not CNF.methods.ValidateType(networkPlayer, CNF.classes["NetworkPlayer"]) then
        error("NetworkPlayerRepository:addNetworkPlayer invalid networkPlayer input.")
    end

    local serverId = networkPlayer:getServerId()

    print("adding network serverId : "..serverId)

    self.private.networkPlayers[serverId] = networkPlayer

    return true
end

-- serverId : int
function Repository:getNetworkPlayerByServerId(serverId) -- NetworkPlayer / nil
    if not CNF.methods.ValidateType(serverId, "number") or serverId < 1 then
        error("NetworkPlayerRepository:getNetworkPlayerByServerId invalid serverId input.")
    end

    return self.private.networkPlayers[serverId]
end

-- playerId : int
function Repository:getNetworkPlayerByPlayerId(playerId) -- NetworkPlayer / nil
    if not CNF.methods.ValidateType(playerId, "number") or playerId < 1 then
        error("NetworkPlayerRepository:getNetworkPlayerByPlayerId invalid playerId input.")
    end

    for serverId, networkPlayer in pairs(self.private.networkPlayers) do
        if playerId == networkPlayer:getPlayerId() then
            return networkPlayer
        end
    end
end

-- Instance of class
local NetworkPlayerRepository = Repository:new()

return NetworkPlayerRepository