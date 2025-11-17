AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local src = source

    -- Pauses the connection
    deferrals.defer()

    Citizen.Wait(2000)

    deferrals.update("Searching your data.")

    local discordId = GetPlayerIdentifierByType(src, "discord")
    local ip = GetPlayerIdentifierByType(src, "ip")

    if not discordId then
        deferrals.done("Discord is required to join the server.")
    end

    print(discordId .. " is joining the server.\nip : " .. ip)

    -- Authorized
    deferrals.done()
end)