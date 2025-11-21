lib.addCommand("players", {
    help = "Shows all connected players.",
    params = {},
}, function(source, args, raw)
    if source ~= 0 then
        print("Can't show players to a non-admin player.")
        return
    end

    local players = GetActivePlayers()

    if #players == 0 then
        print("There's no player connected at this time.")
        return
    end

    for key, serverId in pairs(players) do
        local currentPlayer = CNF.repositories["Player"]:getPlayerByServerId(serverId)

        print(serverId.." - "..currentPlayer:getName())
    end
end)