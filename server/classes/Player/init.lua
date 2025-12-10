local databaseTables = require "server.databaseTables"

Citizen.CreateThread(function()
    while MySQL.isReady() == false do
        Wait(0)
    end
    
    local response = MySQL.rawExecute.await(tostring("SELECT * FROM `"..databaseTables["players"].."`"))
    
    if CNF.methods.ValidateType(response, "table") then
        for key, value in pairs(response) do
            CNF.repository["Player"]:addPlayer(CNF.classes["Player"]:new(value.id, value.discord_id, value.name, json.decode(value.data), json.decode(value.roles)))
        end

        CNF.methods.Log("orm", tostring(#response.." players loaded."))
    else
        CNF.methods.Log("critical", "Player Init : MySQL query failed.")
    end
end)


