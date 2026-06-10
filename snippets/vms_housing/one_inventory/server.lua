if Config.Inventory ~= 'one_inventory' then
    return
end

function RegisterStorage(metadata)
    local slots = tonumber(metadata.slots)
    local weight = tonumber(metadata.weight)
    
    if not slots or not weight then
        return
    end
    
    exports.one_inventory:GetInventory('stash:' .. metadata.id)
end

function RegisterUsableItem(name, cb)
    if Config.Core == "ESX" then
        Core.RegisterUsableItem(name, function(src, itemName, itemData)
            cb(src, itemName, { metadata = itemData.metadata })
        end)
    elseif Config.Core == "QB-Core" then
        Core.Functions.CreateUseableItem(name, function(src, item)
            cb(src, item.name, { metadata = item.metadata })
        end)
    end
end

function GetItem(src, xPlayer, name, data, search)
    if search == 'key' then
        local item = exports.one_inventory:GetItem(src, name, {serial = data.keySerialNumber})
        return item ~= nil
    end
end

function AddItem(src, xPlayer, name, count, metadata)
    exports.one_inventory:AddItem(src, name, count, metadata)
end

function RemoveItem(src, xPlayer, name, count)
    exports.one_inventory:RemoveItem(src, name, count)
end