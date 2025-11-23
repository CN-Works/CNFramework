AddEventHandler('playerJoining', function()
    local src = source

    local discordId = CNF.methods.GetDiscordIdByServerId(src)

    if discordId == nil then
        DropPlayer(source, "There was an issue with your discord account (not found).")
        return
    end

    -- Authentification
    local player = CNF.repositories["Player"]:getPlayerByDiscordId(discordId)

    if player then
        player:updateLastConnection()

        print(player:getName().." is connected.")
    else
        CNF.methods.Log("info", "New player joining. ("..discordId..") player's object not found.")
        DropPlayer(source, "There was an issue while syncing to your discord account (not cached).")
    end
end)