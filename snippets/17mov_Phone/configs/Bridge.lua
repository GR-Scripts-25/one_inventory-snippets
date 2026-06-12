-- FRAMEWORK CONFIGURATION
Config.Framework = "auto"
--[[
    List of supported frameworks:
    > "auto"        - Auto-detect framework
    > "es_extended" - es_extended: https://github.com/esx-framework/esx_core/tree/main/%5Bcore%5D/es_extended
    > "qb-core"     - qb-core: https://github.com/qbcore-framework/qb-core
    > "qbx_core"    - qbx_core: https://github.com/Qbox-project/qbx_core
    > "ox_core"     - ox_core: https://github.com/CommunityOx/ox_core
    > "vrp"         - vrp: https://github.com/vRP-framework/vRP
    > "standalone"  - Choose this if you are not using any framework or your framework is not listed. Note that some features may not work properly without configurating all of functions from bridge/framework/standalone
]]

-- INVENTORY CONFIGURATION
Config.Inventory = "auto"
--[[
    List of supported inventories:
    > "auto"            - Auto-detect inventory
    > "esx_inventory"   - esx_inventory: https://github.com/esx-framework/esx_core/tree/main/%5Bcore%5D/esx_inventory (Not very recommended due to lack of item metadata support)
    > "ox_inventory"    - ox_inventory: https://github.com/overextended/ox_inventory
    > "qb-inventory"    - qb-inventory: https://github.com/qbcore-framework/qb-inventory
    > "ps-inventory"    - ps-inventory: https://github.com/Project-Sloth/ps-inventory
    > "codem-inventory" - codem-inventory: https://codem.tebex.io/package/5900973
    > "qs-inventory"    - qs-inventory: https://www.quasar-store.com/scripts/inventory
    > "vrp"             - vrp: https://github.com/vRP-framework/vRP
    > 'origen_inventory' - origen_inventory: https://www.origennetwork.store/package/5881161
    > 'one_inventory'    - one_inventory: https://onestudios.gg/docs
    > "standalone"      - Choose this if you are not using any inventory or your inventory is not listed. Note that some features may not work properly without configurating all of functions from bridge/inventory/standalone
]]

-- HOUSING CONFIGURATION
Config.Housing = "auto"
--[[
    List of supported housing systems:
    > "auto"             - Auto-detect housing
    > "esx_property"     - esx_property: https://github.com/esx-framework/ESX-Legacy-Addons/tree/main/%5Besx_addons%5D/esx_property
    > "qb-houses"        - qb-houses: https://github.com/qbcore-framework/qb-houses
    > "ps-housing"       - ps-housing: https://github.com/Project-Sloth/ps-housing
    > "loaf_housing"     - loaf_housing: https://store.loaf-scripts.com/package/4310850
    > "qs-housing"       - qs-housing: https://quasar-store.tebex.io/package/5018837
    > "vms_housing"      - vms_housing: https://www.vames-store.com/package/6923949
    > "RxHousing"        - RxHousing: https://rxscripts.xyz/scripts/advanced-housing
    > 'nolag_properties' - nolag_properties: https://teamsgg.dev/scripts/properties
    > 'bcs_housing'      - bcs_housing: https://masbagus.tebex.io/package/5090952
    > 'rtx_housing'      - rtx_housing: https://rtx.tebex.io/package/7181359
    > "standalone"       - Choose this if you are not using any housing or your housing is not listed. Note that some features may not work properly without configurating all of functions from bridge/housing/standalone
]]

-- GARAGES CONFIGURATION
Config.Garages = "auto"
--[[
    List of supported garage systems:
    > "auto"               - Auto-detect garages
    > "qb-garages"         - qb-garages: https://github.com/qbcore-framework/qb-garages
    > "esx_garage"         - esx_garage: https://github.com/esx-overextended/esx_garage-legacy
    > "qbx_garages"        - qbx_garages: https://github.com/Qbox-project/qbx_garages
    > "jg-advancedgarages" - jg-advancedgarages: https://docs.jgscripts.com/advanced-garages/introduction
    > "okokGarage"         - okokGarage: https://okok.tebex.io/package/5387472
    > "lunar_garage"       - lunar_garage: https://github.com/Lunar-Scripts/lunar_garage
    > "cd_garage"          - cd_garage: https://docs.codesign.pro/paid-scripts/garage
    > "loaf_garage"        - loaf_garage: https://store.loaf-scripts.com/package/431076
    > "esx_advancedgarage" - esx_advancedgarage: https://github.com/HumanTree92/VENT_ESX_Scripts/tree/main/esx_advancedgarage
    > "ZSX_Garages"        - ZSX_Garages: https://store.zeusx.dev/package/7176048
    > "standalone"         - Choose this if you are not using any garage system or if your garage system is not listed. Note that some features may not work properly without configurating all of functions from bridge/garages/standalone
]]

-- FUEL CONFIGURATION
Config.Fuel = "auto"
--[[
    List of supported fuel systems:
    > "auto"         - Auto-detect fuel resource
    > "qb-fuel"      - qb-fuel: https://github.com/qbcore-framework/qb-fuel
    > "LegacyFuel"   - LegacyFuel: https://github.com/InZidiuZ/LegacyFuel
    > "ox_fuel"      - ox_fuel: https://github.com/overextended/ox_fuel
    > "lc_fuel"      - lc_fuel: https://github.com/LeonardoSoares98/lc_fuel
    > "cdn-fuel"     - cdn-fuel: https://github.com/CodineDev/cdn-fuel
    > "rcore_fuel"   - rcore_fuel: https://documentation.rcore.cz/paid-resources/rcore_fuel
    > "standalone"   - Choose this if you are not using any fuel system or if your fuel system is not listed. Note that some features may not work properly without configurating all of functions from bridge/fuel/standalone
]]

-- VOICE CONFIGURATION
Config.Voice = "auto"
--[[
    List of supported voice systems:
    > "auto"         - Auto-detect voice
    > "pma-voice"    - pma-voice: https://github.com/AvarianKnight/pma-voice
    > "mumble-voip"  - mumble-voip: https://github.com/FrazzIe/mumble-voip-fivem
    > "saltychat"    - saltychat: https://github.com/SaltyHub-net/saltychat-fivem
    > "standalone"   - Choose this if you are not using any voice or your voice is not listed. Note that some features may not work properly without configurating all of functions from bridge/voice/standalone
]]

-- BANKING CONFIGURATION
Config.Banking = "auto"
--[[
    List of supported voice systems:
    > "auto"                - Auto-detect voice
    > "qb-banking"          - qb-banking: https://github.com/qbcore-framework/qb-banking
    > "esx_society"         - esx_society: https://github.com/esx-framework/ESX-Legacy-Addons/tree/973ae5390b61e3e6e6e2f507fe8d13cb8d2370af/%5Besx_addons%5D/esx_society
    > "vrp"                 - used on vrp framework
    > "ox_core"             - ox_core: Default ox_core banking system
    > "Renewed-Banking"     - Renewed-Banking: https://github.com/Renewed-Scripts/Renewed-Banking
    > "fd_banking"          - fd_banking: https://felis.gg/product/banking
    > "tgiann-bank"         - tgiann-bank: https://www.tgiann.com/en/package/5222964
    > "standalone"          - Choose this if you are not using any banking system or your banking system is not listed. Note that some features may not work properly without configurating all of functions from bridge/banking/standalone
]]

Config.Target = Config.UseTarget and "auto" or "standalone"
--[[
    List of supported target systems:
    > "auto"         - Auto-detect target
    > "qb-target"    - qb-target:
    > "ox_target"   - ox_target:
    > "qtarget"  - qtarget:
    > "standalone" - Choose this if you are not using any target system or your target system is not listed. Note that some features may not work properly without configurating all of functions from bridge/target/standalone
--]]

--[[
    AUTO-DETECTION LOGIC
    It should not be touched unless you know what you are doing.
]]

local function isResourceStartedOrStarting(resourceName, iteration)
    local provide_number = GetNumResourceMetadata(resourceName, "provide")

    if provide_number > 0 then
        for i=1, provide_number do
            local providedResource = GetResourceMetadata(resourceName, "provide", i - 1)

            if providedResource == resourceName then
                if iteration == 1 then
                    Core.Print(("Detected that %s is being provided by another resource. For security reasons, this situation is not allowed and this script will not be properly detected as running."):format(resourceName))
                end

                return false
            end
        end
    end

    local state = GetResourceState(resourceName)
    return state == "started" or state == "starting"
end

CreateThread(function()
    if Config.Framework == "auto" then
        local resources = { 'qbx_core', 'qb-core', 'es_extended', 'ox_core', 'vrp' }

        local function detectFramework(iteration)
            for i = 1, #resources do
                if isResourceStartedOrStarting(resources[i], iteration) then
                    return resources[i]
                end
            end

            return "auto"
        end

        -- Let's give some more chance to detect in case if phone is starting before framework
        for i = 1, 100 do
            if Config.Framework == "auto" then
                Config.Framework = detectFramework(i)
            else
                break
            end

            Wait(100)
        end

        -- If framework is still not detected, switch to standalone
        if Config.Framework == "auto" then
            Config.Framework = "standalone"
        end

        -- Warn user if no framework detected
        if Config.Framework == "standalone" then
            Core.Print("^3WARN: No supported framework detected, make sure that you are starting 17mov_Phone AFTER your framework - switching to standalone mode.^0")
        end
    end
end)

CreateThread(function()
    if Config.Inventory == "auto" then
        local resources = { 'jaksam_inventory', 'core_inventory', 'qs-inventory', 'ps-inventory', 'codem-inventory', 'tgiann-inventory', 'ox_inventory', 'qb-inventory', 'one_inventory', 'vrp'}

        local function detectInventory(iteration)
            for i = 1, #resources do
                if isResourceStartedOrStarting(resources[i], iteration) then
                    return resources[i]
                end
            end

            return "auto"
        end

        -- Let's give some more chance to detect in case if phone is starting before inventory
        for i = 1, 100 do
            if Config.Inventory == "auto" then
                Config.Inventory = detectInventory(i)
            else
                break
            end

            Wait(100)
        end

        -- If inventory is still not detected, switch to standalone
        if Config.Inventory == "auto" then
            Config.Inventory = "standalone"
        end

        -- Warn user if no inventory detected
        if Config.Inventory == "standalone" then
            Core.Print("^3WARN: No supported inventory detected, make sure that you are starting 17mov_Phone AFTER your inventory resource - switching to standalone mode.^0")
        end
    end
end)

CreateThread(function()
    if Config.Housing == "auto" then
        local resources = { 'ps-housing', 'qs-housing', 'loaf_housing', 'vms_housing', 'nolag_properties', 'RxHousing', 'esx_property', 'qb-houses', 'bcs_housing', 'rtx_housing' }

        local function detectHousing(interation)
            for i = 1, #resources do
                if isResourceStartedOrStarting(resources[i], interation) then
                    return resources[i]
                end
            end

            return "auto"
        end

        -- Let's give some more chance to detect in case if phone is starting before housing
        for i = 1, 100 do
            if Config.Housing == "auto" then
                Config.Housing = detectHousing(i)
            else
                break
            end

            Wait(100)
        end

        -- If housing is still not detected, switch to standalone
        if Config.Housing == "auto" then
            Config.Housing = "standalone"
        end

        -- Warn user if no housing detected
        if Config.Housing == "standalone" then
            Core.Print("^3WARN: No supported housing detected, make sure that you are starting 17mov_Phone AFTER your housing resource - switching to standalone mode.^0")
        end
    end
end)

CreateThread(function()
    if Config.Voice == "auto" then
        local resources = { 'pma-voice', 'mumble-voip', 'saltychat' }

        local function detectVoice(iteration)
            for i = 1, #resources do
                if isResourceStartedOrStarting(resources[i], iteration) then
                    return resources[i]
                end
            end

            return "auto"
        end

        -- Let's give some more chance to detect in case if phone is starting before voice
        for i = 1, 100 do
            if Config.Voice == "auto" then
                Config.Voice = detectVoice(i)
            else
                break
            end

            Wait(100)
        end

        -- If voice is still not detected, switch to standalone
        if Config.Voice == "auto" then
            Config.Voice = "standalone"
        end

        -- Warn user if no voice detected
        if Config.Voice == "standalone" then
            Core.Print("^3WARN: No supported voice detected, make sure that you are starting 17mov_Phone AFTER your voice system - switching to standalone mode.^0")
        end
    end
end)

CreateThread(function()
    if Config.Banking == "auto" then
        local resources = { 'qb-banking', 'esx_society', 'ox_core', 'vrp', 'Renewed-Banking', 'fd_banking', 'wasabi_banking', 'p_banking', 'tgg-banking', 'tgiann-bank', 'okokBanking' }

        local function detectBanking(iteration)
            for i = 1, #resources do
                if isResourceStartedOrStarting(resources[i], iteration) then
                    return resources[i]
                end
            end

            return "auto"
        end

        -- Let's give some more chance to detect in case if phone is starting before banking
        for i = 1, 100 do
            if Config.Banking == "auto" then
                Config.Banking = detectBanking(i)
            else
                break
            end

            Wait(100)
        end

        -- If housing is still not detected, switch to standalone
        if Config.Banking == "auto" then
            Config.Banking = "standalone"
        end

        -- Warn user if no housing detected
        if Config.Banking == "standalone" then
            Core.Print("^3WARN: No supported banking detected, make sure that you are starting 17mov_Phone AFTER your banking resource - switching to standalone mode.^0")
        end
    end
end)

CreateThread(function()
    if Config.Fuel == "auto" then
        local resources = { 'lc_fuel', 'qb-fuel', 'rcore_fuel', 'cdn-fuel', 'ox_fuel', 'LegacyFuel' }

        local function detectFuel(iteration)
            for i = 1, #resources do
                if isResourceStartedOrStarting(resources[i], iteration) then
                    return resources[i]
                end
            end

            return "auto"
        end

        -- Let's give some more chance to detect in case if phone is starting before fuel
        for i = 1, 100 do
            if Config.Fuel == "auto" then
                Config.Fuel = detectFuel(i)
            else
                break
            end

            Wait(100)
        end

        -- If fuel is still not detected, switch to standalone
        if Config.Fuel == "auto" then
            Config.Fuel = "standalone"
        end

        -- Warn user if no fuel detected
        if Config.Fuel == "standalone" then
            Core.Print("^3WARN: No supported fuel system detected, make sure that you are starting 17mov_Phone AFTER your fuel resource - switching to standalone mode.^0")
        end
    end
end)

CreateThread(function()
    if Config.Garages == "auto" then
        local resources = { 'qb-garages', 'esx_garage', 'qbx_garages', 'jg-advancedgarages', 'lunar_garage', 'cd_garage', 'okokGarage', 'esx_advancedgarage', 'loaf_garage', 'ZSX_Garages', 'vms_garagesv2', 'tgiann-realparking' }

        local function detectGarages(iteration)
            for i = 1, #resources do
                if isResourceStartedOrStarting(resources[i], iteration) then
                    return resources[i]
                end
            end

            return "auto"
        end

        -- Let's give some more chance to detect in case if phone is starting before garages
        for i = 1, 100 do
            if Config.Garages == "auto" then
                Config.Garages = detectGarages(i)
            else
                break
            end

            Wait(100)
        end

        -- If garages are still not detected, switch to standalone
        if Config.Garages == "auto" then
            Config.Garages = "standalone"
        end

        -- Warn user if no garages detected
        if Config.Garages == "standalone" then
            Core.Print("^3WARN: No supported garages system detected, make sure that you are starting 17mov_Phone AFTER your garages resource - switching to standalone mode.^0")
        end
    end
end)

local function isResourceStarted(resourceName)
    local state = GetResourceState(resourceName)
    return state == "started" or state == "starting"
end

CreateThread(function()
    if Config.Target == "auto" then
        local resources = { 'ox_target', 'qb-target', 'qtarget'}
        local function detectTarget()
            for _, resourceName in pairs(resources) do
                if isResourceStarted(resourceName) then
                    return resourceName
                end
            end

            return "auto"
        end

        for i = 1, 100 do
            if Config.Target == "auto" then
                Config.Target = detectTarget()
            else
                break
            end

            Wait(100)
        end

        if Config.Target == "auto" then
            Config.Target = "standalone"
        end

        if Config.Target == "standalone" then
            Core.Print("^5[17mov_Phone] ^3WARN: No supported target system detected, make sure that you are starting 17mov_PhoneStore AFTER your target script - switching to standalone mode.^0")
        end
    end
end)