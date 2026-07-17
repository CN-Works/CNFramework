```Lua
-- CNFramework:server:playerClientHasLoaded
-- Description : Triggered when the player first spawns on the server. (should not be used)
-- source : client
RegisterNetEvent("CNFramework:server:playerClientHasLoaded", function()
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

```Lua
-- CNFramework:server:instance:leaveBucket
-- Description : Triggered to make a player leave a bucket
-- source : server
-- serverId : int
-- bucket : int
AddEventHandler("CNFramework:server:instance:leaveBucket", function(serverId, bucket)
end)
```