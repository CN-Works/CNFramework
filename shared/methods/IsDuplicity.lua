local function IsDuplicity()
    local result = IsDuplicityVersion()

    if result == 1 then
        return true
    else
        return false
    end
end


return IsDuplicity