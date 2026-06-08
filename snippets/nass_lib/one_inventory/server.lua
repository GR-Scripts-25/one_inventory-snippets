local found = GetResourceState('one_inventory')
if found ~= 'started' and found ~= 'starting' then return end

nass.inventorySystem = 'one_inventory'
nass.inventory = {}

local registeredShops = {}

function nass.inventory.getItemSlot(source, item)
    return exports.one_inventory:GetSlotIdWithItem(source, item) or false
end

function nass.inventory.getItemMetadata(source, slot)
    local item = exports.one_inventory:GetSlot(source, slot)
    return item and item.metadata or nil
end

function nass.inventory.setItemMetadata(source, slot, metadata)
    return exports.one_inventory:SetItemMetadata(source, slot, metadata)
end

function nass.inventory.clearInventory(source, identifier, keepItems)
    exports.one_inventory:ClearInventory(source, keepItems)
end

nass.createCallback('nass_lib:registerShop', function(_source, cb, data)
    if registeredShops[data.identifier] then
        cb(true)
        return
    end
    
    local shopData = {
        name = data.identifier,
        label = data.name,
        inventory = {}
    }
    
    for _, item in ipairs(data.inventory) do
        table.insert(shopData.inventory, {
            name = item.name,
            price = item.price,
            count = item.count or 0
        })
    end
    
    if data.locations and #data.locations > 0 then
        shopData.locations = data.locations
    end
    
    exports.one_inventory:RegisterShop(shopData)
    registeredShops[data.identifier] = true
    cb(true)
end)