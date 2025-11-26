Citizen.CreateThread(function()
    while MySQL.isReady() == false do
        Wait(0)
    end
    
    local response = MySQL.rawExecute.await(tostring("SELECT * FROM "..CNF.databaseTables["players"]))
    
    if CNF.methods.ValidateType(response, "table") then
        for key, playerData in pairs(response) do
            CNF.repositories["Player"]:addPlayer(CNF.classes["Player"]:new(playerData.id, playerData.discord_id, playerData.name, json.decode(playerData.data), json.decode(playerData.roles), playerData.last_connection))
        end
    else
        CNF.methods.Log("critical", "Player Init : MySQL query failed.")
    end
end)


