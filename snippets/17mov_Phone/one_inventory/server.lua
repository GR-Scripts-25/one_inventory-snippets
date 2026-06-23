while Config.Inventory == "auto" do
    Wait(100)
end

if Config.Inventory ~= "one_inventory" then return end

Inventory = {}
Config.Metadata = true -- Tells is metadata supported by this inventory. Do not touch!

---Adding item to a player's inventory
---@param src number
---@param itemName string
---@param amount number
---@param metadata? table<string, any>
Inventory.AddItem = function(src, itemName, amount, metadata)
    if metadata?.number then
        metadata.description = ("%s: %s"):format(_L("Core:Metadata:PhoneNumber"), metadata.number)
    end
    exports.one_inventory:AddItem(src, itemName, amount, metadata)
end

---Removing item from a player's inventory
---@param src number
---@param itemName string
---@param amount number
---@param slot number
Inventory.RemoveItem = function(src, itemName, amount, slot)
    exports.one_inventory:RemoveItem(src, itemName, amount, nil, slot)
end

---Registering item as usable
---@param itemName string
---@param cb fun(src: number, item: {name: string, slot: number, metadata: table<string, any>})
Inventory.CreateUseableItem = function(itemName, cb)
    if Config.Framework == "qb-core" then
        local QBCore = Bridge.GetCoreObject()
        QBCore.Functions.CreateUseableItem(itemName, function(src, item)
            cb(src, {
                name = item.name,
                slot = item.slot,
                metadata = item.metadata or item.info,
            })
        end)
    elseif Config.Framework == "es_extended" then
        local ESX = Bridge.GetCoreObject()

        ESX.RegisterUsableItem(itemName, function(src, _, item)
            -- not sure if this works
            cb(src, {
                name = item.name,
                slot = item.slot,
                metadata = item.metadata,
            })
        end)
    end
end

---Sets metadata for a specific item in a player's inventory
---@param src number
---@param slot number
---@param metadata table<string, any>
Inventory.SetItemMetadata = function(src, slot, metadata)
    if metadata?.number then
        metadata.description = ("%s: %s"):format(_L("Core:Metadata:PhoneNumber"), metadata.number)
    elseif metadata then
        metadata.description = nil
    end
    exports.one_inventory:SetItemMetadata(src, slot, metadata)
end

---This function is responsible for fetching phone items by name
---@param src number
---@return table
Inventory.GetPhonesItems = function(src)
    local inventory = exports.one_inventory:GetInventoryItems(src)
    local items = {}
    for _, v in pairs(inventory) do
        if v.name == Config.Items.Phone then
            items[#items+1] = {
                name = v.name,
                slot = v.slot,
                metadata = v.metadata
            }
        end
    end

    return items
end

---This function is responsible for fetching item with specific metadata value
---@param src number
---@param item string
---@param metadataKey string
---@param metadataValue string | number | nil | "any"
---@param getAllItems? boolean
---@return table | nil
Inventory.GetItemWithMetadata = function(src, item, metadataKey, metadataValue, getAllItems)
    local inventory = exports.one_inventory:GetInventoryItems(src)
    local matchedItems = {}

    while not inventory do
        inventory = exports.one_inventory:GetInventoryItems(src)
        Wait(100)
    end

    for _, v in pairs(inventory) do
        if v.name == item then
            local metadata = v.metadata or {}

            if metadataKey and metadataValue == nil then
                local foundItem = {
                    name = v.name,
                    slot = v.slot,
                    metadata = metadata
                }

                if not getAllItems then
                    return foundItem
                end

                matchedItems[#matchedItems + 1] = foundItem

            elseif (not metadataKey and not metadataValue)
                or (metadata and (
                    metadata[metadataKey] == metadataValue
                    or (metadataValue == "any" and metadata[metadataKey] ~= nil)
                )) then

                local foundItem = {
                    name = v.name,
                    slot = v.slot,
                    metadata = metadata
                }

                if not getAllItems then
                    return foundItem
                end

                matchedItems[#matchedItems + 1] = foundItem
            end
        end
    end

    return getAllItems and matchedItems or nil
end

---This function is responsible for fetching item info by slot
---@param src number | string
---@param slot number
---@return {name: string, metadata: table<string, any>} | nil
Inventory.GetItemInfo = function(src, slot)
    local item = exports.one_inventory:GetSlot(src, slot)
    if not item then return nil end
    return {
        name = item.name,
        metadata = item.metadata
    }
end

---This function checks if player has specific item in specific amount
---@param src number | string
---@param itemName string
---@param amount number
---@return boolean
Inventory.HasItem = function(src, itemName, amount)
    return exports.one_inventory:HasItem(src, itemName, amount)
end

Citizen.CreateThread(function()
    if not Config.NeedItem and not Config.UniquePhones and not Config.UseSimCards then return end

    exports.one_inventory:RegisterHook('beforeItemSwap', function(payload)
        if payload.item ~= Config.Items.Phone then
            return
        end

        local metadata = payload.fromItem?.metadata

        if not metadata?.number and (Config.UniquePhones or Config.UseSimCards) then
            return
        end

        if payload.fromInventory == payload.toInventory then
            return
        end

        if payload.fromType == 'player' then
            if metadata?.number and (Config.UniquePhones or Config.UseSimCards) then
                Phone.Functions.Removed(payload.fromInventory, tostring(metadata.number), metadata.active)
            else
                local count = exports.one_inventory:GetItemCount(payload.fromInventory, Config.Items.Phone) - 1
                if count <= 0 then
                    Phone.Functions.Removed(payload.fromInventory)
                end
            end
        end

        if payload.toType == 'player' then
            if metadata?.number and (Config.UniquePhones or Config.UseSimCards) then
                Phone.Functions.Added(payload.toInventory, tostring(metadata.number), metadata.active)
            else
                local count = exports.one_inventory:GetItemCount(payload.toInventory, Config.Items.Phone)
                if count == 0 then
                    Phone.Functions.Added(payload.toInventory)
                end
            end
        end
    end)

    exports.one_inventory:RegisterHook('beforeItemAdd', function(payload)
        if payload.item ~= Config.Items.Phone and payload.item ~= Config.Items.SimCard then
            return
        end

        if not Config.Metadata or (not Config.UniquePhones and not Config.UseSimCards) then
            if payload.item ~= Config.Items.Phone then return end
            local count = exports.one_inventory:GetItemCount(payload.inventoryId, Config.Items.Phone)
            if count == 0 then
                Phone.Functions.Added(payload.inventoryId)
            end
            return
        end
        if Config.UniquePhones and payload.item == Config.Items.Phone and not payload.metadata?.number then
            local identifier = Bridge.GetPlayerIdentifier(payload.inventoryId)
            if not identifier then return end
            payload.metadata = payload.metadata or {}
            local number = Phone.Simcard.GeneratePhoneNumber()
            MySQL.query.await('INSERT INTO `17phone_simcards` (`identifier`, `number`, `active`) VALUES (?, ?, ?)', { identifier, number, 0 })
            payload.metadata.number = number
            payload.metadata.active = 0
            payload.metadata.description = ("%s: %s"):format(_L("Core:Metadata:PhoneNumber"), number)
            Phone.Functions.Added(payload.inventoryId, tostring(number), 0)
        elseif not Config.UniquePhones and Config.UseSimCards and payload.item == Config.Items.SimCard and not payload.metadata?.number then
            local identifier = Bridge.GetPlayerIdentifier(payload.inventoryId)
            if not identifier then return end
            payload.metadata = payload.metadata or {}
            local number = Phone.Simcard.GeneratePhoneNumber()
            MySQL.query.await('INSERT INTO `17phone_simcards` (`identifier`, `number`, `active`) VALUES (?, ?, ?)', { identifier, number, 0 })
            payload.metadata.number = number
            payload.metadata.active = 0
            payload.metadata.description = ("%s: %s"):format(_L("Core:Metadata:PhoneNumber"), number)
        end
    end)
end)
