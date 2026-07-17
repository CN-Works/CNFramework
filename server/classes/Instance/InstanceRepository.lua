local InstanceRepository = lib.class("InstanceRepository")

function InstanceRepository:constructor()
    -- key : id - string
    -- value : Instance - Instance
    self.private.instances = {}
    self.private.instanceCount = 0
    self.private.init = false
end

function InstanceRepository:getInstances()
    return self.private.instances
end

-- id : string
function InstanceRepository:getInstanceById(id) -- Instance / nil
    if not CNF.methods.IsType(id, "string") then
        CNF.methods.Log("error", "InstanceRepository:getInstanceById invalid id input.")
        return
    end

    return self.private.instances[id]
end

-- bucket : int
function InstanceRepository:getInstanceByBucket(bucket) -- Instance / nil
    if not CNF.methods.IsType(bucket, "number") or bucket < 1 then
        CNF.methods.Log("error", "InstanceRepository:getInstanceByBucket invalid bucket input.")
        return
    end

    for id, instance in pairs(self.private.instances) do
        if instance:getBucket() == bucket then
            return instance
        end
    end
end

-- id : string
function InstanceRepository:createInstance(id) -- Instance / nil
    if not CNF.methods.IsType(id, "string") then
        CNF.methods.Log("error", "InstanceRepository:createInstance invalid id input.")
        return
    end

    -- already exists ?
    if self.private.instances[id] ~= nil then
        CNF.methods.Log("error", "InstanceRepository:createInstance instance already exists.")
        return
    end

    -- routing bucket generation
    local bucket = self.private.instanceCount + 1
    self.private.instanceCount = bucket

    -- new instance
    local newInstance = CNF.classes["Instance"]:new(id, bucket)

    if not CNF.methods.InstanceOf(newInstance, CNF.classes["Instance"]) then
        CNF.methods.Log("error", "InstanceRepository:createInstance invalid instance type.")
        return
    end

    self.private.instances[id] = newInstance

    return self.private.instances[id]
end

function InstanceRepository:init()
    self.private.init = true
    return self.private.init
end

return InstanceRepository