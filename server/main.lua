local ox_inventory = exports.ox_inventory

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    ESX.Players[playerId] = xPlayer.job.name
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(playerId, job)
    ESX.Players[playerId] = job.name
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
    ESX.Players[playerId] = nil
end)

MySQL.ready(function()
    print('[^2INFO^7] ^3SFX Customs Originals^0 - ^2Module Initialized^0 - ^5' .. GetCurrentResourceName() .. '^0')
end)

RegisterNetEvent('sai_photoprinter:InitServer')
AddEventHandler('sai_photoprinter:InitServer', function(Input)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not Input then return end
    
    local metadata = {}
    metadata.image = Input[1]

    xPlayer.addInventoryItem('printedphoto', 1, metadata)
end)