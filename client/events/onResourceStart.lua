AddEventHandler("onResourceStart", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end

    SetCanAttackFriendly(PlayerPedId(), true, false)
    NetworkSetFriendlyFireOption(true)

    -- Framework has been restarted so it simulate a onClientMapStart event to avoid bugs
    -- playerData is nil at this point (because of restart)
    TriggerServerEvent("CNFramework:server:playerClientHasLoaded")
    exports.spawnmanager:setAutoSpawn(true)
    exports.spawnmanager:forceRespawn()
end)