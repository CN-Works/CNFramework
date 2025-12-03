AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local src = source

    deferrals.defer()
    Citizen.Wait(0)

    local discordId = CNF.methods.GetDiscordIdByServerId(src)
    local ip = GetPlayerEndpoint(src)

    if not CNF.methods.ValidateType(discordId, "string") or string.len(discordId) == 0 or string.len(discordId) > 19 then
        deferrals.done("You don't have a discord account.")
        CNF.methods.Log("info", tostring("Player '"..name.."' tried to connect without a discord account."))
        return
    end

    -- Authentification
    local player = CNF.repositories["Player"]:getPlayerByDiscordId(discordId, true)

    if player == false then
        local newPlayerObject = CNF.repositories["Player"]:createPlayer(discordId, name)
        
        -- if an issue occured during the creation of the player
        if newPlayerObject == false or not CNF.methods.ValidateType(newPlayerObject, CNF.classes["Player"]) then
            deferrals.done("There was an issue during the creation of your account.")
            return
        end

        CNF.methods.Log("info", tostring("New player registered. ("..newPlayerObject:getId()..")"))
    elseif CNF.methods.ValidateType(player, CNF.classes["Player"]) then
        -- Do something if needed
    else
        deferrals.done("There was an issue during the creation of your account. (not found & issues when on playerConnection)")
        return
    end

    -- Authorize connection
    deferrals.done()
end)
