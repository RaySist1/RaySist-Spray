local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("spray_remover", function(source)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    local item = Player.Functions.GetItemByName("spray_remover")
    if item then
        TriggerClientEvent('RaySist-spray:removeClosestSpray', source)
        TriggerClientEvent('QBCore:Notify', source, 'Stai rimuovendo lo spray!', "success")
    else
        TriggerClientEvent('QBCore:Notify', source, 'Non hai un kit per rimuovere lo spray!', "error")
    end
end)


RegisterNetEvent('RaySist-spray:remove')
AddEventHandler('RaySist-spray:remove', function(pos)
    local Source = source

    local xPlayer = QBCore.Functions.GetPlayer(Source)
    local item = xPlayer.Functions.GetItemByName("spray_remover")

    if item then
        xPlayer.Functions.RemoveItem("spray_remover", 1)
        local sprayAtCoords = GetSprayAtCoords(pos)

        MySQL.Async.execute([[
            DELETE FROM sprays WHERE x=@x AND y=@y AND z=@z LIMIT 1
        ]], {
            ['@x'] = pos.x,
            ['@y'] = pos.y,
            ['@z'] = pos.z,
        })

        for idx, s in pairs(SPRAYS) do
            if s.location.x == pos.x and s.location.y == pos.y and s.location.z == pos.z then
                SPRAYS[idx] = nil
            end
        end
        TriggerClientEvent('RaySist-spray:setSprays', -1, SPRAYS)

        local sprayAtCoordsAfterRemoval = GetSprayAtCoords(pos)

        -- ensure someone doesnt bug it so its trying to remove other tags
        -- while deducting loyalty from not-deleted-but-at-coords tag
        if sprayAtCoords and not sprayAtCoordsAfterRemoval then
            TriggerEvent('RaySist-sprays:removeSpray', Source, sprayAtCoords.text, sprayAtCoords.location)
        end
    end
end)
