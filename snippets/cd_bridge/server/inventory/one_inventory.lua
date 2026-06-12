if Cfg.Inventory ~= 'one_inventory' then return end

local ItemList = {}
local InventoryImages = {}

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                      BASIC ITEM FUNCTIONS                        │
-- └──────────────────────────────────────────────────────────────────┘

-- Add item to a player's inventory
function AddItem(source, item_name, amount, metadata)
    if metadata and metadata.quality then
        metadata.durability = metadata.quality
        metadata.quality = nil
    end
    return exports.one_inventory:AddItem(source, item_name, amount, metadata)
end

-- Remove item from a player's inventory
function RemoveItem(source, item_name, amount, slot)
    return exports.one_inventory:RemoveItem(source, item_name, amount, nil, slot)
end

-- Remove item from a player's inventory with matching metadata
function RemoveItemWithMetadata(source, item_name, amount, metadata)
    return exports.one_inventory:RemoveItem(source, item_name, amount, metadata, nil)
end

-- Check if a player has a specific item and amount
function HasItem(source, item_name, amount)
    amount = amount or 1
    return exports.one_inventory:HasItem(source, item_name, amount)
end

-- Get the count of a specific item in a player's inventory
function GetItemCount(source, item_name)
    return exports.one_inventory:GetItemCount(source, item_name) or 0
end

-- Check if a player can carry a specific item and amount
function CanCarryItem(source, item_name, amount)
    return exports.one_inventory:CanCarryItem(source, item_name, amount)
end

-- Add weapon to a player's inventory
function AddWeapon(source, weapon_name, ammo)
    return AddItem(source, weapon_name, 1, { ammo = ammo })
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                           ITEM METADATA                          │
-- └──────────────────────────────────────────────────────────────────┘

-- Returns the players full inventory
function GetPlayerInventory(source)
    local inventory = exports.one_inventory:GetInventoryItems(source)
    if not inventory then return {} end

    local normalisedInventory = {}
    for _, item in pairs(inventory) do
        if item then
            table.insert(normalisedInventory, {
                name = item.name,
                label = item.label,
                amount = item.count,
                slot = item.slot,
                metadata = item.metadata or {},
                quality = item.metadata and item.metadata.durability
            })
        end
    end
    return normalisedInventory
end

-- Get item information from a specific slot
function GetItemFromSlot(source, slot)
    local item = exports.one_inventory:GetSlot(source, slot)
    return item and {
        name = item.name,
        label = item.label,
        amount = item.count,
        slot = item.slot,
        metadata = item.metadata or {},
        quality = item.metadata and item.metadata.durability
    }
end

-- Add quality to an item in a specific slot, or to the first item matching the itemName
function AddQualityToItem(source, slot, qualityIncrease, itemName)
    local currentQuality = GetItemQuality(source, slot) or 0
    local newQuality = currentQuality + qualityIncrease
    if newQuality > 100 then newQuality = 100 end

    exports.one_inventory:SetItemDurability(source, slot, newQuality)
end

-- Remove quality from an item in a specific slot, or from the first item matching the itemName
function RemoveQualityFromItem(source, slot, qualityDecrease, itemName)
    local currentQuality = GetItemQuality(source, slot) or 0
    local newQuality = currentQuality - qualityDecrease
    if newQuality < 0 then newQuality = 0 end

    exports.one_inventory:SetItemDurability(source, slot, newQuality)
end

-- Set the quality of an item in a specific slot, or of the first item matching the itemName
function SetItemQuality(source, slot, quality, itemName)
    exports.one_inventory:SetItemDurability(source, slot, quality)
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                           GET SHARED DATA                        │
-- └──────────────────────────────────────────────────────────────────┘

-- Check if a player can carry a specific item and amount
function GetItemList()
    if next(ItemList) ~= nil then
        return ItemList
    end

    local items = exports.one_inventory:GetAllItemDefinitions()
    if not items then
        return ItemList
    end

    for k, v in pairs(items) do
        local name = type(k) == 'string' and k or v.name

        if name then
            ItemList[name] = {
                name = name,
                label = v.label or name,
            }
        end
    end

    return ItemList
end

-- Get inventory images
function GetInventoryImages()
    if next(InventoryImages) ~= nil then
        return InventoryImages
    end
    local images = exports.cd_bridge:ReadNUIDirectory(
        GetResourcePath('one_inventory')..'/web/images',
        'one_inventory/web/images/',
        {'png', 'jpg', 'jpeg', 'gif', 'webp'}
    )
    if images then
        InventoryImages = images
    end
    return InventoryImages
end

-- ┌──────────────────────────────────────────────────────────────────┐
-- │                                OTHER                             │
-- └──────────────────────────────────────────────────────────────────┘

RegisterServerEvent('cd_garage:VehiclePlateChanged', function(oldPlate, newPlate, netId)
    exports.one_inventory:UpdateVehiclePlate(oldPlate, newPlate)
end)
