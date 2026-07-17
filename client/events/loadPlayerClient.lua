RegisterNetEvent("core:loadPlayerClient", function()
    print("CNFramework : loading player client.")
    
    local defaultCoords = {x = 1066.0, y = -3188.0, z = 6.0}

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