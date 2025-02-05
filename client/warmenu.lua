WarMenu = { }

WarMenu.debug = false

-- Modern styling constants
local COLORS = {
    PRIMARY = {r = 66, g = 135, b = 245, a = 255},      -- Modern blue
    SECONDARY = {r = 45, g = 45, b = 45, a = 255},      -- Dark grey
    TEXT = {r = 255, g = 255, b = 255, a = 255},        -- White
    TEXT_DISABLED = {r = 160, g = 160, b = 160, a = 255}, -- Light grey
    BACKGROUND = {r = 18, g = 18, b = 18, a = 230},     -- Almost black with transparency
    HIGHLIGHT = {r = 66, g = 135, b = 245, a = 20}      -- Subtle blue highlight
}

local FONTS = {
    TITLE = 4,      -- Modern title font
    OPTION = 4      -- Clean option font
}

local SIZES = {
    TITLE_HEIGHT = 0.11,
    TITLE_YOFFSET = 0.03,
    TITLE_SCALE = 1.0,
    BUTTON_HEIGHT = 0.038,
    BUTTON_SCALE = 0.365,
    BUTTON_TEXT_XOFFSET = 0.005,
    BUTTON_TEXT_YOFFSET = 0.005
}

local menus = { }
local keys = { up = 188, down = 187, left = 189, right = 190, select = 201, back = 202 }
local optionCount = 0

local currentKey = nil
local currentMenu = nil

local function debugPrint(text)
    if WarMenu.debug then
        Citizen.Trace('[WarMenu] '..tostring(text))
    end
end

local function setMenuProperty(id, property, value)
    if id and menus[id] then
        menus[id][property] = value
        debugPrint(id..' menu property changed: { '..tostring(property)..', '..tostring(value)..' }')
    end
end

local function isMenuVisible(id)
    if id and menus[id] then
        return menus[id].visible
    else
        return false
    end
end

local function setMenuVisible(id, visible, holdCurrent)
    if id and menus[id] then
        setMenuProperty(id, 'visible', visible)

        if not holdCurrent and menus[id] then
            setMenuProperty(id, 'currentOption', 1)
        end

        if visible then
            if id ~= currentMenu and isMenuVisible(currentMenu) then
                setMenuVisible(currentMenu, false)
            end
            currentMenu = id
        end
    end
end

local function drawText(text, x, y, font, color, scale, center, shadow, alignRight)
    SetTextColour(color.r, color.g, color.b, color.a)
    SetTextFont(font)
    SetTextScale(scale, scale)

    if shadow then
        SetTextDropShadow(2, 2, 0, 0, 0)
    end

    local menu = menus[currentMenu]
    if menu then
        if center then
            SetTextCentre(center)
        elseif alignRight then
            SetTextWrap(menu.x, menu.x + menu.width - SIZES.BUTTON_TEXT_XOFFSET)
            SetTextRightJustify(true)
        end
    end

    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(tostring(text))
    EndTextCommandDisplayText(x, y)
end

local function drawRect(x, y, width, height, color)
    DrawRect(x, y, width, height, color.r, color.g, color.b, color.a)
end

local function drawTitle()
    local menu = menus[currentMenu]
    if menu then
        local x = menu.x + menu.width / 2
        local y = menu.y + SIZES.TITLE_HEIGHT / 2

        -- Draw title background with a subtle gradient effect
        drawRect(x, y, menu.width, SIZES.TITLE_HEIGHT, menu.titleBackgroundColor)
        drawRect(x, y + SIZES.TITLE_HEIGHT/2 - 0.002, menu.width, 0.002, COLORS.PRIMARY)

        drawText(menu.title, x, y - SIZES.TITLE_HEIGHT/2 + SIZES.TITLE_YOFFSET,
                menu.titleFont, menu.titleColor, SIZES.TITLE_SCALE, true)
    end
end

local function drawSubTitle()
    local menu = menus[currentMenu]
    if menu then
        local x = menu.x + menu.width / 2
        local y = menu.y + SIZES.TITLE_HEIGHT + SIZES.BUTTON_HEIGHT / 2

        drawRect(x, y, menu.width, SIZES.BUTTON_HEIGHT, menu.subTitleBackgroundColor)
        drawText(menu.subTitle, menu.x + SIZES.BUTTON_TEXT_XOFFSET,
                y - SIZES.BUTTON_HEIGHT/2 + SIZES.BUTTON_TEXT_YOFFSET,
                FONTS.OPTION, COLORS.TEXT, SIZES.BUTTON_SCALE, false)

        if optionCount > menu.maxOptionCount then
            drawText(tostring(menu.currentOption)..' / '..tostring(optionCount),
                    menu.x + menu.width, y - SIZES.BUTTON_HEIGHT/2 + SIZES.BUTTON_TEXT_YOFFSET,
                    FONTS.OPTION, COLORS.TEXT_DISABLED, SIZES.BUTTON_SCALE, false, false, true)
        end
    end
end

local function drawButton(text, subText, options)
    local menu = menus[currentMenu]
    local x = menu.x + menu.width / 2
    local multiplier = nil

    if menu.currentOption <= menu.maxOptionCount and optionCount <= menu.maxOptionCount then
        multiplier = optionCount
    elseif optionCount > menu.currentOption - menu.maxOptionCount and optionCount <= menu.currentOption then
        multiplier = optionCount - (menu.currentOption - menu.maxOptionCount)
    end

    if multiplier then
        local y = menu.y + SIZES.TITLE_HEIGHT + SIZES.BUTTON_HEIGHT +
                 (SIZES.BUTTON_HEIGHT * multiplier) - SIZES.BUTTON_HEIGHT / 2
        local backgroundColor = nil
        local textColor = nil
        local subTextColor = nil
        local shadow = false

        if menu.currentOption == optionCount then
            backgroundColor = menu.menuFocusBackgroundColor
            textColor = menu.menuFocusTextColor
            subTextColor = menu.menuFocusTextColor
            -- Add highlight effect for selected item
            drawRect(x, y, menu.width, SIZES.BUTTON_HEIGHT, COLORS.HIGHLIGHT)
        else
            backgroundColor = menu.menuBackgroundColor
            textColor = menu.menuTextColor
            subTextColor = menu.menuSubTextColor
            shadow = true
        end

        drawRect(x, y, menu.width, SIZES.BUTTON_HEIGHT, backgroundColor)
        drawText(text, menu.x + SIZES.BUTTON_TEXT_XOFFSET,
                y - (SIZES.BUTTON_HEIGHT/2) + SIZES.BUTTON_TEXT_YOFFSET,
                FONTS.OPTION, textColor, SIZES.BUTTON_SCALE, false, shadow)

        if subText then
            drawText(subText, menu.x + SIZES.BUTTON_TEXT_XOFFSET,
                    y - SIZES.BUTTON_HEIGHT/2 + SIZES.BUTTON_TEXT_YOFFSET,
                    0, -- Changed from FONTS.OPTION to 0
                    subTextColor, SIZES.BUTTON_SCALE, false, shadow, true)
        elseif options and options.color then
            local ySize = 0.03
            local xSize = ySize * 1/GetAspectRatio()
            local xOffset = menu.width - 1.5 * xSize
            local yOffset = SIZES.BUTTON_TEXT_YOFFSET + 0.014

            DrawRect(
                menu.x + xOffset, y - SIZES.BUTTON_HEIGHT / 2 + yOffset,
                xSize, ySize,
                options.color[1], options.color[2], options.color[3], 255
            )

            local arrowCenterOffset = menu.width - 1.9*xSize
            local boxOffset = xSize

            drawText('←', menu.x + arrowCenterOffset - boxOffset,
         y - SIZES.BUTTON_HEIGHT / 2 + SIZES.BUTTON_TEXT_YOFFSET,
         0, -- Change the font
         subTextColor, SIZES.BUTTON_SCALE, false, shadow)

            drawText('→', menu.x + arrowCenterOffset + boxOffset,
                    y - SIZES.BUTTON_HEIGHT / 2 + SIZES.BUTTON_TEXT_YOFFSET,
                    0, subTextColor, SIZES.BUTTON_SCALE, false, shadow)
        end
    end
end

function WarMenu.CreateMenu(id, title)
    menus[id] = {
        -- Basic Properties
        title = title,
        subTitle = 'INTERACTION MENU',
        visible = false,
        previousMenu = nil,
        aboutToBeClosed = false,

        -- Position and Size
        x = 0.015,
        y = 0.12,
        width = 0.23,

        -- Navigation
        currentOption = 1,
        maxOptionCount = 10,

        -- Style - Title
        titleFont = FONTS.TITLE,
        titleColor = COLORS.TEXT,
        titleBackgroundColor = COLORS.BACKGROUND,

        -- Style - Menu
        menuTextColor = COLORS.TEXT,
        menuSubTextColor = COLORS.TEXT_DISABLED,
        menuFocusTextColor = COLORS.PRIMARY,
        menuFocusBackgroundColor = COLORS.SECONDARY,
        menuBackgroundColor = COLORS.BACKGROUND,
        subTitleBackgroundColor = COLORS.SECONDARY,

        -- Sound
        buttonPressedSound = {
            name = "SELECT",
            set = "HUD_FRONTEND_DEFAULT_SOUNDSET"
        }
    }

    debugPrint(tostring(id)..' menu created')
end

function WarMenu.CreateSubMenu(id, parent, subTitle)
    if menus[parent] then
        WarMenu.CreateMenu(id, menus[parent].title)

        if subTitle then
            setMenuProperty(id, 'subTitle', string.upper(subTitle))
        else
            setMenuProperty(id, 'subTitle', string.upper(menus[parent].subTitle))
        end

        setMenuProperty(id, 'previousMenu', parent)
        setMenuProperty(id, 'x', menus[parent].x)
        setMenuProperty(id, 'y', menus[parent].y)
        setMenuProperty(id, 'maxOptionCount', menus[parent].maxOptionCount)
        setMenuProperty(id, 'titleFont', menus[parent].titleFont)
        setMenuProperty(id, 'titleColor', menus[parent].titleColor)
        setMenuProperty(id, 'titleBackgroundColor', menus[parent].titleBackgroundColor)
        setMenuProperty(id, 'titleBackgroundSprite', menus[parent].titleBackgroundSprite)
        setMenuProperty(id, 'menuTextColor', menus[parent].menuTextColor)
        setMenuProperty(id, 'menuSubTextColor', menus[parent].menuSubTextColor)
        setMenuProperty(id, 'menuFocusTextColor', menus[parent].menuFocusTextColor)
        setMenuProperty(id, 'menuFocusBackgroundColor', menus[parent].menuFocusBackgroundColor)
        setMenuProperty(id, 'menuBackgroundColor', menus[parent].menuBackgroundColor)
        setMenuProperty(id, 'subTitleBackgroundColor', menus[parent].subTitleBackgroundColor)
    else
        debugPrint('Failed to create '..tostring(id)..' submenu: '..tostring(parent)..' parent menu doesn\'t exist')
    end
end

function WarMenu.CurrentMenu()
    return currentMenu
end

function WarMenu.OpenMenu(id)
    if id and menus[id] then
        PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
        setMenuVisible(id, true)
        debugPrint(tostring(id)..' menu opened')
    else
        debugPrint('Failed to open '..tostring(id)..' menu: it doesn\'t exist')
    end
end

function WarMenu.IsMenuOpened(id)
    return isMenuVisible(id)
end

function WarMenu.IsAnyMenuOpened()
    for id, _ in pairs(menus) do
        if isMenuVisible(id) then return true end
    end
    return false
end

function WarMenu.IsMenuAboutToBeClosed()
    local menu = menus[currentMenu]
    if menu then
        return menu.aboutToBeClosed
    else
        return false
    end
end

function WarMenu.CloseMenu()
    local menu = menus[currentMenu]
    if menu then
        if menu.aboutToBeClosed then
            menu.aboutToBeClosed = false
            setMenuVisible(currentMenu, false)
            debugPrint(tostring(currentMenu)..' menu closed')
            PlaySoundFrontend(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
            optionCount = 0
            currentMenu = nil
            currentKey = nil
        else
            menu.aboutToBeClosed = true
            debugPrint(tostring(currentMenu)..' menu about to be closed')
        end
    end
end

function WarMenu.Button(text, subText, activeCb, options)
    local buttonText = text
    if subText then
        buttonText = '{ '..tostring(buttonText)..', '..tostring(subText)..' }'
    end

    if menus[currentMenu] then
        optionCount = optionCount + 1
        local isCurrent = menus[currentMenu].currentOption == optionCount

        drawButton(text, subText, options)

        if isCurrent then
            if currentKey == keys.select then
                PlaySoundFrontend(-1, menus[currentMenu].buttonPressedSound.name,
                                menus[currentMenu].buttonPressedSound.set, true)
                debugPrint(buttonText..' button pressed')
                return true
            elseif currentKey == keys.left or currentKey == keys.right then
                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
            else
                if activeCb then
                    activeCb()
                end
            end
        end

        return false
    else
        debugPrint('Failed to create '..buttonText..' button: '..tostring(currentMenu)..' menu doesn\'t exist')
        return false
    end
end

function WarMenu.ColorSelector(text, items, index, callback, currentCallback)
    local itemsCount = #items
    local selectedItem = items[index]
    local isCurrent = menus[currentMenu].currentOption == (optionCount + 1)

    if WarMenu.Button(text, nil, nil, {color = selectedItem}) then
        callback(index)
        return true
    elseif isCurrent then
        if currentCallback then
            currentCallback()
        end
        if currentKey == keys.left then
            if index > 1 then index = index - 1 else index = itemsCount end
        elseif currentKey == keys.right then
            if index < itemsCount then index = index + 1 else index = 1 end
        end
    end

    callback(index)
    return false
end

function WarMenu.MenuButton(text, id, subText)
    if menus[id] then
        if WarMenu.Button(text, subText) then
            setMenuVisible(currentMenu, false)
            setMenuVisible(id, true, true)
            return true
        end
    else
        debugPrint('Failed to create '..tostring(text)..' menu button: '..tostring(id)..' submenu doesn\'t exist')
    end
    return false
end

function WarMenu.CheckBox(text, checked, callback)
    if WarMenu.Button(text, checked and 'On' or 'Off') then
        checked = not checked
        debugPrint(tostring(text)..' checkbox changed to '..tostring(checked))
        if callback then callback(checked) end
        return true
    end
    return false
end

function WarMenu.ComboBox(text, items, currentIndex, selectedIndex, callback)
    local itemsCount = #items
    local selectedItem = items[currentIndex]
    local isCurrent = menus[currentMenu].currentOption == (optionCount + 1)

    if itemsCount > 1 and isCurrent then
        selectedItem = '← '..tostring(selectedItem)..' →'
    end

    if WarMenu.Button(text, selectedItem) then
        selectedIndex = currentIndex
        callback(currentIndex, selectedIndex)
        return true
    elseif isCurrent then
        if currentKey == keys.left then
            if currentIndex > 1 then currentIndex = currentIndex - 1 else currentIndex = itemsCount end
        elseif currentKey == keys.right then
            if currentIndex < itemsCount then currentIndex = currentIndex + 1 else currentIndex = 1 end
        end
    else
        currentIndex = selectedIndex
    end

    callback(currentIndex, selectedIndex)
    return false
end

function WarMenu.Display()
    if isMenuVisible(currentMenu) then
        DisableControlAction(0, keys.left, true)
        DisableControlAction(0, keys.up, true)
        DisableControlAction(0, keys.down, true)
        DisableControlAction(0, keys.right, true)
        DisableControlAction(0, keys.back, true)
        DisableControlAction(0, keys.select, true)

        local menu = menus[currentMenu]

        if menu.aboutToBeClosed then
            WarMenu.CloseMenu()
        else
            ClearAllHelpMessages()
            drawTitle()
            drawSubTitle()
            currentKey = nil

            if IsDisabledControlJustReleased(0, keys.down) then
                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
                if menu.currentOption < optionCount then
                    menu.currentOption = menu.currentOption + 1
                else
                    menu.currentOption = 1
                end
            elseif IsDisabledControlJustReleased(0, keys.up) then
                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
                if menu.currentOption > 1 then
                    menu.currentOption = menu.currentOption - 1
                else
                    menu.currentOption = optionCount
                end
            elseif IsDisabledControlJustReleased(0, keys.left) then
                currentKey = keys.left
            elseif IsDisabledControlJustReleased(0, keys.right) then
                currentKey = keys.right
            elseif IsDisabledControlJustReleased(0, keys.select) then
                currentKey = keys.select
            elseif IsDisabledControlJustReleased(0, keys.back) then
                if menus[menu.previousMenu] then
                    PlaySoundFrontend(-1, "BACK", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
                    setMenuVisible(menu.previousMenu, true)
                else
                    WarMenu.CloseMenu()
                end
            end

            optionCount = 0
        end
    end
end

function WarMenu.CurrentOption()
    if currentMenu and optionCount ~= 0 and menus[currentMenu] then
        return menus[currentMenu].currentOption
    end
    return nil
end

function WarMenu.SetMenuWidth(id, width)
    setMenuProperty(id, 'width', width)
end

function WarMenu.SetMenuX(id, x)
    setMenuProperty(id, 'x', x)
end

function WarMenu.SetMenuY(id, y)
    setMenuProperty(id, 'y', y)
end

function WarMenu.SetMenuMaxOptionCountOnScreen(id, count)
    setMenuProperty(id, 'maxOptionCount', count)
end

function WarMenu.SetTitle(id, title)
    setMenuProperty(id, 'title', title)
end

function WarMenu.SetTitleColor(id, r, g, b, a)
    setMenuProperty(id, 'titleColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].titleColor.a })
end

function WarMenu.SetTitleBackgroundColor(id, r, g, b, a)
    setMenuProperty(id, 'titleBackgroundColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].titleBackgroundColor.a })
end

function WarMenu.SetTitleBackgroundSprite(id, textureDict, textureName)
    RequestStreamedTextureDict(textureDict)
    setMenuProperty(id, 'titleBackgroundSprite', { dict = textureDict, name = textureName })
end

function WarMenu.SetSubTitle(id, text)
    setMenuProperty(id, 'subTitle', string.upper(text))
end

function WarMenu.SetMenuBackgroundColor(id, r, g, b, a)
    setMenuProperty(id, 'menuBackgroundColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].menuBackgroundColor.a })
end

function WarMenu.SetMenuTextColor(id, r, g, b, a)
    setMenuProperty(id, 'menuTextColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].menuTextColor.a })
end

function WarMenu.SetMenuSubTextColor(id, r, g, b, a)
    setMenuProperty(id, 'menuSubTextColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].menuSubTextColor.a })
end

function WarMenu.SetMenuFocusColor(id, r, g, b, a)
    setMenuProperty(id, 'menuFocusColor', { ['r'] = r, ['g'] = g, ['b'] = b, ['a'] = a or menus[id].menuFocusColor.a })
end

function WarMenu.SetMenuButtonPressedSound(id, name, set)
    setMenuProperty(id, 'buttonPressedSound', { ['name'] = name, ['set'] = set })
end

return WarMenu
