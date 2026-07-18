Config = {
    -- Environment related
    env = "dev",

    -- Logs related
    allowLogs = {
        -- Console
        ["info"] = true,
        ["error"] = true,
        ["critical"] = true,
        ["success"] = true,
        ["orm"] = true,
        ["debug"] = true,
        -- Other platforms
        ["discord"] = true,
        ["fivemanage"] = true,
    },
}