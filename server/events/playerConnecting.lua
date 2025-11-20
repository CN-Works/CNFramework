local PlayerManager = require "server.classes.Player.PlayerManager"
local CachedPlayers = require "server.classes.Player.CachedPlayers"

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

    discordId = string.gsub(discordId, "discord:", "")

    -- Authentification
    local player = PlayerManager.getPlayerByDiscordId(discordId)

    if player then
        -- Update last connection
        player:updateLastConnection()
    else
        print("new player connecting with discord id : " .. discordId)

            -- New Player
        local id = MySQL.insert.await("INSERT INTO "..CNF.Enums.sqlTables["players"].." (discord_id, name, last_connection) VALUES (@discordId, @name, @timestamp)", {
            ["discordId"] = discordId,
            ["name"] = "Joueur",
            ["timestamp"] = os.time(),
        })
    end

    -- Authorize connection
    deferrals.done()
end)
