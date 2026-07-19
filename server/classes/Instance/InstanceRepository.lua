-- Class
local InstanceRepository = lib.class("InstanceRepository")

function InstanceRepository:constructor()
    self.private.init = false
    self.private.nextBucket = 0

    self.private.instances = {}
end

-- key : string
-- parameters : table
function InstanceRepository:createInstance(key, parameters) -- Instance / nil
    if not CNF.methods.IsType(key, "string") or string.len(key) == 0 then
        error("InstanceRepository:createInstance invalid key input.")
    end

    -- Check if instance already exists
    if self.private.instances[key] ~= nil then
        CNF.methods.Log("error", "InstanceRepository:createInstance instance already exists.")
        return
    end

    -- Check parameters
    if not CNF.methods.IsType(parameters, "table") then
        CNF.methods.Log("error", "InstanceRepository:createInstance invalid parameters input.")
        return
    end

    -- Create instance
    local newInstance = CNF.classes["Instance"]:new(self.private.nextBucket, key, parameters)
    self.private.instances[key] = newInstance

    -- update next bucket
    self.private.nextBucket = self.private.nextBucket + 1

    return newInstance
end

-- key : string
-- networkPlayer : NetworkPlayer
function InstanceRepository:joinInstance(networkPlayer, key) -- bool
    if not CNF.methods.IsType(key, "string") or string.len(key) == 0 then
        CNF.methods.Log("error", "InstanceRepository:joinInstance invalid key input.")
        return false
    end

    -- Check if instance exists
    if self.private.instances[key] == nil then
        CNF.methods.Log("error", "InstanceRepository:joinInstance instance does not exist.")
        return false
    end

    -- is network player valid
    if not CNF.methods.InstanceOf(networkPlayer, CNF.classes["NetworkPlayer"]) then
        CNF.methods.Log("error", "InstanceRepository:joinInstance invalid networkPlayer input.")
        return false
    end

    -- is network player already in this instance
    if self.private.instances[key]:hasNetworkPlayer(networkPlayer) then
        CNF.methods.Log("error", "InstanceRepository:joinInstance networkPlayer already in that instance.")
        return false
    end

    -- is network player already in another instance
    local currentBucket = GetPlayerRoutingBucket(networkPlayer:getServerId())

    for instanceKey, instance in pairs(self.private.instances) do
        if instance:hasNetworkPlayer(networkPlayer) or instance:getBucket() == currentBucket then
            instance:removeNetworkPlayer(networkPlayer)
        end
    end

    -- Join instance
    local instance = self.private.instances[key]
    SetPlayerRoutingBucket(networkPlayer:getServerId(), instance:getBucket())

    -- Add network player to instance
    instance:addNetworkPlayer(networkPlayer)

    -- Events
    TriggerEvent("CNFramework:server:instance:joinedInstance", networkPlayer:getServerId(), instance:getKey())
    TriggerClientEvent("CNFramework:client:instance:joinedInstance", networkPlayer:getServerId(), instance:getKey())

    return true
end

-- Join or create instance (then join it)
-- networkPlayer : NetworkPlayer
-- key : string
-- parameters : table
function InstanceRepository:joinOrCreateInstance(networkPlayer, key, parameters) -- bool
    if not CNF.methods.IsType(key, "string") or string.len(key) == 0 then
        CNF.methods.Log("error", "InstanceRepository:joinOrCreateInstance invalid key input.")
        return false
    end

    -- Check if instance exists
    if self.private.instances[key] == nil then
        local instance = self:createInstance(key, parameters)
    
        if not instance then
            CNF.methods.Log("error", "InstanceRepository:joinOrCreateInstance failed to create instance.")
            return false
        end
    end
    
    return self:joinInstance(networkPlayer, key)
end

function InstanceRepository:init()
    -- Setup default instance
    local defaultInstance = self:createInstance("default", {
        lockdownMode = "inactive",
        population = true,
    })

    self.private.init = true

    return self.private.init
end

return InstanceRepository