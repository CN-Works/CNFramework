```Lua
-- CNFramework:server:playerClientHasLoaded
-- Description : Triggered when the player first spawns on the server. (should not be used)
-- source : client
RegisterNetEvent("CNFramework:server:playerClientHasLoaded", function()
end)
```

```Lua
-- CNFramework:server:playerHasLoaded
-- Description : Triggered when a player has loaded on the server.
-- source : server
-- serverId : int
-- playerId : int
AddEventHandler("CNFramework:server:playerHasLoaded", function(serverId, playerId)
end)
```

```Lua
-- CNFramework:server:playerDropped
-- Description : Triggered when a player disconnects from the server.
-- source : server
-- serverId : int
-- playerId : int
-- reason : string
AddEventHandler("CNFramework:server:playerDropped", function(serverId, playerId, reason)
end)
```