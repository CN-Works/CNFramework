AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local src = source

    deferrals.defer()
    Citizen.Wait(0)

    local discordId = GetPlayerIdentifierByType(src, 'discord')
    local ip = GetPlayerEndpoint(src)

    if discordId == nil then
        deferrals.done("You don't have a discord account.")
        return
    end

    -- Authentification
    -- Todo

    -- New Player
    -- Todo

    -- Authorize connection
    deferrals.done()
end)
