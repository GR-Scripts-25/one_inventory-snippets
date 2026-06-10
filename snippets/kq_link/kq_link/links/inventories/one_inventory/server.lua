if Link.inventory ~= 'one_inventory' then
    return
end

function GetPlayerInventory(player)
    local inv = exports.one_inventory:GetInventory(player)
    if not inv or not inv.slots then return {} end
    return NormalizeInventoryOutput(inv.slots)
end

function GetPlayerItemData(player, item, meta)
    return exports.one_inventory:GetItem(player, item, meta)
end

function GetPlayerItemCount(player, item, meta)
    return exports.one_inventory:GetItemCount(player, item, meta) or 0
end

function AddPlayerItem(player, item, amount, meta)
    local success = exports.one_inventory:AddItem(player, item, amount or 1, meta)
    return success
end

function RemovePlayerItem(player, item, amount, meta)
    amount = amount or 1

    if GetPlayerItemCount(player, item) < amount then
        return false
    end

    local success = exports.one_inventory:RemoveItem(player, item, amount, meta)
    return success
end

function SetItemDurability(player, slot, durability)
    return exports.one_inventory:SetItemDurability(player, slot, durability)
end

function GetItemBySlot(player, slot)
    return exports.one_inventory:GetSlot(player, slot)
end

-- Stashes
function OpenCustomStash(player, stashId, label, slots, weight)
    exports.one_inventory:OpenInventory(player, 'stash', {
        id        = stashId,
        label     = label or stashId,
        slots     = slots or 50,
        maxWeight = weight or 100000,
    })
end

function GetStashItems(stashId)
    local inv = exports.one_inventory:GetInventory('stash:' .. stashId)
    if not inv or not inv.slots then return {} end
    return inv.slots
end

-- Weapons
function AddPlayerWeapon(player, weapon, ammo)
    return AddPlayerItem(player, weapon, 1, { ammo = ammo or 0 })
end

function DoesPlayerHaveWeapon(player, weapon)
    return GetPlayerItemCount(player, weapon) > 0
end

function RemovePlayerWeapon(player, weapon)
    return RemovePlayerItem(player, weapon, 1)
end

-- Usable items
function RegisterUsableItem(item, cb)
    exports.one_inventory:RegisterHook('beforeItemUse', function(payload)
        if payload.item == item then
            cb(payload.source, payload.item, payload.slot, payload.metadata)
            return false 
        end
    end)
end
