fx_version 'cerulean'
name "CNFramework"
author "CN-Works"
repository "https://github.com/CN-Works"
game 'gta5'
lua54 'yes'

client_script {
    'client/**.lua',
}

shared_script {
    '@ox_lib/init.lua',
    'config.lua',
    "shared/**.lua",
}

server_script {
    '@oxmysql/lib/MySQL.lua',
    "config_server.lua",
    "server/main.lua",
    "server/cache.lua",
    "server/tools/**.lua",
    -- Classes
    "server/classes/**.lua",
    -- Others
    "server/**.lua",
}

ui_page "public/index.html"

files {
    "public/**",
    "public/**/**",
}
