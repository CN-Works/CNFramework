-- Class
local Instance = lib.class("Instance")

function Instance:constructor(bucket, key, parameters)
    -- Bucket
    if not CNF.methods.IsType(bucket, "number") or bucket < 0 then
        error("Instance:constructor invalid bucket input.")
    end

    self.private.bucket = bucket

    -- Key
    if not CNF.methods.IsType(key, "string") or string.len(key) == 0 then
        error("Instance:constructor invalid key input.")
    end

    self.private.key = key

    -- Parameters
    if not CNF.methods.IsType(parameters, "table") then
        parameters = {
            lockdownMode = "inactive",
            population = false,
        }
    end 

    self.private.parameters = parameters

    -- Applying parameters
    SetRoutingBucketEntityLockdownMode(self.private.bucket, self.private.parameters.lockdownMode)
    SetRoutingBucketPopulationEnabled(self.private.bucket, self.private.parameters.population)

    -- networkPlayers
    self.private.networkPlayers = {}
end

function Instance:getBucket() -- int
    return self.private.bucket
end

function Instance:getKey() -- string
    return self.private.key
end

function Instance:getParameters() -- table
    return self.private.parameters
end

function Instance:getNetworkPlayers() -- table (of NetworkPlayer)
    return self.private.networkPlayers
end

function Instance:hasNetworkPlayer(networkPlayer) -- bool
    if not CNF.methods.InstanceOf(networkPlayer, CNF.classes["NetworkPlayer"]) then
        return false
    end

    for index, currentNetworkPlayer in ipairs(self.private.networkPlayers) do
        if currentNetworkPlayer:getServerId() == networkPlayer:getServerId() then
            return true
        end
    end

    return false
end

function Instance:addNetworkPlayer(networkPlayer) -- bool
    if not CNF.methods.InstanceOf(networkPlayer, CNF.classes["NetworkPlayer"]) then
        return false
    end

    -- Just in case it happens
    if self:hasNetworkPlayer(networkPlayer) then
        CNF.methods.Log("error", "Instance:addNetworkPlayer networkPlayer already in that instance.")
        return false
    end

    table.insert(self.private.networkPlayers, networkPlayer)

    return true
end

function Instance:removeNetworkPlayer(networkPlayer) -- bool
    if not CNF.methods.InstanceOf(networkPlayer, CNF.classes["NetworkPlayer"]) then
        return false
    end

    if not self:hasNetworkPlayer(networkPlayer) then
        CNF.methods.Log("error", "Instance:removeNetworkPlayer networkPlayer is not in that instance.")
        return false
    end

    for index, currentNetworkPlayer in ipairs(self.private.networkPlayers) do
        if currentNetworkPlayer:getServerId() == networkPlayer:getServerId() then
            table.remove(self.private.networkPlayers, index)
            return true
        end
    end

    return false
end

return Instance