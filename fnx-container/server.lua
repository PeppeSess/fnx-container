ESX = exports.es_extended:getSharedObject()

if Config.Inventory == 'mf-inventory' then 
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
end 

if Config.Inventory == 'ox_inventory' then
    for k, v in pairs(Config.Container) do 
        AddEventHandler('onServerResourceStart', function(resourceName)
            if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
                Wait(0)
                exports.ox_inventory:RegisterStash(k, 'Deposito', v.MaxSlots, v.MaxWeight)
            end
        end)
    end 
end 
