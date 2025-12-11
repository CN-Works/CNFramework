fx_version "cerulean"
name "CNFramework"
author "CN-Works"
repository "https://github.com/CN-Works/CNFramework"
game "gta5"
lua54 "yes"

client_script {
    "client/core.lua",
    "client/cache.lua",
    "client/**.lua",
}

shared_script {
    "@ox_lib/init.lua",
    "config.lua",
    "shared/**.lua",
}

server_script {
    "@oxmysql/lib/MySQL.lua",
    "config_server.lua",
    "server/core.lua",
    "server/cache.lua",
    "server/init.lua",
    -- Others
    "server/events/**.lua",
    "server/commands/**.lua",
    "server/tests/**.lua",
}