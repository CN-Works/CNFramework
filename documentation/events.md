```Lua
-- backend:playerClientHasLoaded
-- Description : Triggered when the player first spawns on the server. (should not be used)
-- source : client
RegisterNetEvent("backend:playerClientHasLoaded", function()
end)
```

```Lua
-- CNFramework:server:playerDropped
-- Description : Triggered when a player disconnects from the server.
-- source : server
-- serverId : int (that player was)
-- playerId : int
-- reason : string
AddEventHandler("CNFramework:server:playerDropped", function(serverId, playerId, reason)
end)
```

```Lua
-- backend:character:createCharacter
-- Description : Triggered when a player creates a character.
-- source : client
-- characterData : table
-- characterData = {
--     alias = "Nono",
--     firstName = "Norbert",
--     lastName = "Dupont",
--     -- Skin table
--     skin = {},
-- }
RegisterNetEvent("backend:character:createCharacter", function(characterData)
end)
```