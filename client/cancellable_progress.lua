local IsCancelled = false
local LastHp = nil
local IsProgressbarDisplayed = false

local Config = {
    Keys = {
        CANCEL = {
            code = 177, -- X key by default
            label = "Backspace"
        }
    },
    Sound = {
        Name = "spraysound",
        Dict = "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS",
        Volume = 0.5
    },
    Colors = {
        Background = {20, 20, 20, 240},
        Border = {40, 40, 40, 255},
        Progress = {
            Default = {66, 135, 245, 255},
            Cancel = {229, 68, 68, 255}
        }
    },
    Animation = {
        Duration = 400,
        Easing = "easeOutQuart"
    }
}

local State = {
    SoundId = nil
}

local function PlayProgressSound()
    if not State.SoundId then
        State.SoundId = GetSoundId()
        PlaySoundFrontend(State.SoundId, Config.Sound.Name, Config.Sound.Dict, true)
    end
end

local function StopProgressSound()
    if State.SoundId then
        StopSound(State.SoundId)
        ReleaseSoundId(State.SoundId)
        State.SoundId = nil
    end
end

function LoadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(100)
    end
end

function CancellableProgress(time, animDict, animName, flag, finish, cancel, opts)
    IsCancelled = false
    local ped = PlayerPedId()

    opts = opts or {}

    if animDict then
        LoadAnimDict(animDict)
        TaskPlayAnim(ped, animDict, animName, opts.speedIn or 1.0, opts.speedOut or 1.0, -1, flag, 0, 0, 0, 0)
    end

    StartCancellableProgressBar(time)
    PlayProgressSound()
    LastHp = GetEntityHealth(ped)

    local timeLeft = time

    while true do
        Wait(0)
        timeLeft = timeLeft - (GetFrameTime() * 1000)

        if timeLeft <= 0 then
            break
        end

        local newHp = GetEntityHealth(ped)
        if newHp ~= LastHp then
            IsCancelled = true
        end

        LastHp = newHp

        DisableControlAction(0, Config.Keys.CANCEL.code, true)
        if IsControlPressed(0, Config.Keys.CANCEL.code) or IsDisabledControlPressed(0, Config.Keys.CANCEL.code) then
            IsCancelled = true
        end

        if IsCancelled then
            if animDict then
                ClearPedTasks(ped)
            end

            StopProgressSound()
            StopCancellableProgressBar()
            if cancel then
                cancel()
            end
            return
        end
    end

    StopProgressSound()

    if animDict then
        StopAnimTask(ped, animDict, animName, 1.0)
    end

    if finish then
        finish()
    end
end

function StartCancellableProgressBar(time)
    IsProgressbarDisplayed = true
    local curProgressWidth = 0.0
    time = time / 1000

    Citizen.CreateThread(function()
        while IsProgressbarDisplayed and curProgressWidth < 1.0 do
            Wait(0)
            curProgressWidth = curProgressWidth + (GetFrameTime() / time)

            -- Draw Background
            DrawRect(0.5, 0.85, 0.3 + 0.002 * 2, 0.03 + 0.002 * 2, table.unpack(Config.Colors.Border))
            DrawRect(0.5, 0.85, 0.3, 0.03, table.unpack(Config.Colors.Background))

            -- Draw Progress
            local color = IsCancelled and Config.Colors.Progress.Cancel or Config.Colors.Progress.Default
            DrawRect(0.5 - (0.3 * 0.5) + (0.3 * curProgressWidth * 0.5), 0.85, 0.3 * curProgressWidth, 0.03 - 0.002, table.unpack(color))

            -- Draw Percentage Text
            SetTextFont(4)
            SetTextScale(0.0, 0.4)
            SetTextColour(255, 255, 255, 255)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextDropShadow()
            SetTextOutline()
            SetTextCentre(true)
            SetTextEntry("STRING")
            AddTextComponentString(IsCancelled and "CANCELLED" or math.floor(curProgressWidth * 100) .. "%")
            DrawText(0.5, 0.8)

            -- Draw Cancel Text
            SetTextFont(4)
            SetTextScale(0.0, 0.35)
            SetTextColour(200, 200, 200, 255)
            SetTextCentre(true)
            SetTextEntry("PROGRESS_CANCEL")
            DrawText(0.5, 0.9)
        end
    end)
end

function StopCancellableProgressBar()
    IsProgressbarDisplayed = false
end

Citizen.CreateThread(function()
    AddTextEntry('PROGRESS_CANCEL', "Press ~r~" .. Config.Keys.CANCEL.label .. "~s~ to cancel")
end)
