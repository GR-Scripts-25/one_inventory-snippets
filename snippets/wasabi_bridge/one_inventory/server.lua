---@diagnostic disable: duplicate-set-field
-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
-- Use this file to add support for another inventory by simply copying the file and replacing the logic within the functions
local found = GetResourceState('one_inventory')
if found ~= 'started' and found ~= 'starting' then return end

WSB.inventorySystem = 'one_inventory'
WSB.inventory = {}

local registeredShops = {}

function WSB.inventory.getItemSlot(source, item)
    return exports.one_inventory:GetSlotIdWithItem(source, item) or false
end

function WSB.inventory.getItemSlots(source, item)
    local slots = exports.one_inventory:GetSlotIdsWithItem(source, item)
    return slots or {}
end

function WSB.inventory.getItemMetadata(source, slot)
    local item = exports.one_inventory:GetSlot(source, slot)
    return item and item.metadata or nil
end

function WSB.inventory.setItemMetadata(source, slot, metadata)
    return exports.one_inventory:SetItemMetadata(source, slot, metadata)
end

---Clears specified inventory
---@param source number
---@param keepItems string | table
function WSB.inventory.clearInventory(source, identifier, keepItems)
    exports.one_inventory:ClearInventory(source, type(keepItems) == 'table' and next(keepItems) and keepItems or nil)
end

AddEventHandler('wasabi_bridge:registerStash', function(data)
    local invokingResource = GetInvokingResource()
    if not invokingResource then return end
    if invokingResource:sub(1, 7) ~= 'wasabi_' then return end
    -- One Inventory auto-creates stashes on first open, no explicit registration needed
end)

AddEventHandler('wasabi_bridge:registerShop', function(data)
    --[[
        data = {
            identifier = 'shop_identifier',
            name = 'Shop Name',
            inventory = {
                { name = 'item_name', price = 100 },
            }
        }
    ]]
    local invokingResource = GetInvokingResource()
    if not invokingResource then return end
    if invokingResource:sub(1, 7) ~= 'wasabi_' then return end
    
    if registeredShops[data.identifier] then return end
    
    local shopData = {
        name = data.identifier,
        label = data.name,
        inventory = {}
    }
    
    if data.groups then
        shopData.jobs = data.groups
    end
    
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
end)