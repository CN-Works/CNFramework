RegisterCommand("showinstances", function(source, args, rawCommand)
    local src = source

    if src ~= 0 then
        return
    end

    local allInstances = CNF.repositories["Instance"]:getInstances()

    for id, instance in pairs(allInstances) do
        print(id.." : "..instance:getBucket())
    end
end)