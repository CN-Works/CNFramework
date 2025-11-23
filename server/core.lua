CNF = {
    enums = require "shared.Enums",
    -- Registered classes
    classes = {
        ["Player"] = require "server.classes.Player.Player",
    },
    -- Repositories
    repositories = {
        ["Player"] = require "server.classes.Player.PlayerRepository",
    },
    methods = {
        -- Tools
        Log = require "shared.methods.Logger",
        DumpTable = require "shared.methods.DumpTable",
        ValidateType = require "shared.methods.ValidateType",
        GetDiscordIdByServerId = require "server.methods.GetDiscordIdByServerId",
    },
    databaseTables = require "server.databaseTables",
}