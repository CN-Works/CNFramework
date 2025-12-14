-- CNFramework:server:playerClientHasLoaded
-- Description : Triggered when the player first spawns on the server. (should not be used)
-- source : client
RegisterNetEvent("CNFramework:server:playerClientHasLoaded", function()
end)

-- CNFramework:server:playerDropped
-- Description : Triggered when a player disconnects from the server.
-- source : server
-- serverId : int (that player was)
-- playerId : int
-- reason : string
AddEventHandler("CNFramework:server:playerDropped", function(serverId, playerId, reason)
end)