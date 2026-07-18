CNF = {
    -- Is backend ready ?
    isReady = false,
    -- Enums
    enums = require "shared.enums",
    -- Database tables
    databaseTables = require "server.databaseTables",
    -- Registered classes
    classes = {
        ["Player"] = require "server.classes.Player.Player",
        ["PlayerRepository"] = require "server.classes.Player.PlayerRepository",
        --
        ["NetworkPlayer"] = require "server.classes.NetworkPlayer.NetworkPlayer",
        ["NetworkPlayerRepository"] = require "server.classes.NetworkPlayer.NetworkPlayerRepository",
    },
    -- Repositories
    repositories = {},
    -- Framewokr methods
    methods = {
        -- Shared
        Log = require "shared.methods.Log",
        DumpTable = require "shared.methods.DumpTable",
        IsDuplicity = require "shared.methods.IsDuplicity",
        IsType = require "shared.methods.IsType",
        InstanceOf = require "shared.methods.InstanceOf",
        Round = require "shared.methods.Round",
        -- Server
        GetDiscordIdByServerId = require "server.methods.GetDiscordIdByServerId",
    },
}