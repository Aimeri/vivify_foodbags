local QBCore = exports['qb-core']:GetCoreObject()
local foodbagProp = nil
local isHoldingBag = false
local propModel = 'prop_paper_bag_01'

local function hasRequiredJob()
    local PlayerData = QBCore.Functions.GetPlayerData()
    local playerJob = PlayerData.job.name

    for _, location in pairs(Config.InteractionLocations) do
        if playerJob == location.job then
            return true
        end
    end

    return false
end

for _, location in pairs(Config.InteractionLocations) do
    exports['interact']:AddInteraction({
        coords = vector3(location.coords.x, location.coords.y, location.coords.z),
        distance = 2.0,
        interactDst = 2.0,
        id = 'foodbag_collection_'..location.job,
        name = 'foodbag_collection',
        ignoreLos = true,
        options = {
            {
                label = 'Collect Foodbag',
                action = function(entity, coords, args)
                    if hasRequiredJob() then
                        TriggerEvent('vivify_foodbags:client:collectFoodbag')
                    else
                        QBCore.Functions.Notify("You don't have the required job!", 'error')
                    end
                end,
            },
        }
    })
end

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(100)
    end
end

function setFoodbagProp(visible)
    local playerPed = PlayerPedId()

    if visible and not isHoldingBag then

        RequestModel(propModel)
        while not HasModelLoaded(propModel) do
            Wait(500)
        end

        local x, y, z = table.unpack(GetEntityCoords(playerPed))
        foodbagProp = CreateObject(GetHashKey(propModel), x, y, z + 0.2, true, true, true)
        AttachEntityToEntity(foodbagProp, playerPed, GetPedBoneIndex(playerPed, 57005), 0.13, 0.13, -0.24, -45.0, -115.0, 10.0, true, true, false, true, 1, true)

        loadAnimDict("anim@heists@box_carry@")
        TaskPlayAnim(playerPed, "anim@heists@box_carry@", "idle", 8.0, -8.0, -1, 50, 0, false, false, false)

        isHoldingBag = true
    elseif not visible and isHoldingBag then

        if DoesEntityExist(foodbagProp) then
            DeleteEntity(foodbagProp)
            foodbagProp = nil
        end

        ClearPedTasks(playerPed)

        isHoldingBag = false
    end
end

RegisterNetEvent('vivify_foodbags:client:collectFoodbag', function()
    TriggerServerEvent('vivify_foodbags:server:giveFoodbag')
end)

RegisterNetEvent('vivify_foodbags:client:useFoodbag', function(uniqueId)
    TriggerServerEvent('vivify_foodbags:server:openFoodbagInventory', uniqueId)
    setFoodbagProp(true)
    
    Citizen.SetTimeout(5000, function()
        setFoodbagProp(false)
    end)
end)

RegisterNetEvent('vivify_foodbags:client:closeFoodbag', function()
    setFoodbagProp(false)
end)