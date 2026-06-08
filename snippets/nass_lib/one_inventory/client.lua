local found = GetResourceState('one_inventory')
if found ~= 'started' and found ~= 'starting' then return end

nass.inventorySystem = 'one_inventory'
nass.inventory = {}

function nass.inventory.openPlayerInventory(targetId)
    exports.one_inventory:OpenInventory('player', targetId)
end

function nass.inventory.openStash(data)
    local stashData = {
        id = data.name,
        slots = data.slots,
        maxWeight = data.maxWeight,
        label = data.name
    }
    
    if data.unique then
        stashData.owner = true
    end
    
    exports.one_inventory:OpenInventory('stash', stashData)
end

function nass.inventory.openShop(data)
    exports.one_inventory:OpenInventory('shop', data.identifier)
end