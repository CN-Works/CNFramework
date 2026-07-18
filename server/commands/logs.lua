local logsTypes = CNF.enums.logsTypes

RegisterCommand("logs", function(source, args, rawCommand)
    local src <const> = source

    if src ~= 0 then
        return
    end
    
    local logsList = nil

    logsList = lib.table.deepclone(ServerCache.logs)

    for k, v in pairs(logsList) do
        if k ~= 1 then
            print("---------------------------")
        end
        print(logsTypes[v.type].titleColor .. "[".. logsTypes[v.type].title .. "] " .. v.readableTime .. " : " .. logsTypes[v.type].textColor .. v.message .. "")
    end
end)