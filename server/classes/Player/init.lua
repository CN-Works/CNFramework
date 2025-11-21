local Enums = require "shared.Enums"
local PlayerRepository = require "server.classes.Player.PlayerRepository"

Citizen.CreateThread(function()
    while MySQL.isReady() == false do
        Wait(0)
    end
    
    local response = MySQL.rawExecute.await(tostring("SELECT * FROM ".. ConfigServer.sqlTables["players"]))
    
    if response then
        for key, playerData in pairs(response) do
            PlayerRepository[playerData.id] = CNF.classes["Player"]:new(playerData.id, playerData.discord_id, playerData.name, playerData.data, playerData.roles, playerData.last_connection)
        end
    else
        CNF.Log("critical", "Player Init : MySQL query failed.")
    end
end)


