local PlayerRepository = require "server.classes.Player.PlayerRepository"

-- Manager of Player class
local PlayerManager = {
    -- discordId : string
    getPlayerByDiscordId = function(discordId, canBeNewPlayer) -- Player
        if discordId == nil or type(discordId) ~= "string" or string.len(discordId) == 0 then
            CNF.Log("error", "PlayerManager:getPlayerByDiscordId invalid discordId input.")
            return false
        end

        for playerId, player in pairs(PlayerRepository) do
            if discordId == player:getDiscordId() then
                return player
            end
        end

        if canBeNewPlayer == nil or canBeNewPlayer == false then
            CNF.Log("error", "PlayerManager:getPlayerByDiscordId player not found.")
        end
        return false
    end
}

return PlayerManager