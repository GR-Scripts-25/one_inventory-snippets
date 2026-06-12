---@diagnostic disable: duplicate-doc-field

while Config.Inventory == "auto" do
    Wait(100)
end

if Config.Inventory ~= "one_inventory" then return end

Inventory = {}
Config.Metadata = true -- Tells is metadata supported by this inventory. Do not touch!

---Check if player has at least one of the specified item
---@param itemName string
---@return boolean
Inventory.HasItem = function(itemName)
    return exports.one_inventory:GetItemCount(itemName) > 0
end

---This function is responsible for fetching item with specific metadata value
---@param item string
---@param metadataKey string
---@param metadataValue string|nil|"any"
---@param getAllItems? boolean
---@return table | nil
Inventory.GetItemWithMetadata = function(item, metadataKey, metadataValue, getAllItems)
    local inventory = exports.one_inventory:GetInventoryItems()
    local matchedItems = {}

    while not inventory do
        inventory = exports.one_inventory:GetInventoryItems()
        Wait(100)
    end

    for _, invItem in pairs(inventory) do
        if invItem.name == item then
            local metadata = invItem.metadata

            if metadata and (metadata[metadataKey] == metadataValue or (metadataValue == "any" and metadata[metadataKey] ~= nil)) then
                local foundItem = {
                    name = invItem.name,
                    slot = invItem.slot,
                    metadata = invItem.metadata
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

---Block/Unblock inventory usage
---@param state boolean
Inventory.BlockInventory = function(state)
    exports.one_inventory:SetCanOpenInventory(not state)
end

---@class ItemData
---@field name string Item name
---@field label string Item label
---@field description string Item description
---@field image string Url to item image

---Getting info about specified item
---@param itemName string Item name
---@return ItemData | nil item Data of item
Inventory.GetItemData = function(itemName)
    local item = exports.one_inventory:GetItemDefinition(itemName)

    if not item then
        return nil
    end

    return {
        name = itemName,
        label = item.label,
        description = item.description,
        image = Core.FormatNuiUrl("one_inventory", "web/images", item.image or item?.client?.image or ("%s.png"):format(itemName)),
    }
end
