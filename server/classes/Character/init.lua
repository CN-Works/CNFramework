local databaseTables = require "server.databaseTables"

Citizen.CreateThread(function()
    while MySQL.isReady() == false do
        Wait(0)
    end

    local response = MySQL.rawExecute.await(tostring("SELECT * FROM `"..databaseTables["characters"].."`"))

    print(CNF.methods.DumpTable(response))
    
    if CNF.methods.ValidateType(response, "table") then
        for key, characterData in pairs(response) do
            CNF.repositories["Character"]:addCharacter(CNF.classes["Character"]:new(characterData.id, characterData.player_id, json.decode(characterData.data), json.decode(characterData.metadata), json.decode(characterData.skin)))
        end
    else
        CNF.methods.Log("critical", "Character Init : MySQL query failed.")
    end
end)