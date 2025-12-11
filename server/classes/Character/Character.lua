-- Class
local Character = lib.class("Character")

function Character:constructor(id, playerId, data, metadata, skin)
    self.private.repository = CNF.repositories["Character"]
    self.private.tableName = CNF.databaseTables["characters"]

    -- Id
    if not CNF.methods.ValidateType(id, "number") or id < 1 then
        error("Character:constructor invalid id input.")
    end

    self.private.id = id

    -- playerId
    if not CNF.methods.ValidateType(playerId, "number") or playerId < 1 or CNF.repositories["Player"]:getPlayerById(playerId) == false then
        error("Character:constructor invalid playerId input.")
    end

    self.private.playerId = playerId

    -- data
    if not CNF.methods.ValidateType(data, "table") then
        error("Character:constructor invalid data input.")
    end

    self.private.data = data

    -- metadata
    if not CNF.methods.ValidateType(metadata, "table") then
        error("Character:constructor invalid metadata input.")
    end

    self.private.metadata = metadata

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
    return CNF.repositories["Player"]:getPlayerById(self.private.playerId)
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
        error("Character:setData character's data is null.")
    end

    local characterDataCopy = lib.table.deepclone(self.private.data)
    characterDataCopy[key] = value

    local affectedRows = MySQL.update.await(tostring("UPDATE `"..self.private.tableName.."` SET data = @data WHERE id = @id"), {
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

function Character:getAllMetadata() -- table
    return self.private.metdata
end

-- key : string
function Character:getMetadata(key) -- any
    if not CNF.methods.ValidateType(key, "string") or string.len(key) == 0 then
        error("Character:getMetadata invalid key input.")
    end

    return self.private.metadata[key]
end

-- key : string
-- value : any
function Character:setMetadata(key, value) -- bool
    if not CNF.methods.ValidateType(key, "string") or string.len(key) == 0 then
        error("Character:setMetadata invalid key input.")
    end

    if self.private.metadata == nil then
        error("Character:setMetadata character's metadata is null.")
    end

    local characterMetadataCopy = lib.table.deepclone(self.private.metadata)
    characterMetadataCopy[key] = value

    local affectedRows = MySQL.update.await(tostring("UPDATE `"..self.private.tableName.."` SET metadata = @metadata WHERE id = @id"), {
        ["metadata"] = json.encode(characterMetadataCopy),
        ["id"] = self:getId(),
    })
    
    -- Update object
    if affectedRows > 0 then
        self.private.metadata[key] = value
        self.private.metadata[key] = value

        -- Events
        TriggerEvent("cnf:entity:character:onMetadataUpdated", self:getId(), key, value)
        TriggerClientEvent("cnf:entity:character:onMetadataUpdate", -1, self:getId(), key, value)

        return true
    else
        CNF.methods.Log("error", "Character:setMetadata SQL query failed.")
        return false
    end
end

function Character:getSkin() -- table
    return self.private.skin
end

function Character:setSkin(skin) -- bool
    if not CNF.methods.ValidateType(skin, "table") then
        error("Character:setSkin invalid skin input.")
    end

    if self.private.skin == nil then
        error("Character:setSkin character's skin is null.")
    end

    local affectedRows = MySQL.update.await(tostring("UPDATE `"..self.private.tableName.."` SET skin = @skin WHERE id = @id"), {
        ["skin"] = json.encode(skin),
        ["id"] = self:getId(),
    })

    -- Update object
    if affectedRows > 0 then
        self.private.skin = skin
        return true
    else
        CNF.methods.Log("error", "Character:setSkin SQL query failed.")
        return false
    end
end

return Character