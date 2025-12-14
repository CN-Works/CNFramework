-- serverId : int
local function GetDiscordIdByServerId(serverId) -- string / nil
    local fullDiscordId = GetPlayerIdentifierByType(serverId, 'discord')

    if fullDiscordId == nil then
        CNF.methods.Log("error", "GetDiscordIdByServerId discordId not found for server id. ("..serverId..")")
        return
    end

    local discordId = string.gsub(fullDiscordId, "discord:", "")

    return discordId
end

return GetDiscordIdByServerId