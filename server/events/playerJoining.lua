AddEventHandler("playerJoining", function()
    local src = source

    local discordId = CNF.methods.GetDiscordIdByServerId(src)

    if not CNF.methods.ValidateType(discordId, "string") or string.len(discordId) == 0 or string.len(discordId) > 19 then
        DropPlayer(src, "There was an issue with your discord account (not found).")
        return
    end

    -- Authentification
    local player = CNF.repositories["Player"]:getPlayerByDiscordId(discordId)

    if not CNF.methods.ValidateType(player, CNF.classes["Player"]) then
        CNF.methods.Log("info", tostring("New player joining. ("..discordId..") player's object not found."))
        DropPlayer(src, "There was an issue while syncing to your discord account (not found).")
    end
    
    CNF.methods.Log("info", tostring(player:getName()..":"..player:getId().." is connected."))
end)