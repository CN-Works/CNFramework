Citizen.CreateThread(function()
    while MySQL.isReady() == false do
        Wait(0)
    end
    
    local response = MySQL.rawExecute.await(tostring("SELECT * FROM ".. ConfigServer.sqlTables["players"]))
    
    if response then
        for key, playerData in pairs(response) do
            CNF.repositories["Player"]:addPlayer(CNF.classes["Player"]:new(playerData.id, playerData.discord_id, playerData.name, playerData.data, playerData.roles, playerData.last_connection))
        end
    else
        CNF.methods.Log("critical", "Player Init : MySQL query failed.")
    end
end)


