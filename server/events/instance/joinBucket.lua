AddEventHandler("backend:instance:joinBucket", function(serverId, bucket)
    if not CNF.methods.IsType(serverId, "number") then
        error("backend:instance:joinBucket : serverId is not correct.")
    end

    if not CNF.methods.IsType(bucket, "number") then
        error("backend:instance:joinBucket : bucket is not correct.")
    end

    local networkPlayer = CNF.repositories["NetworkPlayer"]:getNetworkPlayerByServerId(serverId)

    if not CNF.methods.InstanceOf(networkPlayer, CNF.classes["NetworkPlayer"]) then
        error("backend:instance:joinBucket : networkPlayer is not correct.")
    end

    local currentBucket = GetPlayerRoutingBucket(serverId)

    -- Should not happen, it means the input has a mistake
    if currentBucket ~= bucket then
        error("backend:instance:joinBucket : currentBucket and bucket are not the same.")
    end
end)