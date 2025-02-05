Hour = 12

-- Enhanced color selection based on time of day
function GetTimeColorName()
    if Hour >= 5 and Hour < 7 then
        return 'colorDawn'
    elseif Hour >= 7 and Hour < 19 then
        return 'color'
    elseif Hour >= 19 and Hour < 21 then
        return 'colorDusk'
    else
        return 'colorDarkest'
    end
end

-- Apply color transitions with enhanced lighting realism
function SetSprayTimeCorrectColor()
    for _, v in pairs(SPRAYS) do
        Wait(0)

        local baseColor = COLORS[v.originalColor]
        local timeColor = v.interior and baseColor.color or baseColor[GetTimeColorName()]

        if not v.interior then
            if Hour >= 5 and Hour < 7 then
                -- Dawn: Warm soft lighting
                timeColor = {
                    hex = timeColor.hex,
                    alpha = timeColor.alpha * 0.9
                }
            elseif Hour >= 19 and Hour < 21 then
                -- Dusk: Warmer and dimmed
                timeColor = {
                    hex = timeColor.hex,
                    alpha = timeColor.alpha * 0.85
                }
            elseif Hour >= 21 or Hour < 5 then
                -- Night: Darker and cooler shading
                timeColor = {
                    hex = timeColor.hex,
                    alpha = timeColor.alpha * 0.7
                }
            end
        end

        v.color = timeColor.hex
    end
end

-- Main update thread
Citizen.CreateThread(function()
    while true do
        Hour = GetClockHours()
        SetSprayTimeCorrectColor()
        Wait(3000)
    end
end)
