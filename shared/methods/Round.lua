local function Round(num, dec)
    if num == nil or type(num) ~= "number" or dec == nil or type(dec) ~= "number" then
        return
    end

    local mult = 10^(dec or 0)
    return math.floor(num * mult + 0.5) / mult
end

return Round