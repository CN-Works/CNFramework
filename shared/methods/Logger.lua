local function Log(logType, message)
    if ConfigServer.logs.console == false or logType == nil or CNF.enums.logsTypes[logType] == nil or message == nil or string.len(message) == 0 then
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

    print(CNF.enums.logsTypes[logType].titleColor.."["..CNF.enums.logsTypes[logType].title.."] "..logTime.." : "..CNF.enums.logsTypes[logType].textColor..message)

    table.insert(ServerCache.logs, newLog)
end

return Log