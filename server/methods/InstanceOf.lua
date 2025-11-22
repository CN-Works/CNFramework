local function InstanceOf(className, object) -- string
    if object == nil or type(object) ~= "table" then
        CNF.Log("error", "InstanceOf invalid object input.")
        return nil
    end

    if className == nil or type(className) ~= "string" or string.len(className) == 0 then
        CNF.Log("error", "InstanceOf invalid className input.")
        return nil
    end

    local objectClassName = object.__name

    -- Object is not an OX Object
    if objectClassName == nil then
        return false
    end

    -- Object is not of the right class
    if objectClassName ~= className then
        return false
    end

    return true
end

return InstanceOf