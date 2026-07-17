local Instance = lib.class("Instance")

-- id : string
function Instance:constructor(id, bucket)
    if not CNF.methods.IsType(id, "string") then
        error("Instance:constructor invalid id input.")
    end

    if not CNF.methods.IsType(bucket, "number") or bucket < 1 then
        error("Instance:constructor invalid bucket input.")
    end

    self.private.id = id
    self.private.bucket = bucket

    SetRoutingBucketPopulationEnabled(bucket, false)
    SetRoutingBucketEntityLockdownMode(bucket, "strict")
end

function Instance:getId() -- int
    return self.private.id
end

function Instance:getBucket() -- int
    return self.private.bucket
end

return Instance