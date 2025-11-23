AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local src = source

    deferrals.defer()
    Citizen.Wait(0)

    local discordId = CNF.methods.GetDiscordIdByServerId(src)
    local ip = GetPlayerEndpoint(src)

    if discordId == nil then
        deferrals.done("You don't have a discord account.")
        return
    end

    -- Authentification
    local player = CNF.repositories["Player"]:getPlayerByDiscordId(discordId, true)

    if player then
        -- Update last connection
        player:updateLastConnection()
    else
        CNF.methods.Log("info", "New player connecting. ("..discordId..")")

        local timestamp = os.time()

        -- New Player
        local id = MySQL.insert.await("INSERT INTO "..CNF.databaseTables["players"].." (discord_id, last_connection) VALUES (@discordId, @lastConnection)", {
            ["discordId"] = discordId,
            ["lastConnection"] = timestamp,
        })

        if id then
            local newPlayer = CNF.classes["Player"]:new(id, discordId, "Joueur", {"user"}, timestamp)

            -- Adds the player to the repository
            CNF.repositories["Player"]:addPlayer(newPlayer)
        else
            defferals.done("There was an issue during the creation of your account.")
        end
    end

    -- Authorize connection
    deferrals.done()
end)
