AddEventHandler("playerDropped", function(reason)
    local src = source

    local player = CNF.repositories["Player"]:getPlayerByServerId(src)

    if CNF.methods.ValidateType(player, CNF.classes["Player"]) then
        print(player:getName().." has been disconnected. ("..reason..")")
    else
        print("Player with serverId "..src.."dropped. ("..reason..")")
    end 
end)