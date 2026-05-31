RegisterNetEvent('kq_link:client:one_inventory:openStash')
AddEventHandler('kq_link:client:one_inventory:openStash', function(stashId)
    exports.one_inventory:OpenInventory('stash', { id = stashId })
end)

if Link.inventory ~= 'one_inventory' then
    return
end

function GetItemCount(item)
    return exports.one_inventory:GetItemCount(item) or 0
end

function GetPlayerInventory()
    local inv = exports.one_inventory:GetInventoryItems()
    return NormalizeInventoryOutput(inv or {})
end

function GetInventoryItems()
    return UseCache('kq_link:one_inventory:items', function()
        return NormalizeItems(exports.one_inventory:GetAllItemDefinitions())
    end, 60000)
end

function GetInventoryImagePath()
    return 'nui://one_inventory/web/images/', 'png'
end
