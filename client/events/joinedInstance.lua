RegisterNetEvent("CNFramework:client:instance:joinedInstance", function(instanceKey)
    CNF.methods.Log("info", "joined instance: "..instanceKey)
end)