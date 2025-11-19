local Enums = {
    roles = {
        ["user"] = {
            label = "Utilisateur",
        },
        ["moderator"] = {
            label = "Modérateur",
        },
        ["admin"] = {
            label = "Administrateur",
        },
        ["superadmin"] = {
            label = "Super administrateur",
        },
        ["developper"] = {
            label = "Développeur",
        },
        ["owner"] = {
            label = "Propriétaire",
        },
    },
    logsTypes = {
        ["info"] = {
            title = "Information",
            titleColor = "^7",
            textColor = "^7",
        },
        ["error"] = {
            title = "Error",
            titleColor = "^3",
            textColor = "^7",
        },
        ["critical"] = {
            title = "Major error",
            titleColor = "^1",
            textColor = "^7",
        },
        ["success"] = {
            title = "Success",
            titleColor = "^2",
            textColor = "^7",
        }
    },
}

if IsDuplicityVersion() then
    Enums.sqlTables = {
        ["players"] = "player",
        ["bans"] = "ban",
    }
end

return Enums