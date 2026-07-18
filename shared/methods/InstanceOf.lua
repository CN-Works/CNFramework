local function InstanceOf(object, class) -- bool
    if type(object) ~= "table" or type(class) ~= "table" then
        return false
    end

    if object.instanceOf == nil then
        return false
    end

    return object:instanceOf(class)
end

return InstanceOf