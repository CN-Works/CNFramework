AddEventHandler("playerJoining", function()
    local src = source

    local discordId = CNF.methods.GetDiscordIdByServerId(src)

    if not CNF.methods.ValidateType(discordId, "string") or string.len(discordId) == 0 or string.len(discordId) > 19 then
        DropPlayer(src, "There was an issue with your discord account (not found).")
        return
    end

    -- Authentification
    local player = CNF.repositories["Player"]:getPlayerByDiscordId(discordId)

    if CNF.methods.ValidateType(player, CNF.classes["Player"]) then
        player:updateLastConnection()

        print(player:getName()..":"..player:getId().." is connected.")
    else
        CNF.methods.Log("info", "New player joining. ("..discordId..") player's object not found.")
        DropPlayer(src, "There was an issue while syncing to your discord account (not found).")
    end
end)