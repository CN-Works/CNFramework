-- Saves all player's objects
local Repository = lib.class("PlayerRepository")
local databaseTables = require "server.databaseTables"

function Repository:constructor()
    -- key : int (player id)
    self.private.players = {}
    self.private.tableName = databaseTables["players"]
end

function Repository:getPlayers() -- table
    return self.private.players
end

-- discordId : string
function Repository:createPlayer(discordId, name) -- Player / false
    if not CNF.methods.ValidateType(discordId, "string") or string.len(discordId) == 0 or string.len(discordId) > 19 then
        error("PlayerRepository:createPlayer invalid discordId input.")
    end

    if not CNF.methods.ValidateType(name, "string") or string.len(name) == 0 or string.len(name) > 50 then
        name = "Player"
    end

    local default = {
        name = name,
        data = {
            ["registrationTime"] = os.time(),
        },
        roles = {
            "user",
        },
    }

    -- New Player
    local id = MySQL.insert.await("INSERT INTO `"..self.private.tableName.."` (discord_id, name, data, roles) VALUES (@discordId,@name, @data, @roles)", {
        ["discordId"] = discordId,
        ["name"] = default.name,
        ["data"] = json.encode(default.data),
        ["roles"] = json.encode(default.roles),
    })

    if id then
        local newPlayer = CNF.classes["Player"]:new(id, discordId, default.name, default.data, default.roles)

        -- Adds the player to the repository
        self:addPlayer(newPlayer)

        CNF.methods.Log("info", "New player registered")

        return newPlayer
    else
        return false
    end
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
function Repository:getPlayerById(id) -- Player / nil
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