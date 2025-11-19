local Enums = require "shared.Enums"

Citizen.CreateThread(function()
    while MySQL.isReady() == false do
        Wait(0)
    end

    print(tostring("SELECT * FROM ".. Enums.sqlTables["players"] .." "))

    local response = MySQL.rawExecute.await(tostring("SELECT * FROM ".. Enums.sqlTables["players"] ..""), {})

    if reponse then
        for key, playerData in pairs(response) do
            Citizen.CreateThread(function()
                print("loaded player :"..playerData.id)
            end)
        end
    else
        CNF.Log("critical", "Player Init : MySQL query failed.")
    end
end)