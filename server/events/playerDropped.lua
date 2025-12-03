AddEventHandler("playerDropped", function(reason)
    local src = source

    local player = CNF.repositories["Player"]:getPlayerByServerId(src)

    if CNF.methods.ValidateType(player, CNF.classes["Player"]) then
        CNF.methods.Log("info", tostring(player:getName().." has been disconnected. ("..reason..")"))
    else
        CNF.methods.Log("info", tostring("Player with serverId "..src.."dropped. ("..reason..")"))
    end 
end)