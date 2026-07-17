RegisterNetEvent("CNFramework:client:updatePlayerData", function(data)
    print("CNFramework : updating player data.")
    
    if not type(data) == "table" then
        error("CNFramework:client:updatePlayerData invalid value input.")
    end

    ClientCache.playerData = data
end)