AddEventHandler('playerDropped', function(reason)
    local src = source

    local player = CNF.repositories["Player"]:getPlayerByServerId(src)

    print(player:getName().." has been disconnected. ("..reason..")")
end)