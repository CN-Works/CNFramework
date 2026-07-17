RegisterCommand("leaveinstance", function(source, args, rawCommand)
    local src = source

    if src == 0 then
        print("You can't execute this command from the server console.")
        return
    end

    local networkPlayer = CNF.repositories["NetworkPlayer"]:getNetworkPlayerByServerId(src)

    if not CNF.methods.InstanceOf(networkPlayer, CNF.classes["NetworkPlayer"]) then
        error("You're not registered on the server as a player (contact the server owner).")
    end

    local currentBucket = GetPlayerRoutingBucket(src)

    if currentBucket ~= 0 then
        SetPlayerRoutingBucket(src, 0)
        Player(src).state:set("instance", nil, true)

        TriggerEvent("CNFramework:server:instance:leaveBucket", src, currentBucket)
    else
        -- Player's not in a bucket
    end
end)