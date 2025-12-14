-- Repository Class
local PlayerRepository = lib.class("PlayerRepository")

function PlayerRepository:constructor()
    -- key : int (player id)
    self.private.players = {}
    self.private.tableName = CNF.databaseTables["players"]
    self.private.init = false
end

function PlayerRepository:getPlayers() -- table
    return self.private.players
end

-- discordId : string
function PlayerRepository:createPlayer(discordId, name) -- Player / nil
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
    end
end

-- playerObject : Player
function PlayerRepository:addPlayer(playerObject) -- bool / nil
    if not CNF.methods.ValidateType(playerObject, CNF.classes["Player"]) then
        error("PlayerRepository:addPlayer invalid playerObject input.")
    end

    self.private.players[playerObject:getId()] = playerObject

    return true
end

-- id : int
function PlayerRepository:getPlayerById(id) -- Player / nil
    if not CNF.methods.ValidateType(id, "number") or id < 1 then
        error("PlayerRepository:getPlayerById invalid id input.")
    end

    return self.private.players[id]
end

-- server id : int
function PlayerRepository:getPlayerByServerId(serverId) -- Player / nil
    if not CNF.methods.ValidateType(serverId, "number") or serverId < 1 then
        error("PlayerRepository:getPlayerByServerId invalid serverId input.")
    end

    local discordId = CNF.methods.GetDiscordIdByServerId(serverId)

    local player = self:getPlayerByDiscordId(discordId)

    if CNF.methods.ValidateType(player, CNF.classes["Player"]) then
        return player
    end
    
    CNF.methods.Log("error", "PlayerRepository:getPlayerByServerId player not found.")
end

-- playerId : int
-- canBeNewPlayer : bool / nil
function PlayerRepository:getPlayerByDiscordId(discordId, canBeNewPlayer) -- Player / nil
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
end

function PlayerRepository:init() -- bool
    while MySQL.isReady() == false do
        Wait(0)
    end
    
    local response = MySQL.rawExecute.await(tostring("SELECT * FROM `"..self.private.tableName.."`"))
    
    if CNF.methods.ValidateType(response, "table") then
        for key, value in pairs(response) do
            self:addPlayer(CNF.classes["Player"]:new(value.id, value.discord_id, value.name, json.decode(value.data), json.decode(value.roles)))
        end

        CNF.methods.Log("orm", tostring(#response.." players loaded."))

        self.private.init = true
    else
        CNF.methods.Log("critical", "Player Init : MySQL query failed.")
        self.private.init = false
    end

    return self.private.init
end

return PlayerRepository