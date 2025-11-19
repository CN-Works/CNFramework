RegisterCommand("coords", function()
    local coords = GetEntityCoords(PlayerPedId())
    local heading = GetEntityHeading((PlayerPedId()))

    -- output : {x = -802.0, y = 175.0, z = 73.0, h = 260.0},
    local text = string.format("{x = %s, y = %s, z = %s, h = %s},", math.round(coords.x,2), math.round(coords.y,2), math.round(coords.z,2), math.round(heading,2))

    lib.setClipboard(text)
end)