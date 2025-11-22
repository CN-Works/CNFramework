local Log = function(logType, message)
    if ConfigServer.logs.console == false or logType == nil or CNF.Enums.logsTypes[logType] == nil or message == nil or string.len(message) == 0 then
        return false
    end

    local newLog = {
        type = logType,
        message = message,
        timestamp = os.time,
        readableTime = string.format("%sh%s:%s:%03d", os.date("%H"), os.date("%M"), os.date("%S"), GetGameTimer() % 1000),
    }

    -- output : 22h12:29:794
    local logTime = string.format("%sh%s:%s:%03d", os.date("%H"), os.date("%M"), os.date("%S"), GetGameTimer() % 1000)

    print(CNF.Enums.logsTypes[logType].titleColor.."["..CNF.Enums.logsTypes[logType].title.."] "..logTime.." : "..CNF.Enums.logsTypes[logType].textColor..message)

    table.insert(ServerCache.logs, newLog)
end

return Log