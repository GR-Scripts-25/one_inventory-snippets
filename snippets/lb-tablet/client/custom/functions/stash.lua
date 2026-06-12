RegisterNetEvent("tablet:police:openStash", function(stashId)
    if IsOxInventoryStarted() then
        exports.ox_inventory:openInventory("stash", stashId)
    end

    ToggleOpen(false)
end)
