-- Modern Progress Bar with Sound
-- Configuration
local Config = {
    Keys = {
        CANCEL = {
            code = 73,     -- X key by default
            label = "X"    -- Label shown in the UI
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
            Default = {66, 135, 245, 255},  -- Modern green
            Cancel = {229, 68, 68, 255}     -- Modern red
        }
    },
    Animation = {
        Duration = 400,    -- ms
        Easing = "easeOutQuart"
    }
}

-- State Management
local State = {
    IsCancelled = false,
    IsProgressbarDisplayed = false,
    LastHp = nil,
    SoundId = nil
}

-- Sound Management
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

-- Animation Dictionary Loader
local function LoadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(100)
    end
end

-- Modern Progress Bar UI
local function DrawModernProgressBar(progress, isCancelled)
    local screenW, screenH = GetActiveScreenResolution()
    local maxWidth = 0.3
    local height = 0.03
    local border = 0.002
    local x, y = 0.5, 0.95

    -- Background
    DrawRect(
        x, y,
        maxWidth + (border * 2), height + (border * 2),
        table.unpack(Config.Colors.Border)
    )

    DrawRect(
        x, y,
        maxWidth, height,
        table.unpack(Config.Colors.Background)
    )

    -- Progress Bar
    local color = isCancelled and Config.Colors.Progress.Cancel or Config.Colors.Progress.Default
    DrawRect(
        x - (maxWidth * 0.5) + (maxWidth * progress * 0.5), y,
        maxWidth * progress, height - border,
        table.unpack(color)
    )

    -- Text
    SetTextFont(4)
    SetTextScale(0.0, 0.4)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(true)
    SetTextEntry("STRING")
    AddTextComponentString(isCancelled and "CANCELLED" or math.floor(progress * 100) .. "%")
    DrawText(x, y - 0.05)

    -- Cancel Text
    SetTextFont(4)
    SetTextScale(0.0, 0.35)
    SetTextColour(200, 200, 200, 255)
    SetTextCentre(true)
    SetTextEntry("PROGRESS_CANCEL")
    DrawText(x, y + 0.05)
end

function CancellableProgress(time, animDict, animName, flag, finish, cancel, opts)
    State.IsCancelled = false
    local ped = PlayerPedId()
    opts = opts or {}

    -- Animation Setup
    if animDict then
        LoadAnimDict(animDict)
        TaskPlayAnim(ped, animDict, animName, opts.speedIn or 1.0, opts.speedOut or 1.0, -1, flag, 0, 0, 0, 0)
    end

    -- Initialize Progress Bar
    State.IsProgressbarDisplayed = true
    State.LastHp = GetEntityHealth(ped)
    PlayProgressSound()

    -- Main Progress Loop
    local startTime = GetGameTimer()
    local endTime = startTime + time

    Citizen.CreateThread(function()
        while GetGameTimer() < endTime and State.IsProgressbarDisplayed do
            Citizen.Wait(0)
            local now = GetGameTimer()
            local progress = math.min((now - startTime) / time, 1.0)

            -- Health Check
            local newHp = GetEntityHealth(ped)
            if newHp ~= State.LastHp then
                State.IsCancelled = true
            end
            State.LastHp = newHp

            -- Cancel Check
            DisableControlAction(0, Config.Keys.CANCEL.code, true)
            if IsControlPressed(0, Config.Keys.CANCEL.code) or IsDisabledControlPressed(0, Config.Keys.CANCEL.code) then
                State.IsCancelled = true
            end

            -- Draw UI
            DrawModernProgressBar(progress, State.IsCancelled)

            -- Handle Cancellation
            if State.IsCancelled then
                if animDict then
                    ClearPedTasks(ped)
                end

                StopProgressSound()
                State.IsProgressbarDisplayed = false

                if cancel then
                    cancel()
                end
                return
            end
        end

        -- Cleanup
        State.IsProgressbarDisplayed = false
        StopProgressSound()

        if animDict then
            StopAnimTask(ped, animDict, animName, 1.0)
        end

        if finish and not State.IsCancelled then
            finish()
        end
    end)
end

-- Register Cancel Text Command
Citizen.CreateThread(function()
    AddTextEntry('PROGRESS_CANCEL', "Press ~r~" .. Config.Keys.CANCEL.label .. "~s~ to cancel")
end)

-- Exposed API Functions
function StartCancellableProgressBar(time)
    CancellableProgress(time)
end

function StopCancellableProgressBar()
    State.IsProgressbarDisplayed = false
    StopProgressSound()
end
