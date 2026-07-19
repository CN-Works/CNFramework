
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
        local currentNetworkPlayer = CNF.repositories["NetworkPlayer"]:getNetworkPlayerByServerId(serverId)

        if not CNF.methods.InstanceOf(currentNetworkPlayer, CNF.classes["NetworkPlayer"]) then
            print("["..serverId.."] Player not authenticated yet.")
        else
            local currentPlayer = currentNetworkPlayer:getPlayer()

            if not CNF.methods.InstanceOf(currentPlayer, CNF.classes["Player"]) then
                print("["..serverId.."] Player not registered yet.")
            else
                print("["..serverId.."] "..currentPlayer:getName().." - n°"..currentPlayer:getId())
            end
        end
    end
end)