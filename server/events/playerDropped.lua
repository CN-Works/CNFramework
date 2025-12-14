AddEventHandler("playerDropped", function(reason)
    local src = source

    local player = CNF.repositories["Player"]:getPlayerByServerId(src)

    if not CNF.methods.ValidateType(player, CNF.classes["Player"]) then
        CNF.methods.Log("info", tostring("Player ("..src.." disconnected. ("..reason..")"))
    end
    
    CNF.methods.Log("info", tostring(player:getName().." disconnected. ("..reason..")"))
end)