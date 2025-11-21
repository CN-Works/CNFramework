AddEventHandler('playerJoining', function()
    local src = source

    local discordId = GetPlayerIdentifierByType(src, 'discord')

    if discordId == nil then
        DropPlayer(source, "There was an issue with your discord account (not found).")
        return
    end

    discordId = string.gsub(discordId, "discord:", "")

    -- Authentification
    local player = CNF.repositories["Player"]:getPlayerByDiscordId(discordId)

    if player then
        -- Add player to cache
        CNF.repositories["Player"]:linkPlayerIdAndServerId(player:getId(), src)

        player:updateLastConnection()
    else
        CNF.Log("info", "New player joining. ("..discordId.."), player's object not found.")
        DropPlayer(source, "There was an issue while syncing to your discord account (not cached).")
    end
end)