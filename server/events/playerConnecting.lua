AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local src = source

    deferrals.defer()
    Citizen.Wait(0)

    deferrals.update("Checking your data...")
    Citizen.Wait(0)

    deferrals.done()
end)
