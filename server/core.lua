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
    -- Cached Players
    -- Tools
    Log = require "shared.tools.Logger",
    DumpTable = require "shared.tools.DumpTable",
}