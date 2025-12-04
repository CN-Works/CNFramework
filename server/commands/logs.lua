local logsTypes = CNF.enums.logsTypes

-- lib.addCommand("logs", {
--     help = "Affiches les logs du serveurs.",
--     params = {},
-- }, function(source, args, raw)
--     if source ~= 0 then
--         print("Can't show logs to a non-admin player.")
--         return
--     end

--     local logs = lib.table.deepclone(ServerCache.logs)

--     if #logs == 0 then
--         print("No logs at this time.")
--         return
--     end

--     for key, data in pairs(logs) do
--         print(logsTypes[data.type].titleColor..""..logsTypes[data.type].title.." at "..data.readableTime.."\n^7"..data.message.."\n")
--     end
-- end)

RegisterCommand("logs", function(source, args, rawCommand)
    local logsList = nil

    if CNF.methods.IsDuplicity() then
        logsList = lib.table.deepclone(ServerCache.logs)
    else
        logsList = lib.table.deepclone(ClientCache.logs)
    end

    print(CNF.methods.DumpTable(logsList))
end)