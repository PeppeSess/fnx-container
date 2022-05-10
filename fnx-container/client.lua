ESX = exports.es_extended:getSharedObject()

TestoDestra = function (str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Citizen.CreateThread(function()
    while true do 
        Sleep = 350
        if ESX.IsPlayerLoaded() then
            for k,v in pairs(Config.Container) do
                local dist = #(GetEntityCoords(PlayerPedId())-(type(v.coords) == type(vector3(0,0,0)) and v.coords or 0))
                if dist < 5.0 then
                    Sleep = 1
                    DrawMarker(v.blip, v.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5,0.5, 0.5, 0, 0, 255, 0.8, false, false, 2, false, nil, nil, false)
                    if dist < 2.0 then
                    TestoDestra("Premi ~INPUT_CONTEXT~ per aprire il deposito")

                        if IsControlJustReleased(0,51) then
                            AddTextEntry("FMMC_KEY_TIP1", "Inserisci il Codice")
                            DisplayOnscreenKeyboard(6, "FMMC_KEY_TIP1", "", "", "", "", "", 6)
                            while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
                                Citizen.Wait(0)
                            end
                            if UpdateOnscreenKeyboard() ~= 2 then
                                local result = GetOnscreenKeyboardResult()
                                if result == v.pin then
                                    PlaySoundFrontend(-1, "Drill_Pin_Break", 'DLC_HEIST_FLEECA_SOUNDSET', 1);
                                    if Config.Inventory == 'mf-inventory' then 
                                        exports["mf-inventory"]:openOtherInventory(k)
                                    elseif Config.Inventory == 'ox_inventory' then 
                                        exports.ox_inventory:openInventory('stash', {id=k})
                                    end
                                    ESX.ShowNotification("Codice inserito correttamente")
                                else
                                    ESX.ShowNotification("Codice errato")
                                end
                            end
    
                        end
                    end 
                end
            end
        end
        Citizen.Wait(Sleep)
    end
end)