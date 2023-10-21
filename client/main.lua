local IsDead = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer, isNew)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:playerLogout')
AddEventHandler('esx:playerLogout', function()
    ESX.PlayerLoaded = false
    ESX.PlayerData = {}
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

AddEventHandler('esx:onPlayerDeath', function(data)
    IsDead = true
end)

AddEventHandler('esx:onPlayerSpawn', function(spawn)
    IsDead = false
end)

function SetDisplay(bool, img)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = 'showImage',
        image = img,
        status = bool,
    })
end

function ShowImage(img)
    if lib.progressCircle({
        duration = 500,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    })
    then
        SetDisplay(true, img)
    end
end

exports('ShowImage', ShowImage)

RegisterNUICallback('ShowImageCallback', function(data, cb)
    SetDisplay(false)
    cb('ok')
end)

CreateThread(function()
    for i = 1, #Config.Printers do
        local Printers = Config.Printers[i]
    
        local PrintersId = tostring('PrintPhoto_' .. Printers.Position.x)
        
        exports.ox_target:addBoxZone({
            coords = vec3(Printers.Position.x, Printers.Position.y, Printers.Position.z),
            size = Printers.Size,
            rotation = Printers.Position.w,
            debug = Config.Debug,
            options = {
                {
                    name = PrintersId,
                    event = 'sai_photoprinter:Init',
                    icon = 'fa-solid fa-print',
                    label = 'Print Photo',
                }
            }
        })
    end
end)

RegisterNetEvent('sai_photoprinter:Init', function()
    local Input = lib.inputDialog('Print a Photo', {
        {type = 'input', label = 'Photo Link', description = 'Upload image to discord and paste the link here', required = true},
    })
    
    if not Input then return end

    TriggerServerEvent('sai_photoprinter:InitServer', Input)
end)