RegisterCommand("createcharacter", function(source, args, rawCommand)
    local src = source
    local firstName = args[1]
    local lastName = args[2]

    if src == 0 then
        CNF.methods.Log("error", "Console can't create a character because it needs a player id.")
        return
    end
end)