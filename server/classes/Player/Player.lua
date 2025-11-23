-- Class
local Player = lib.class("Player")

-- id : int
-- name : string
-- roles : table
-- lastConnection : int
function Player:constructor(id, discordId, name, data, roles, lastConnection)
    -- Id
    if not CNF.methods.ValidateType(id, "number") or id < 1 then
        error("Player:constructor invalid id input.")
    end
    
    self.private.id = id

    -- Discord Id
    if not CNF.methods.ValidateType(discordId, "string") or string.len(discordId) == 0 or string.len(discordId) > 19 then
        error("Player:constructor invalid discordId input.")
    end

    self.private.discordId = discordId

    -- Name
    if not CNF.methods.ValidateType(name, "string") or string.len(name) == 0 or string.len(name) > 50 then
        error("Player:constructor invalid name input.")
    end

    self.private.name = name

    -- Data
    if not CNF.methods.ValidateType(data, "table") then
        error("Player:constructor invalid data input.")
    end

    self.private.data = data

    -- Roles
    if not CNF.methods.ValidateType(roles, "table") then
        error("Player:constructor invalid roles input.")
    end

    self.private.roles = roles

    if not lib.table.contains(self.private.roles, "user") then
        table.insert(self.private.roles, "user")
    end

    -- Last connection
    if not CNF.methods.ValidateType(lastConnection, "number") or lastConnection < 1 or lastConnection > os.time() then
        error("Player:constructor invalid lastConnection input.")
    end

    self.private.lastConnection = lastConnection
end

--------------------
-- Methods
--------------------

function Player:getId() -- Int
    return self.private.id
end

function Player:getDiscordId() -- string
    return self.private.discordId
end

function Player:getName() -- string
    return self.private.name
end

-- newName : string
function Player:setName(newName) -- bool
    if not CNF.methods.ValidateType(newName, "string") or string.len(newName) == 0 or string.len(newName) > 50 then
        CNF.methods.Log("error", "Player:setName invalid name input.")
        return false
    end

    -- Query
    local affectedRows = MySQL.update.await(tostring("UPDATE "..CNF.databaseTables["players"].." SET name = @name WHERE id = @id"), {
        ["name"] = newName,
        ["id"] = self:getId(),
    })
    
    -- Update object
    if affectedRows > 0 then
        self.private.name = newName
        return true
    else
        CNF.methods.Log("error", "Player:setName SQL query failed.")
        return false
    end
end

function Player:getRoles() -- table
    return self.private.roles
end

-- roleName : string
function Player:hasRole(roleName) -- bool
    if not CNF.methods.ValidateType(roleName, "string") or string.len(roleName) == 0 then
        CNF.methods.Log("error", "Player:hasRole invalid roleName input.")
        return false
    end
    
    return lib.table.contains(self.private.roles, roleName)
end

-- newRole : string
function Player:addRole(newRole) -- bool
    if not CNF.methods.ValidateType(newRole, "string") or string.len(newRole) == 0 then
        error("Player:addRole invalid role input.")
    end

    -- Does role exists ?
    if CNF.enums.roles[newRole] == nil then
        CNF.methods.Log("error", "Player:addRole role doesn't exists.")
        return false
    end

    -- Does player already have the role ?
    if self:hasRole(newRole) then
        CNF.methods.Log("error", "Player:addRole player already has the role.")
        return false
    end

    local rolesCopy = lib.table.deepclone(self.private.roles)
    table.insert(rolesCopy, newRole)

    -- Query
    local affectedRows = MySQL.update.await(tostring("UPDATE "..CNF.databaseTables["players"].." SET roles = @roles WHERE id = @id"), {
        ["roles"] = json.encode(rolesCopy),
        ["id"] = self:getId(),
    })
    
    -- Update object
    if affectedRows > 0 then
        table.insert(self.private.roles, newRole)
        return true
    else
        CNF.methods.Log("error", "Player:addRole SQL query failed.")
        return false
    end
end

-- roleName : string
function Player:removeRole(roleName) -- bool
    if not CNF.methods.ValidateType(roleName, "string") or string.len(roleName) == 0 then
        error("Player:removeRole invalid roleName input.")
    end

    if self:hasRole(roleName) == false then
        CNF.methods.Log("error", "Player:removeRole player doesn't have the role.")
        return false
    end
    
    local rolesCopy = lib.table.deepclone(self.private.roles)

    -- Remove role
    for key, role in pairs(rolesCopy) do
        if role == roleName then
            table.remove(rolesCopy, key)
        end
    end
    
    -- Query
    local affectedRows = MySQL.update.await(tostring("UPDATE "..CNF.databaseTables["players"].." SET roles = @roles WHERE id = @id"), {
        ["roles"] = json.encode(rolesCopy),
        ["id"] = self:getId(),
    })
    
    -- Update object
    if affectedRows > 0 then
        self.private.roles = rolesCopy
        return true
    else
        CNF.methods.Log("error", "Player:removeRole SQL query failed.")
        return false
    end
end

function Player:getLastConnection() -- int
    return self.private.lastConnection
end

function Player:updateLastConnection() -- bool
    local timestamp = os.time()

    -- Query
    local affectedRows = MySQL.update.await(tostring("UPDATE "..CNF.databaseTables["players"].." SET last_connection = @lastConnection WHERE id = @id"), {
        ["lastConnection"] = timestamp,
        ["id"] = self:getId(),
    })

    -- Update object
    if affectedRows > 0 then
        self.private.lastConnection = timestamp
        return true
    else
        CNF.methods.Log("error", "Player:updateLastConnection SQL query failed.")
        return false
    end
end

-- Returns class if imported
return Player