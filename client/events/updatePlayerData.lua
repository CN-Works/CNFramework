RegisterNetEvent("CNFramework:client:updatePlayerData", function(data)
    if not type(data) == "table" then
        error("CNFramework:client:updatePlayerData invalid value input.")
    end
    
    ClientCache.playerData = data

    CNF.methods.Log("success", "CNFramework : player data updated.")
end)