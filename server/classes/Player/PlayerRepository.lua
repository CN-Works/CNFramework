-- Saves all player's objects
local Repository = lib.class("PlayerRepository")

function Repository:constructor()
    -- key : int (player id)
    self.private.players = {}
end

-- playerObject : Player
function Repository:addPlayer(playerObject) -- bool
    if playerObject == nil or playerObject.__name ~= "Player" then
        CNF.methods.Log("error", "PlayerRepository:addPlayer invalid playerObject input.")
        return false
    end

    self.private.players[playerObject:getId()] = playerObject

    return true
end

-- server id : int
function Repository:getPlayerByServerId(serverId) -- Player / false
    if serverId == nil or type(serverId) ~= "number" or serverId < 1 then
        CNF.methods.Log("error", "PlayerRepository:getPlayerByServerId invalid serverId input.")
        return false
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
    if discordId == nil or type(discordId) ~= "string" or string.len(discordId) == 0 then
        CNF.methods.Log("error", "PlayerRepository:getPlayerByDiscordId invalid discordId input.")
        return false
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