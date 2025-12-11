CNF = {
    -- Is server-side ready ?
    isReady = false,
    -- Enums
    enums = require "shared.Enums",
    -- Database tables
    databaseTables = require "server.databaseTables",
    -- Registered classes
    classes = {
        ["Player"] = require "server.classes.Player.Player",
        ["PlayerRepository"] = require "server.classes.Player.PlayerRepository",
        ["Character"] = require "server.classes.Character.Character",
        ["CharacterRepository"] = require "server.classes.Character.CharacterRepository",
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
        ValidateType = require "shared.methods.ValidateType",
        IsDuplicity = require "shared.methods.IsDuplicity",
        -- Server
        GetDiscordIdByServerId = require "server.methods.GetDiscordIdByServerId",
    },
}