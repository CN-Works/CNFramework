AddEventHandler("playerDropped", function(reason)
    local src <const> = source

    local networkPlayer = CNF.repositories["NetworkPlayer"]:getNetworkPlayerByServerId(src)

    if not CNF.methods.InstanceOf(networkPlayer, CNF.classes["NetworkPlayer"]) then
        CNF.methods.Log("error", tostring("CNFramework:server:playerDropped player not found. (serverId: "..src..")"))
        return
    end
    
    local player = networkPlayer:getPlayer()

    if not CNF.methods.InstanceOf(player, CNF.classes["Player"]) then
        CNF.methods.Log("info", tostring("Player (serverId: "..src..") disconnected. ("..reason..")"))
        return
    end
    
    CNF.methods.Log("info", tostring(player:getName().." disconnected. ("..reason..")"))

    -- Remove player from repository
    CNF.repositories["NetworkPlayer"]:removeNetworkPlayerByServerId(src)

    TriggerEvent("CNFramework:server:playerDropped", src, player:getId(), reason)
end)