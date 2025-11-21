local PlayerManager = require "server.classes.Player.PlayerManager"
local PlayerRepository = require "server.classes.Player.PlayerRepository"
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
    local player = PlayerManager.getPlayerByDiscordId(discordId, true)

    if player then
        -- Update last connection
        player:updateLastConnection()
    else
        CNF.Log("info", "New player connecting. ("..discordId..")")

        local timestamp = os.time()

        -- New Player
        local id = MySQL.insert.await("INSERT INTO "..ConfigServer.sqlTables["players"].." (discord_id, last_connection) VALUES (@discordId, @lastConnection)", {
            ["discordId"] = discordId,
            ["lastConnection"] = timestamp,
        })

        if id then
            local newPlayer = CNF.classes["Player"]:new(id, discordId, "Joueur", {"user"}, timestamp)

            -- Adds the player to the repository
            PlayerRepository[id] = newPlayer
        else
            defferals.done("There was an issue during the creation of your account.")
        end
    end

    -- Authorize connection
    deferrals.done()
end)
