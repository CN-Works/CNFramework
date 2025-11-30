AddEventHandler("playerSpawned", function()
    CNF.methods.Log("info", "CNFramework : player has loaded.")
    
    SetCanAttackFriendly(PlayerPedId(), true, false)
    NetworkSetFriendlyFireOption(true)
end)