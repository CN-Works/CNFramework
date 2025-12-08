CNF = {
    enums = require "shared.Enums",
    -- Database tables
    databaseTables = require "server.databaseTables",
    -- Registered classes
    classes = {
        ["Player"] = require "server.classes.Player.Player",
        ["Character"] = require "server.classes.Character.Character",
        ["NetworkPlayer"] = require "server.classes.NetworkPlayer.NetworkPlayer",
    },
    -- Repositories
    repositories = {
        ["Player"] = require "server.classes.Player.PlayerRepository",
        ["Character"] = require "server.classes.Character.CharacterRepository",
        ["NetworkPlayer"] = require "server.classes.NetworkPlayer.NetworkPlayerRepository",
    },
    methods = {
        -- Tools
        Log = require "shared.methods.Log",
        DumpTable = require "shared.methods.DumpTable",
        ValidateType = require "shared.methods.ValidateType",
        GetDiscordIdByServerId = require "server.methods.GetDiscordIdByServerId",
        IsDuplicity = require "shared.methods.IsDuplicity",
    },
}