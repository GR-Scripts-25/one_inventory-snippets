if Shared.InventorySystem ~= "one_inventory" then return end  

Core.GetItemData = function(itemName) 
    local itemData = exports.one_inventory:Items(itemName)
    return { 
        name = itemName,
        label = itemData?.label,
        img = string.format("https://cfx-nui-one_inventory/web/images/%s.png", itemName),
    }
end

CreateThread(function()
    local lastWeapon
    while true do
        Wait(250)
        local data = exports.one_inventory:getCurrentWeapon()
        if not data then 
            if lastWeapon ~= nil then
                lastWeapon = nil
                TriggerEvent("devhub_lib:client:currentWeapon")
            end
        else
            if not lastWeapon or lastWeapon.name ~= data.name then
                lastWeapon = data
                local metadata = data?.metadata
                TriggerEvent("devhub_lib:client:currentWeapon", {
                    weapon = data.name,
                    metadata = metadata,
                })
            end
        end
    end
end)

LoadedSystems['inventory'] = true