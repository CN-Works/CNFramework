-- object : object
-- expected : string / table
local function ValidateType(object, expected) -- bool
    if type(expected) == "string" then
        return type(object) == expected
    elseif type(expected) == "table" and object.instanceOf then
        return object:instanceOf(expected)
    else
        error("ValidateType: Invalid expected type")
    end
end

return ValidateType