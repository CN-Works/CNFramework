local Enums = require "shared.Enums"
local logTypes = Enums.logsTypes

local function Log(logType, message)
    if not CNF.methods.ValidateType(logType, "string") or logTypes[logType] == nil then
        error("Log invalid logType input.")
    end

    -- Timestamp server/client side
    local timestamp = nil

    if CNF.methods.IsDuplicity() then
        timestamp = os.time()
    else
        timestamp = GetCloudTimeAsInt()
    end

    -- Readable time server/client side
    local readableTime = nil

    if CNF.methods.IsDuplicity() then
        readableTime = os.date("%Y-%m-%d %H:%M:%S")
    else
        local y, m, d, h, min, s = GetLocalTime()
        readableTime = string.format("%04d-%02d-%02d %02d:%02d:%02d", y, m, d, h, min, s)
    end

    local newLog = {
        type = logType,
        message = message,
        timestamp = timestamp,
        readableTime = readableTime,
    }

    if Config.allowLogs[logType] then
        print(logTypes[logType].titleColor.."["..logTypes[logType].title.."] "..readableTime.." : "..logTypes[logType].textColor..message)
    end

    -- Register log server/client side
    if CNF.methods.IsDuplicity() then
        table.insert(ServerCache.logs, newLog)
    else
        table.insert(ClientCache.logs, newLog)
    end
end

return Log