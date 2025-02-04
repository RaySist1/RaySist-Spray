Hour = 12

function GetTimeColorName()
    return (Hour >= 21 or Hour <= 5) and 'colorDarkest'
        or (Hour >= 19 or Hour <= 7) and 'colorDarker'
        or 'color'
end

function SetSprayTimeCorrectColor()
    for _, v in pairs(SPRAYS) do
        Wait(0)

        v.color = COLORS[v.originalColor][v.interior and 'color' or GetTimeColorName()].hex
    end
end

Citizen.CreateThread(function()
    while true do
        Hour = GetClockHours()
        SetSprayTimeCorrectColor()
        Wait(10000)
    end
end)
