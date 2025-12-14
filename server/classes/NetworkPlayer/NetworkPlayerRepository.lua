-- Repository Class
local NetworkPlayerRepository = lib.class("NetworkPlayerRepository")

function NetworkPlayerRepository:constructor()
    -- key : int (serverId)
    -- value : NetworkPlayer object
    self.private.networkPlayers = {}
    self.private.init = false
end

function NetworkPlayerRepository:getNetworkPlayers() -- table
    return self.private.networkPlayers
end

-- networkPlayer : NetworkPlayer
function NetworkPlayerRepository:addNetworkPlayer(networkPlayer) -- bool / nil
    if not CNF.methods.ValidateType(networkPlayer, CNF.classes["NetworkPlayer"]) then
        error("NetworkPlayerRepository:addNetworkPlayer invalid networkPlayer input.")
    end

    local serverId = networkPlayer:getServerId()

    self.private.networkPlayers[serverId] = networkPlayer

    return true
end

-- serverId : int
function NetworkPlayerRepository:getNetworkPlayerByServerId(serverId) -- NetworkPlayer / nil
    if not CNF.methods.ValidateType(serverId, "number") or serverId < 1 then
        error("NetworkPlayerRepository:getNetworkPlayerByServerId invalid serverId input.")
    end

    return self.private.networkPlayers[serverId]
end

-- playerId : int
function NetworkPlayerRepository:getNetworkPlayerByPlayerId(playerId) -- NetworkPlayer / nil
    if not CNF.methods.ValidateType(playerId, "number") or playerId < 1 then
        error("NetworkPlayerRepository:getNetworkPlayerByPlayerId invalid playerId input.")
    end

    for serverId, networkPlayer in pairs(self.private.networkPlayers) do
        if playerId == networkPlayer:getPlayerId() then
            return networkPlayer
        end
    end
end

-- serverId : int
-- playerId : int
function NetworkPlayerRepository:createNetworkPlayer(serverId, playerId) -- NetworkPlayer / nil
    if not CNF.methods.ValidateType(serverId, "number") or serverId < 1 then
        error("NetworkPlayerRepository:createNetworkPlayer invalid serverId input.")
    end
    
    if not CNF.methods.ValidateType(playerId, "number") or playerId < 1 then
        error("NetworkPlayerRepository:createNetworkPlayer invalid playerId input.")
    end
    
    local networkPlayer = CNF.classes["NetworkPlayer"]:new(serverId, playerId)

    -- Adds the player to the repository
    self:addNetworkPlayer(networkPlayer)

    return networkPlayer
end

-- serverId : int
function NetworkPlayerRepository:removeNetworkPlayerByServerId(serverId) -- bool
    if not CNF.methods.ValidateType(serverId, "number") or serverId < 1 then
        error("NetworkPlayerRepository:removeNetworkPlayerByServerId invalid serverId input.")
    end

    if not CNF.methods.ValidateType(self.private.networkPlayers[serverId], CNF.classes["NetworkPlayer"]) then
        error("NetworkPlayerRepository:removeNetworkPlayerByServerId networkPlayer not found.")
        return false
    end

    self.private.networkPlayers[serverId] = nil

    return true
end

function NetworkPlayerRepository:init() -- bool
    self.private.init = true
    return self.private.init
end

return NetworkPlayerRepository