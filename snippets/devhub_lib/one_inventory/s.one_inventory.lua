if Shared.InventorySystem ~= "one_inventory" then return end  

Core.RegisterItem = function(item, func)
    if Shared.Framework == "ESX" then 
        ESX.RegisterUsableItem(item, function(playerId)
            func(playerId)
        end)
    elseif Shared.Framework == "QBCore" then
        QBCore.Functions.CreateUseableItem(item, function(source, item)
            func(source)
        end)
     elseif Shared.Framework == "QBOX" then
        exports.qbx_core:CreateUseableItem(item, function(source, item)
            func(source)
        end)
    end
end

Core.RegisterServerCallback('dh_lib:server:getItemData', function(source, cb, itemName)
    cb(Core.GetItemData(itemName))
end)

Core.GetAllItems = function(source)
    local playerInventory = exports.one_inventory:GetInventory(source)
    if not playerInventory or not playerInventory.slots then return {} end
    local items = {}
    for slot, item in pairs(playerInventory.slots) do
        if item and item.name then
            items[#items + 1] = {
                name = item.name,
                amount = item.count,
                metadata = item.metadata,
                label = item.label,
                slot = slot
            }
        end
    end
    return items
end

Core.GetItemData = function(itemName)
    local itemData = exports.one_inventory:GetItemDefinition(itemName)
    if not itemData then return nil end
    return {
        label = itemData.label or itemName,
        img = string.format("https://cfx-nui-one_inventory/web/images/%s.png", itemName),
    }
end
 
Core.GetItemMetadata = function(source, slot)
    local item = exports.one_inventory:GetSlot(source, slot)
    return {name = item?.name, amount = item?.count, metadata = item?.metadata}
end

Core.SetItemMetadata = function(source, slot, metadata)
    return exports.one_inventory:SetItemMetadata(source, slot, metadata)
end

Core.RemoveItem = function(source, itemName, amount)
    return exports.one_inventory:RemoveItem(source, itemName, amount or 1)
end

Core.AddItem = function(source, itemName, amount, metadata)
    return exports.one_inventory:AddItem(source, itemName, amount or 1, metadata)
end

Core.CanCarry = function(source, item, amount)
    return exports.one_inventory:CanCarryItem(source, item, amount)
end

Core.GetItemCount = function(source, item)
    return exports.one_inventory:GetItemCount(source, item)
end

LoadedSystems['inventory'] = true