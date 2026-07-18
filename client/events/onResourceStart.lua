-- Triggered when you restart the resource, primarily used in for dev purposes.
AddEventHandler("onResourceStart", function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end
    
    SetCanAttackFriendly(PlayerPedId(), true, false)
    NetworkSetFriendlyFireOption(true)
    
    -- Has just loaded into the server
    -- it means the client player data is not loaded yet
    if ClientCache.playerData == nil then
        TriggerServerEvent("CNFramework:server:playerClientHasLoaded")
    end

    CNF.methods.Log("success", "CNFramework : resource started.")
end)