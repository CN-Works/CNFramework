SetMapName(Config.mapName)
SetGameType(Config.serverName .. " gamemode.")

CNF = {
    Enums = require "shared.Enums",
    -- Registered classes
    Classes = {
        ["Player"] = require "server.classes.Player.Player",
    },
    -- Tools
    Log = require "server.tools.Logger",
    DumpTable = require "server.tools.DumpTable",
}