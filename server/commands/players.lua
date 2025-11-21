-- local CachedPlayers = require "server.classes.Player.CachedPlayers"

-- lib.addCommand("players", {
--     help = "Affiches les joueurs connectés.",
--     params = {},
-- }, function(source, args, raw)
--     if source ~= 0 then
--         print("Can't show players to a non-admin player.")
--         return
--     end

--     local playersList = GetActivePlayers()

--     if #playersList == 0 then
--         print("No players connected at this time.")
--         return
--     end

--     for key, serverId in pairs(playersList) do
--         print(CachedPlayers[serverId]:getName().." - id : "..CachedPlayers[serverId]:getId().." - server id : "..serverId)
--     end
-- end)