AddEventHandler("playerSpawned", function()
    print("CNFramework : player has loaded.")
    
    SetCanAttackFriendly(PlayerPedId(), true, false)
    NetworkSetFriendlyFireOption(true)
end)