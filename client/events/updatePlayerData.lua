RegisterNetEvent("core:updatePlayerData", function(data)
    print("CNFramework : updating player data.")
    
    if not type(data) == "table" then
        error("core:updatePlayerData invalid value input.")
    end

    ClientCache.playerData = data
end)