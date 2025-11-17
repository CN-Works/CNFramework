local Enums = require "shared.Enums"

lib.addCommand("showlogs", {
    help = "Affiches les logs du serveurs.",
    params = {},
}, function(source, args, raw)
    if source ~= 0 then
        CNF.Log("error", "Can't show logs to a player.")
    end

    local logs = lib.table.deepclone(ServerCache.logs)

    for key, data in pairs(logs) do
        print("------------\n"..Enums.logsTypes[data.type].titleColor..""..Enums.logsTypes[data.type].title.." at "..data.readableTime.."\n^7"..data.message)
    end
end)