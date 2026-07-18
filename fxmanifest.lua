fx_version "cerulean"
name "CNFramework"
author "CN-Works"
repository "https://github.com/CN-Works/CNFramework"
game "gta5"

dependencies {
    "ox_lib",
    "oxmysql",
}

client_script {
    "client/cache.lua",
    "client/**.lua",
}

shared_script {
    "@ox_lib/init.lua",
    "shared/**.lua"
}

server_script {
    "@oxmysql/lib/MySQL.lua",
    "config.lua",
    "context_config.lua",
    "server/core.lua",
    "server/cache.lua",
    "server/init.lua",
    -- Others
    "server/functions/**.lua",
    "server/methods/**.lua",
    "server/commands/**.lua",
    "server/events/**.lua",
    "server/exports/**.lua",
    "server/threads/**.lua",
}