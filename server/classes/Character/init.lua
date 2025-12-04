local CharacterRepository = require "server.classes.Character.CharacterRepository"
local CharacterClass = require "server.classes.Character.Character"
local databaseTables = require "server.databaseTables"

Citizen.CreateThread(function()
    while MySQL.isReady() == false do
        Wait(0)
    end

    local response = MySQL.rawExecute.await(tostring("SELECT * FROM `"..databaseTables["characters"].."`"))
    
    if CNF.methods.ValidateType(response, "table") then
        for key, value in pairs(response) do
            CharacterRepository:addCharacter(CharacterClass:new(value.id, value.player_id, json.decode(value.data), json.decode(value.metadata), json.decode(value.skin)))
        end

        CNF.methods.Log("orm", tostring(#response.." characters loaded."))
    else
        CNF.methods.Log("critical", "Character Init : MySQL query failed.")
    end
end)