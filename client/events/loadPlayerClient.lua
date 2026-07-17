RegisterNetEvent("CNFramework:client:loadPlayerClient", function()
    print("CNFramework : loading player client.")
    
    local defaultCoords = {x = -676.0, y = 485.0, z = 110.0}

    exports['spawnmanager']:spawnPlayer({
        model = "ig_sol",
        x = defaultCoords.x,
        y = defaultCoords.y,
        z = defaultCoords.z,
        heading = 0.0,
        skipFade = true,
    }, function(spawn)
        ShutdownLoadingScreenNui()

        SetCanAttackFriendly(PlayerPedId(), true, false)
        NetworkSetFriendlyFireOption(true)
        DisplayRadar(false)

        exports["spawnmanager"]:setAutoSpawn(false)
    end)

    exports["spawnmanager"]:setAutoSpawn(false)
end)