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

function Repository:createCharacter(playerId, firstName, lastName, gender, dob) -- Character / nil
    -- playerId
    if not CNF.methods.ValidateType(playerId, "number") or playerId < 1 then
        error("CharacterRepository:createCharacter invalid playerId input.")
    end

    -- player with this id exists ?
    local player = CNF.repositories["Player"]:getPlayerById(playerId)

    if player == nil then
        error("CharacterRepository:createCharacter player with this id doesn't exist.")
    end

    local characterData = {
        data = {
            firstName = firstName,
            lastName = lastName,
            gender = gender,
            dob = dob,
        },
        metadata = {
            registrationTime = os.time(),
        },
        skin = {},
    }


        -- New Player
    local id = MySQL.insert.await("INSERT INTO `"..self.private.tableName.."` (player_id, data, metadata, skin) VALUES (@playerId, @data, @metadata, @skin)", {
        ["playerId"] = playerId,
        ["data"] = json.encode(characterData.data),
        ["metadata"] = json.encode(characterData.metadata),
        ["skin"] = json.encode(characterData.skin),
    })

    if id then
        -- Init Character object
        local character = CNF.classes["Character"]:new(id, playerId, characterData.data, characterData.metadata, characterData.skin)
        
        -- Adds the character to the repository
        self:addCharacter(character)
    
        return character
    else
        return false
    end
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

