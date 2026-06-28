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

    for k,v in pairs(inventory) do
        if v.name == item then
            local metadata = v.metadata

            if (not metadataKey and not metadataValue) or (metadata and (metadata[metadataKey] == metadataValue or (metadataValue == "any" and metadata[metadataKey] ~= nil))) then
                local item = {
                    name = v.name,
                    slot = v.slot,
                    metadata = v.metadata
                }

                if not getAllItems then
                    return item
                end

                matchedItems[#matchedItems+1] = item
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

---@param inv number|string|nil
---@return number|string|nil
local function ResolvePlayerSource(inv)
    if not inv then return nil end
    if type(inv) == 'number' then return inv end
    local identifier = tostring(inv):match('^player:(.+)$')
    if identifier then return Bridge.GetPlayerByIdentifier(identifier) end
    local asNumber = tonumber(inv)
    if asNumber then return asNumber end
    return nil
end

if Config.NeedItem or Config.UniquePhones or Config.UseSimCards then
    AddEventHandler('one_inventory:onItemAdded', function(payload)
        if payload.item ~= Config.Items.Phone and payload.item ~= Config.Items.SimCard then
            return
        end

        local src = ResolvePlayerSource(payload.inventoryId)
        if not src then return end

        if not Config.Metadata or (not Config.UniquePhones and not Config.UseSimCards) then
            if payload.item ~= Config.Items.Phone then return end
            local count = exports.one_inventory:GetItemCount(payload.inventoryId, Config.Items.Phone)
            if count == 1 then
                Phone.Functions.Added(src)
            end
            return
        end


        if Config.UniquePhones and payload.item == Config.Items.Phone and not payload.metadata?.number then
            local identifier = Bridge.GetPlayerIdentifier(src)
            if not identifier then return end
            local metadata = payload.metadata or {}
            local number = Phone.Simcard.GeneratePhoneNumber()
            MySQL.query.await('INSERT INTO `17phone_simcards` (`identifier`, `number`, `active`) VALUES (?, ?, ?)', { identifier, number, 0 })
            metadata.number = number
            metadata.active = 0
            metadata.description = ("%s: %s"):format(_L("Core:Metadata:PhoneNumber"), number)

            local slot
            if not payload.slot then
                slot = exports.one_inventory:GetSlotIdWithItem(src, Config.Items.Phone, {})
            else
                slot = payload.slot
            end

            exports.one_inventory:SetItemMetadata(src, slot, metadata)
            Phone.Functions.Added(src, tostring(number), 0)
        elseif not Config.UniquePhones and Config.UseSimCards and payload.item == Config.Items.SimCard and not payload.metadata?.number then
            local identifier = Bridge.GetPlayerIdentifier(src)
            if not identifier then return end
            local metadata = payload.metadata or {}
            local number = Phone.Simcard.GeneratePhoneNumber()
            MySQL.query.await('INSERT INTO `17phone_simcards` (`identifier`, `number`, `active`) VALUES (?, ?, ?)', { identifier, number, 0 })
            metadata.number = number
            metadata.active = 0
            metadata.description = ("%s: %s"):format(_L("Core:Metadata:PhoneNumber"), number)

            local slot
            if not payload.slot then
                slot = exports.one_inventory:GetSlotIdWithItem(src, Config.Items.SimCard, {})
            else
                slot = payload.slot
            end

            exports.one_inventory:SetItemMetadata(src, slot, metadata)
        end
    end)

    AddEventHandler('one_inventory:onItemSwapped', function(payload)
        print(json.encode(payload))
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
            local src = ResolvePlayerSource(payload.fromInventory)
            if src then
                if metadata?.number and (Config.UniquePhones or Config.UseSimCards) then
                    Phone.Functions.Removed(src, tostring(metadata.number), metadata.active)
                else
                    local count = exports.one_inventory:GetItemCount(payload.fromInventory, Config.Items.Phone)
                    if count <= 0 then
                        Phone.Functions.Removed(src)
                    end
                end
            end
        end

        if payload.toType == 'player' then
            local src = ResolvePlayerSource(payload.toInventory)
            if src then
                if metadata?.number and (Config.UniquePhones or Config.UseSimCards) then
                    Phone.Functions.Added(src, tostring(metadata.number), metadata.active)
                else
                    local count = exports.one_inventory:GetItemCount(payload.toInventory, Config.Items.Phone)
                    if count == 1 then
                        Phone.Functions.Added(src)
                    end
                end
            end
        end
    end)
end
