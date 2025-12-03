local Repository = lib.class("CharacterRepository")
local databaseTables = require "server.databaseTables"

function Repository:constructor()
    -- key : int (player id)
    self.private.characters = {}
    self.private.tableName = databaseTables["characters"]
end

function Repository:getCharacters() -- table
    return self.private.characters
end

function Repository:createCharacter(playerId, data, metadata, skin) -- Character / false
end

-- characterObject : Player
function Repository:addCharacter(characterObject) -- bool
    if not CNF.methods.ValidateType(characterObject, CNF.classes["Character"]) then
        error("CharacterRepository:addCharacter invalid characterObject input.")
    end

    self.private.characters[characterObject:getId()] = characterObject

    return true
end

function Repository:getCharacterById(id) -- Character / nil
    if not CNF.methods.ValidateType(id, "number") or id < 1 then
        error("CharacterRepository:getCharacterById invalid id input.")
    end

    return self.private.characters[id]
end

local CharacterRepository = Repository:new()

return CharacterRepository

