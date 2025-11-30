AddEventHandler("onClientMapStart", function()
    SetCanAttackFriendly(PlayerPedId(), true, false)
    NetworkSetFriendlyFireOption(true)

    -- Has just loaded into the server
    -- it means the client player data is not loaded yet
    if ClientCache.playerData == nil then
        TriggerServerEvent("CNFramework:server:playerClientHasLoaded")
        exports.spawnmanager:setAutoSpawn(true)
        exports.spawnmanager:forceRespawn()
    end
end)