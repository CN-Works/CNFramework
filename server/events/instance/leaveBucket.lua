AddEventHandler("CNFramework:server:instance:leaveBucket", function(serverId, bucket)
    if not CNF.methods.IsType(serverId, "number") then
        error("CNFramework:server:instance:leaveBucket : serverId is not correct.")
    end

    if not CNF.methods.IsType(bucket, "number") then
        error("CNFramework:server:instance:leaveBucket : bucket is not correct.")
    end

    local networkPlayer = CNF.repositories["NetworkPlayer"]:getNetworkPlayerByServerId(serverId)

    if not CNF.methods.InstanceOf(networkPlayer, CNF.classes["NetworkPlayer"]) then
        error("CNFramework:server:instance:leaveBucket : networkPlayer is not correct.")
    end
end)