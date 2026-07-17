AddEventHandler("playerSpawned", function()
    print("CNFramework : player has loaded.")
    
    SetCanAttackFriendly(PlayerPedId(), true, false)
    NetworkSetFriendlyFireOption(true)
    
    DisablePlayerVehicleRewards(ped)
    SetMaxWantedLevel(0)
    for i = 1, 12 do
        EnableDispatchService(i, false)
    end

    -- Has just loaded into the server
    -- it means the client player data is not loaded yet
    if ClientCache.playerData == nil then
        TriggerServerEvent("backend:playerClientHasLoaded")
    end
end)