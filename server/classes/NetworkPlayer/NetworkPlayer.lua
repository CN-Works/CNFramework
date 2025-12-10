local NetworkPlayer = lib.class("NetworkPlayer")

function NetworkPlayer:constructor(serverId, playerId)
    self.private.clientLoaded = false

    -- Server Id
    if not CNF.methods.ValidateType(serverId, "number") or serverId < 1 then
        error("NetworkPlayer:constructor invalid serverId input.")
    end

    self.private.serverId = serverId

    -- Player Id
    if not CNF.methods.ValidateType(playerId, "number") or playerId < 1 then
        error("NetworkPlayer:constructor invalid playerId input.")
    end

    if CNF.repository["Player"]:getPlayerById(playerId) == nil then
        error("NetworkPlayer:constructor player not found.")
    end

    self.private.playerId = playerId
end

function NetworkPlayer:getServerId() -- int
    return self.private.serverId
end

function NetworkPlayer:getPlayerId() -- int
    return self.private.playerId
end

function NetworkPlayer:getPlayer() -- Player
    return CNF.repository["Player"]:getPlayerById(self.private.playerId)
end

function NetworkPlayer:isClientLoaded() -- bool
    return self.private.clientLoaded
end

-- When client has loaded, update this
function NetworkPlayer:clientHasLoaded() -- bool
    self.private.clientLoaded = true
end

return NetworkPlayer