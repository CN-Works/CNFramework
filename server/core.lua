CNF = {
    Enums = require "shared.Enums",
    -- Registered classes
    classes = {
        ["Player"] = require "server.classes.Player.Player",
    },
    -- Repositories
    repositories = {
        ["Player"] = require "server.classes.Player.PlayerRepository",
    },
    methods = {
        GetDiscordIdByServerId = require "server.classes.methods.GetDiscordIdByServerId",
    },
    -- Tools
    Log = require "shared.tools.Logger",
    DumpTable = require "shared.tools.DumpTable",
}