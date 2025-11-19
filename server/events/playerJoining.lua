local PlayerManager = require "server.classes.Player.PlayerManager"
local CachedPlayers = require "server.classes.Player.CachedPlayers"

AddEventHandler('playerJoining', function()
    local src = source

    local discordId = GetPlayerIdentifierByType(src, 'discord')

    if discordId == nil then
        DropPlayer(source, "There was an issue while loading your discord account.")
        return
    end

    discordId = string.gsub(discordId, "discord:", "")

    -- Authentification
    local player = PlayerManager.getPlayerByDiscordId(discordId)

    if player then
        -- Add player to cache
        CachedPlayers[src] = player
    end
end)