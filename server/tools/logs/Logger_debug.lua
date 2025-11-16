local Enums = require "shared.Enums"

Debug = function(debugType, message)
    if ConfigServer.logs.debug == false or debugType == nil or Enums.logsTypes[debugType] == nil or message == nil or string.len(message) == 0 then
        return false
    end

    local newLog = {
        type = debugType,
        message = message,
        timestamp = os.time,
        readableTime = tostring(os.date("%d/%m/%Y %Hh%M")..":"..os.date("%S")..":"..(GetGameTimer() % 1000)),
    }

    local logTime = string.format("%sh%s:%s:%03d", os.date("%H"), os.date("%M"), os.date("%S"), GetGameTimer() % 1000)

    print(Enums.logsTypes[debugType].titleColor.."["..Enums.logsTypes[debugType].title.."] "..logTime.." : "..Enums.logsTypes[debugType].textColor..message)

    table.insert(ServerCache.logs, newLog)
end

return Debug