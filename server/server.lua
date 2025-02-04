local QBCore = exports['qb-core']:GetCoreObject()

SPRAYS = {}
FastBlacklist = {}

Citizen.CreateThread(function()
    if Config.Blacklist then
        for _, word in pairs(Config.Blacklist) do
            FastBlacklist[word] = word
        end
    end
end)

function GetSprayAtCoords(pos)
    for _, spray in pairs(SPRAYS) do
        if spray.location == pos then
            return spray
        end
    end
end

RegisterNetEvent('RaySist_spray:addSpray')
AddEventHandler('RaySist_spray:addSpray', function(spray)
    local source = source
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local item = xPlayer.Functions.GetItemByName("spray")

    if item then
        xPlayer.Functions.RemoveItem("spray", 1)
        local i = 1
        while true do
            if not SPRAYS[i] then
                SPRAYS[i] = spray
                break
            else
                i = i + 1
            end
        end

        PersistSpray(spray)
        TriggerEvent('RaySist_sprays:addSpray', source, spray.text, spray.location)
        TriggerClientEvent('RaySist_spray:setSprays', -1, SPRAYS)
    else
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div style="background: rgb(180, 136, 29); color: rgb(255, 255, 255); padding: 5px;">{0}</div>',
            args = {Config.Text.NEED_SPRAY}
        })
    end
end)

-- ✅ MAKE SPRAY ITEM USABLE
QBCore.Functions.CreateUseableItem("spray", function(source)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer.Functions.GetItemByName("spray") then
        -- Prompt player for text input (handled on client-side)
        TriggerClientEvent('RaySist_spray:promptSprayText', source)
    end
end)

-- ✅ HANDLE SPRAY INPUT FROM CLIENT
RegisterNetEvent('RaySist_spray:processSpray')
AddEventHandler('RaySist_spray:processSpray', function(sprayText)
    local source = source
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local item = xPlayer.Functions.GetItemByName("spray")

    if item then
        if FastBlacklist[sprayText] then
            TriggerClientEvent('chat:addMessage', source, {
                template = '<div style="background: rgb(180, 136, 29); color: rgb(255, 255, 255); padding: 5px;">{0}</div>',
                args = {Config.Text.BLACKLISTED}
            })
        elseif sprayText and sprayText:len() <= 9 then
            TriggerClientEvent('RaySist_spray:spray', source, sprayText)
        else
            TriggerClientEvent('chat:addMessage', source, {
                template = '<div style="background: rgb(180, 136, 29); color: rgb(255, 255, 255); padding: 5px;">{0}</div>',
                args = {Config.Text.WORD_LONG}
            })
        end
    else
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div style="background: rgb(180, 136, 29); color: rgb(255, 255, 255); padding: 5px;">{0}</div>',
            args = {Config.Text.NEED_SPRAY}
        })
    end
end)

-- ✅ FIXED /SPRAY COMMAND
RegisterCommand('spray', function(source, args)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    local item = xPlayer.Functions.GetItemByName("spray")

    if item then
        local sprayText = args[1]

        if FastBlacklist[sprayText] then
            TriggerClientEvent('chat:addMessage', source, {
                template = '<div style="background: rgb(180, 136, 29); color: rgb(255, 255, 255); padding: 5px;">{0}</div>',
                args = {Config.Text.BLACKLISTED}
            })
        elseif sprayText and sprayText:len() <= 9 then
            TriggerClientEvent('RaySist_spray:spray', source, sprayText)
        else
            TriggerClientEvent('chat:addMessage', source, {
                template = '<div style="background: rgb(180, 136, 29); color: rgb(255, 255, 255); padding: 5px;">{0}</div>',
                args = {Config.Text.WORD_LONG}
            })
        end
    else
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div style="background: rgb(180, 136, 29); color: rgb(255, 255, 255); padding: 5px;">{0}</div>',
            args = {Config.Text.NEED_SPRAY}
        })
    end
end, false)

function PersistSpray(spray)
    MySQL.Async.execute([[
        INSERT INTO sprays
        (`x`, `y`, `z`, `rx`, `ry`, `rz`, `scale`, `text`, `font`, `color`, `interior`)
        VALUES
        (@x, @y, @z, @rx, @ry, @rz, @scale, @text, @font, @color, @interior)
    ]], {
        ['@x'] = spray.location.x,
        ['@y'] = spray.location.y,
        ['@z'] = spray.location.z,
        ['@rx'] = spray.realRotation.x,
        ['@ry'] = spray.realRotation.y,
        ['@rz'] = spray.realRotation.z,
        ['@scale'] = spray.scale,
        ['@text'] = spray.text,
        ['@font'] = spray.font,
        ['@color'] = spray.originalColor,
        ['@interior'] = spray.interior,
    })
end
