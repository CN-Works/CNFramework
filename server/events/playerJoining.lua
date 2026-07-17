AddEventHandler("playerJoining", function()
    local src = source

    local discordId = CNF.methods.GetDiscordIdByServerId(src)

    if not CNF.methods.IsType(discordId, "string") or string.len(discordId) == 0 or string.len(discordId) > 19 then
        DropPlayer(src, "There was an issue with your discord account (not found).")
        return
    end

    -- Authentification
    local player = CNF.repositories["Player"]:getPlayerByDiscordId(discordId)

    if not CNF.methods.InstanceOf(player, CNF.classes["Player"]) then
        CNF.methods.Log("info", tostring("New player joining. ("..discordId..") player's object not found."))
        DropPlayer(src, "There was an issue while syncing to your discord account (not found).")
        return
    end
    
    CNF.methods.Log("info", tostring("["..player:getId().."] "..player:getName().." is connected."))

    TriggerClientEvent("CNFramework:client:loadPlayerClient", src)
end)