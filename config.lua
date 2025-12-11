Config = {
    serverName = "Los Santos",
    serverDescription = "A roleplay server made by CN-Works",

    -- Environment related
    env = "dev",

    gameMode = {
        mapName = "Los Santos",
        pvp = true,
    },

    -- Logs related
    allowLogs = {
        -- Console
        ["info"] = true,
        ["error"] = true,
        ["critical"] = true,
        ["success"] = true,
        ["orm"] = true,
        ["debug"] = false,
        -- Other platforms
        ["discord"] = true,
        ["fivemanage"] = true,
    },
}