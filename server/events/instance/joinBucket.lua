AddEventHandler("CNFramework:server:instance:joinBucket", function(serverId, bucket)
    if not CNF.methods.IsType(serverId, "number") then
        error("CNFramework:server:instance:joinBucket : serverId is not correct.")
    end

    if not CNF.methods.IsType(bucket, "number") then
        error("CNFramework:server:instance:joinBucket : bucket is not correct.")
    end

    local networkPlayer = CNF.repositories["NetworkPlayer"]:getNetworkPlayerByServerId(serverId)

    if not CNF.methods.InstanceOf(networkPlayer, CNF.classes["NetworkPlayer"]) then
        error("CNFramework:server:instance:joinBucket : networkPlayer is not correct.")
    end

    local currentBucket = GetPlayerRoutingBucket(serverId)

    -- Should not happen, it means the input has a mistake
    if currentBucket ~= bucket then
        error("CNFramework:server:instance:joinBucket : currentBucket and bucket are not the same.")
    end
end)