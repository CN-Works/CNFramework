local Enums = require "shared.Enums"

-- Class
local Player = lib.class("Player")

-- id : int
-- name : string
-- roles : table
-- lastConnection : int
function Player:constructor(id, name, data, roles, lastConnection)
    -- Id
    if id == nil or type(id) ~= "number" or id < 1 then
        return false
    end
    
    self.private.id = id

    -- Name
    if name == nil or type(name) ~= "string" or string.len(name) == 0 or string.len(name) > 50 then
        return false
    end

    self.private.name = name

    -- Data
    if data == nil or type(data) ~= "table" then
        return false
    end

    self.private.data = data

    -- Roles
    if roles == nil or type(roles) ~= "table" then
        return false
    end

    self.private.roles = roles

    if lib.table.contains(self.private.roles, "user") == false then
        table.insert(self.private.roles, "user")
    end

    -- Last connection
    if lastConnection == nil or type(lastConnection) ~= "number" or lastConnection < 1 or lastConnection > os.time() then
        return false
    end

    self.private.lastConnection = lastConnection
end

--------------------
-- Methods
--------------------

function Player:getId() -- Int
    return self.private.id
end

function Player:getName() -- string
    return self.private.name
end

-- newName : string
function Player:setName(newName) -- bool
    if newName == nil or type(newName) ~= "string" or string.len(newName) == 0 or string.len(newName) > 50 then
        CNF.Log("error", "Player:setName invalid name input.")
        return false
    end

    -- Query
    local affectedRows = MySQL.update.await(tostring("UPDATE "..Enums.sqlTables["players"].." SET name = @name WHERE id = @id"), {
        ["name"] = newName,
        ["id"] = self:getId(),
    })
    
    -- Update object
    if affectedRows > 0 then
        self.private.name = newName
        return true
    else
        CNF.Log("error", "Player:setName SQL query failed.")
        return false
    end
end

function Player:getRoles() -- table
    return self.private.roles
end

-- roleName : string
function Player:hasRole(roleName) -- bool
    if roleName == nil or type(roleName) ~= "string" or string.len(roleName) == 0 then
        CNF.Log("error", "Player:hasRole invalid roleName input.")
        return false
    end
    
    return lib.table.contains(self.private.roles, roleName)
end

-- newRole : string
function Player:addRole(newRole) -- bool
    if newRole == nil or type(newRole) ~= "string" or string.len(newRole) == 0 then
        CNF.Log("error", "Player:addRole invalid role input.")
        return false
    end

    -- Does role exists ?
    if Enums.roles[newRole] == nil then
        CNF.Log("error", "Player:addRole role doesn't exists.")
        return false
    end

    -- Does player already have the role ?
    if self:hasRole(newRole) then
        CNF.Log("error", "Player:addRole player already has the role.")
        return false
    end

    local rolesCopy = lib.table.deepclone(self.private.roles)
    table.insert(rolesCopy, newRole)

    -- Query
    local affectedRows = MySQL.update.await(tostring("UPDATE "..Enums.sqlTables["players"].." SET roles = @roles WHERE id = @id"), {
        ["roles"] = json.encode(rolesCopy),
        ["id"] = self:getId(),
    })
    
    -- Update object
    if affectedRows > 0 then
        table.insert(self.private.roles, newRole)
        return true
    else
        CNF.Log("error", "Player:addRole SQL query failed.")
        return false
    end
end

-- roleName : string
function Player:removeRole(roleName) -- bool
    if roleName == nil or type(roleName) ~= "string" or string.len(roleName) == 0 then
        CNF.Log("error", "Player:removeRole invalid roleName input.")
        return false
    end

    if self:hasRole(roleName) == false then
        CNF.Log("error", "Player:removeRole player doesn't have the role.")
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
    local affectedRows = MySQL.update.await(tostring("UPDATE "..Enums.sqlTables["players"].." SET roles = @roles WHERE id = @id"), {
        ["roles"] = json.encode(rolesCopy),
        ["id"] = self:getId(),
    })
    
    -- Update object
    if affectedRows > 0 then
        self.private.roles = rolesCopy
        return true
    else
        CNF.Log("error", "Player:removeRole SQL query failed.")
        return false
    end
end

function Player:getLastConnection() -- int
    return self.private.lastConnection
end

function Player:updateLastConnection() -- bool
    local timestamp = os.time()

    -- Query
    local affectedRows = MySQL.update.await(tostring("UPDATE "..Enums.sqlTables["players"].." SET last_connection = @lastConnection WHERE id = @id"), {
        ["lastConnection"] = timestamp,
        ["id"] = self:getId(),
    })

    -- Update object
    if affectedRows > 0 then
        self.private.lastConnection = timestamp
        return true
    else
        CNF.Log("error", "Player:updateLastConnection SQL query failed.")
        return false
    end
end

-- Returns class if imported
return Player