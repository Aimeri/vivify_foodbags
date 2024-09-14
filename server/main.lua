local QBCore = exports['qb-core']:GetCoreObject()

local function generateUniqueId()
    local charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
    local uniqueId = ''
    for i = 1, 8 do
        local rand = math.random(1, #charset)
        uniqueId = uniqueId .. charset:sub(rand, rand)
    end
    return uniqueId
end

RegisterNetEvent('vivify_foodbags:server:giveFoodbag', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player then
        local uniqueId = generateUniqueId()
        local itemData = {
            name = "foodbag",
            info = {
                uniqueId = uniqueId,
            },
            label = "Foodbag",
            description = "A bag for storing food items."
        }
        Player.Functions.AddItem('foodbag', 1, false, itemData.info)
        TriggerClientEvent('QBCore:Notify', src, 'You received a foodbag with ID: ' .. uniqueId, 'success')
    end
end)

RegisterNetEvent('vivify_foodbags:server:openFoodbagInventory', function(uniqueId)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        local inventoryItems = Player.PlayerData.items
        local foundFoodbag = false
        
        for _, item in pairs(inventoryItems) do
            if item.name == 'foodbag' and item.info and item.info.uniqueId == uniqueId then
                foundFoodbag = true
                local inventoryData = {
                    label = 'Foodbag_' .. uniqueId,
                    maxweight = Config.FoodbagWeight,
                    slots = Config.FoodbagSlots
                }
                exports['qb-inventory']:OpenInventory(src, 'Foodbag_' .. uniqueId, inventoryData)
                break
            end
        end

        if not foundFoodbag then
            TriggerClientEvent('QBCore:Notify', src, 'Foodbag not found!', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'No valid foodbag found!', 'error')
    end
end)

QBCore.Functions.CreateUseableItem("foodbag", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player and item.info and item.info.uniqueId then
        TriggerClientEvent('vivify_foodbags:client:useFoodbag', source, item.info.uniqueId)
    end
end)