local logsTypes = CNF.enums.logsTypes

RegisterCommand("logs", function(source, args, rawCommand)
    local logsList = nil

    if CNF.methods.IsDuplicity() then
        logsList = lib.table.deepclone(ServerCache.logs)
    else
        logsList = lib.table.deepclone(ClientCache.logs)
    end

    for k, v in pairs(logsList) do
        if k ~= 1 then
            print("---------------------------")
        end
        print(logsTypes[v.type].titleColor .. "[".. logsTypes[v.type].title .. "] " .. v.readableTime .. " : " .. logsTypes[v.type].textColor .. v.message .. "")
    end
end)