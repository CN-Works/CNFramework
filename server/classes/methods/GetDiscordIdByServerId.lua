local function GetDiscordIdByServerId(serverId)
    local fullDiscordId = GetPlayerIdentifierByType(serverId, 'discord')

    if fullDiscordId == nil then
        CNF.Log("error", "GetDiscordIdByServerId discordId not found for server id. ("..serverId..")")
        return false
    end

    local discordId = string.gsub(fullDiscordId, "discord:", "")

    return discordId
end

return GetDiscordIdByServerId