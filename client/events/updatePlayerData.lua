RegisterNetEvent("CNFramework:client:updatePlayerData", function(data)
    if not CNF.methods.ValidateType(data, "table") then
        error("CNFramework:client:updatePlayerData invalid value input.")
    end

    ClientCache.playerData = data
end)