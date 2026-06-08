---@diagnostic disable: duplicate-set-field
-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

-- Use this file to add support for another inventory by simply copying the file and replacing the logic within the functions
local found = GetResourceState('one_inventory')
if found ~= 'started' and found ~= 'starting' then return end

WSB.inventorySystem = 'one_inventory'
WSB.inventory = {}

function WSB.inventory.openPlayerInventory(targetId)
    exports.one_inventory:OpenInventory('player', targetId)
end

function WSB.inventory.openStash(data)
    -- data = {name = name, unique = true, maxWeight = maxWeight, slots = slots}
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

function WSB.inventory.openShop(data)
    --[[
        For security, you need to register shops on the server side
        using server only event 'wasabi_bridge:registerShop'
        see server.lua of this inventory for more information
    ]]
    exports.one_inventory:OpenInventory('shop', data.identifier)
end