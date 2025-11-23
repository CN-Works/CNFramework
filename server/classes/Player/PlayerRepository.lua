-- Saves all player's objects
local Repository = lib.class("PlayerRepository")

function Repository:constructor()
    -- key : int (player id)
    self.private.players = {}
end

-- playerObject : Player
function Repository:addPlayer(playerObject) -- bool
    if not CNF.methods.ValidateType(playerObject, CNF.classes["Player"]) then
        error("PlayerRepository:addPlayer invalid playerObject input.")
    end

    self.private.players[playerObject:getId()] = playerObject

    return true
end

-- id : int
function Repository:getPlayerById(id) -- Player / false
    if not CNF.methods.ValidateType(id, "number") or id < 1 then
        error("PlayerRepository:getPlayerById invalid id input.")
    end

    return self.private.players[id]
end

-- server id : int
function Repository:getPlayerByServerId(serverId) -- Player / false
    if not CNF.methods.ValidateType(serverId, "number") or serverId < 1 then
        error("PlayerRepository:getPlayerByServerId invalid serverId input.")
    end

    local discordId = CNF.methods.GetDiscordIdByServerId(serverId)

    local player = self:getPlayerByDiscordId(discordId)

    if player == false then
        CNF.methods.Log("error", "PlayerRepository:getPlayerByServerId player not found.")
        return false
    end

    return player
end

-- playerId : int
-- canBeNewPlayer : bool / nil
function Repository:getPlayerByDiscordId(discordId, canBeNewPlayer) -- Player / false
    if not CNF.methods.ValidateType(discordId, "string") or string.len(discordId) == 0 then
        error("PlayerRepository:getPlayerByDiscordId invalid discordId input.")
    end

    for playerId, player in pairs(self.private.players) do
        if discordId == player:getDiscordId() then
            return player
        end
    end

    if canBeNewPlayer == nil or canBeNewPlayer == false then
        CNF.methods.Log("error", "PlayerRepository:getPlayerByDiscordId player not found.")
    end
    
    return false
end

-- Global Instance of PlayerRepository
local PlayerRepository = Repository:new()

return PlayerRepository