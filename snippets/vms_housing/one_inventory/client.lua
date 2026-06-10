if Config.Inventory ~= 'one_inventory' then
    return
end

function OpenStorage(metadata)
    exports.one_inventory:OpenInventory('stash', {id = metadata.id})
end