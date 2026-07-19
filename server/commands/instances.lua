RegisterCommand("instances", function(source, args, rawCommand)
    local serverId <const> = source

    if serverId ~= 0 then
        CNF.methods.Log("error", "Instance command can only be used from the server.")
        return
    end

    local instances = CNF.repositories["Instance"]:getInstances()
    local count = 0

    for _ in pairs(instances) do
        count = count + 1
    end

    if count == 0 then
        print("No instances created.")
        return
    end

    print("--- Instances ("..count..") ---")

    for key, instance in pairs(instances) do
        local playerCount = #instance:getNetworkPlayers()

        print("[bucket "..instance:getBucket().."] "..key.." | players: "..playerCount)

        for _, networkPlayer in ipairs(instance:getNetworkPlayers()) do
            local player = networkPlayer:getPlayer()

            if CNF.methods.InstanceOf(player, CNF.classes["Player"]) then
                print("  └ [serverId: "..networkPlayer:getServerId().."] "..player:getName().." - "..player:getId())
            else
                print("  └ [serverId: "..networkPlayer:getServerId().."] (unknown)")
            end
        end
    end
end)
