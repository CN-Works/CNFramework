local Character = lib.class("Character")
local databaseTables = require "server.databaseTables"
local playerRepository = require "server.classes.Player.PlayerRepository"

function Character:constructor(id, playerId, data, metaData, skin)
    self.private.repository = CNF.repositories["Character"]
    self.private.tableName = databaseTables["characters"]

    -- Id
    if not CNF.methods.ValidateType(id, "number") or id < 1 then
        error("Character:constructor invalid id input.")
    end

    self.private.id = id

    -- playerId
    if not CNF.methods.ValidateType(playerId, "number") or playerId < 1 or playerRepository:getPlayerById(playerId) == false then
        error("Character:constructor invalid playerId input.")
    end

    self.private.playerId = playerId

    -- data
    if not CNF.methods.ValidateType(data, "table") then
        error("Character:constructor invalid data input.")
    end

    self.private.data = data

    -- metaData
    if not CNF.methods.ValidateType(metaData, "table") then
        error("Character:constructor invalid metaData input.")
    end

    self.private.metaData = metaData

    -- skin
    if not CNF.methods.ValidateType(skin, "table") then
        error("Character:constructor invalid skin input.")
    end

    self.private.skin = skin
end

--------------------
-- Repository
--------------------

function Character:getRepository() -- Repository
    return self.private.repository
end

--------------------
-- Methods
--------------------

function Character:getId() -- int
    return self.private.id
end

function Character:getPlayer() -- Player
    return playerRepository:getPlayerById(self.private.playerId)
end

function Character:getPlayerId() -- int
    return self.private.playerId
end

function Character:getAllData() -- table
    return self.private.data
end

-- key : string
function Character:getData(key) -- any
    if not CNF.methods.ValidateType(key, "string") or string.len(key) == 0 then
        error("Character:getData invalid key input.")
    end

    return self.private.data[key]
end

-- ket : string
-- value : any
function Character:setData(key, value) -- bool
    if not CNF.methods.ValidateType(key, "string") or string.len(key) == 0 then
        error("Character:setData invalid key input.")
    end

    if self.private.data == nil then
        error("Character:setData character's data in null.")
    end

    local characterDataCopy = lib.table.deepclone(self.private.data)
    characterDataCopy[key] = value

    local affectedRows = MySQL.update.await(tostring("UPDATE "..self.private.tableName.." SET data = @data WHERE id = @id"), {
        ["data"] = json.encode(characterDataCopy),
        ["id"] = self:getId(),
    })
    
    -- Update object
    if affectedRows > 0 then
        self.private.data[key] = value
        self.private.data[key] = value
    
        -- Events
        TriggerEvent("cnf:entity:character:onDataUpdated", self:getId(), key, value)
        TriggerClientEvent("cnf:entity:character:onDataUpdate", -1, self:getId(), key, value)

        return true
    else
        CNF.methods.Log("error", "Character:setData SQL query failed.")
        return false
    end
end


return Character