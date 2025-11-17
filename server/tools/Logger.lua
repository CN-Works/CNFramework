local Enums = require "shared.Enums"

local Log = function(logType, message)
    if ConfigServer.logs.console == false or logType == nil or Enums.logsTypes[logType] == nil or message == nil or string.len(message) == 0 then
        return false
    end

    local newLog = {
        type = logType,
        message = message,
        timestamp = os.time,
        readableTime = tostring(os.date("%d/%m/%Y %Hh%M")..":"..os.date("%S")..":"..(GetGameTimer() % 1000)),
    }

    local logTime = string.format("%sh%s:%s:%03d", os.date("%H"), os.date("%M"), os.date("%S"), GetGameTimer() % 1000)

    print(Enums.logsTypes[logType].titleColor.."["..Enums.logsTypes[logType].title.."] "..logTime.." : "..Enums.logsTypes[logType].textColor..message)

    table.insert(ServerCache.logs, newLog)
end

return Log