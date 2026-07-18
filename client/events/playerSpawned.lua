AddEventHandler("playerSpawned", function()
    SetCanAttackFriendly(PlayerPedId(), true, false)
    NetworkSetFriendlyFireOption(true)
    
    -- Has just loaded into the server
    -- it means the client player data is not loaded yet
    if ClientCache.playerData == nil then
        TriggerServerEvent("CNFramework:server:playerClientHasLoaded")
    end

    CNF.methods.Log("info", "CNFramework : player's ped has spawned.")
end)