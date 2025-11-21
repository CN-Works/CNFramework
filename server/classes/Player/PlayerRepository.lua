-- Saves all player's objects
local Repository = lib.class("PlayerRepository")

function Repository:constructor()
    -- key : int (player id)
    self.private.players = {}
    -- key : int (server id)
    self.private.serverPlayers = {}
end

-- playerObject : Player
function Repository:addPlayer(playerObject) -- bool
    if playerObject == nil or playerObject:getId() == nil then
        CNF.Log("error", "PlayerRepository:addPlayer invalid playerObject input.")
        return false
    end

    self.private.players[playerObject:getId()] = playerObject

    return true
end

-- playerId : int
-- serverId : int
function Repository:linkPlayerIdAndServerId(playerId, serverId) -- bool
    if playerId == nil or type(playerId) ~= "number" or playerId < 1 then
        CNF.Log("error", "PlayerRepository:linkPlayerIdAndServerId invalid playerId input.")
        return false
    end

    if serverId == nil or type(serverId) ~= "number" or serverId < 1 then
        CNF.Log("error", "PlayerRepository:linkPlayerIdAndServerId invalid serverId input.")
        return false
    end

    local player = self.private.players[playerId]

    if player == nil then
        CNF.Log("error", "PlayerRepository:linkPlayerIdAndServerId player not found.")
        return false
    end

    local discordId = GetPlayerIdentifierByType(serverId, 'discord')

    if discordId == nil then
        CNF.Log("error", "PlayerRepository:linkPlayerIdAndServerId discordId not found for serverId. ("..serverId..")")
        return false
    end

    discordId = string.gsub(discordId, "discord:", "")

    if discordId ~= player:getDiscordId() then
        CNF.Log("error", "PlayerRepository:linkPlayerIdAndServerId discordId doesn't match.")
        return false
    end

    self.private.serverPlayers[serverId] = player:getId()

    return true
end

-- server id : int
function Repository:getPlayerByServerId(serverId) -- Player / false
    if serverId == nil or type(serverId) ~= "number" or serverId < 1 then
        CNF.Log("error", "PlayerRepository:getPlayerByServerId invalid serverId input.")
        return false
    end

    local discordId = GetPlayerIdentifierByType(serverId, 'discord')

    if discordId == nil then
        CNF.Log("error", "PlayerRepository:getPlayerByServerId discordId not found for serverId. ("..serverId..")")
        return false
    end

    discordId = string.gsub(discordId, "discord:", "")

    local player = self:getPlayerByDiscordId(discordId)

    if player == false then
        CNF.Log("error", "PlayerRepository:getPlayerByServerId player not found.")
        return false
    end

    return player
end

-- playerId : int
-- canBeNewPlayer : bool / nil
function Repository:getPlayerByDiscordId(discordId, canBeNewPlayer) -- Player / false
    if discordId == nil or type(discordId) ~= "string" or string.len(discordId) == 0 then
        CNF.Log("error", "PlayerRepository:getPlayerByDiscordId invalid discordId input.")
        return false
    end

    for playerId, player in pairs(self.private.players) do
        if discordId == player:getDiscordId() then
            return player
        end
    end

    if canBeNewPlayer == nil or canBeNewPlayer == false then
        CNF.Log("error", "PlayerRepository:getPlayerByDiscordId player not found.")
    end
    
    return false
end

-- Global Instance of PlayerRepository
local PlayerRepository = Repository:new()

return PlayerRepository