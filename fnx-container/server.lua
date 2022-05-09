ESX = exports.es_extended:getSharedObject()

Citizen.CreateThread(function()
    exports["mf-inventory"]:onReady( function()
        for k, v in pairs(Config.Container) do 
            local getinventory = exports["mf-inventory"]:getInventory(k)
            if not getinventory then
                exports["mf-inventory"]:createInventory(k,"inventory","vault","Deposito",v.MaxWeight,v.MaxSlots)
            end
        end
    end)  
end)