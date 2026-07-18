
RegisterCommand("players", function(source, args, rawCommand)
    if source ~= 0 then
        return
    end

    local players = GetActivePlayers()

    if #players == 0 then
        print("There's no player connected at this time.")
        return
    end

    for key, serverId in pairs(players) do
        local currentPlayer = CNF.repositories["NetworkPlayer"]:getNetworkPlayerByServerId(serverId):getPlayer()

        print("["..serverId.."] "..currentPlayer:getName().." - n°"..currentPlayer:getId())
    end
end)