require "shared.Enums"

-- Class
local Player = lib.class("Player")

-- id : int
-- name : string
-- roles : table
-- lastConnection : int
function Player:constructor(id, name, roles, lastConnection)
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
        CNF.debug("error", "Player:setName invalid name input.")
        return false
    end

    -- Query
    local affectedRows = MySQL.update.await(tostring("UPDATE "..ConfigServer.sql.tables["players"].." SET name = @name WHERE id = @id"), {
        ["name"] = newName,
        ["id"] = self:getId(),
    })
    
    -- Update object
    if affectedRows > 0 then
        self.private.name = newName
        return true
    else
        CNF.debug("error", "Player:setName SQL query failed.")
        return false
    end
end

function Player:getRoles() -- table
    return self.private.roles
end

-- newRole : string
function Player:addRole(newRole) -- bool
    if newRole == nil or type(newRole) ~= "string" or string.len(newRole) == 0 or Enums.roles[newRole] == nil then
        CNF.debug("error", "Player:addRole invalid role input.")
        return false
    end

    -- Does role exist ?
    if self.private.roles[newRole] ~= nil then
        CNF.debug("error", "Player:addRole role doesn't exist in Enums roles.")
        return false
    end

    local rolesCopy = lib.table.deepclone(self.private.roles)
    table.insert(rolesCopy, newRole)

    -- Query
    local affectedRows = MySQL.update.await(tostring("UPDATE "..ConfigServer.sql.tables["players"].." SET roles = @roles WHERE id = @id"), {
        ["roles"] = json.encode(rolesCopy),
        ["id"] = self:getId(),
    })
    
    -- Update object
    if affectedRows > 0 then
        table.insert(self.private.roles, newRole)
        return true
    else
        CNF.debug("error", "Player:addRole SQL query failed.")
        return false
    end
end

-- Returns class if imported
return Player