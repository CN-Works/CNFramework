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

    -- Player Id
    if not CNF.methods.ValidateType(playerId, "number") or playerId < 1 or playerRepository:getPlayerById(playerId) == false then
        error("Character:constructor invalid playerId input.")
    end

    self.private.playerId = playerId
end

return Character