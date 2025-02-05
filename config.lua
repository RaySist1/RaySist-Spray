--[[
    RaySist-Spray
    Author: RaySist
    Version: 1.0.1
]]

Config = {
    License = 'RaySist',

    SPRAY_PERSIST_DAYS = 2,
    SPRAY_PROGRESSBAR_DURATION = 20000,
    SPRAY_REMOVE_DURATION = 30000,

    Keys = {
        CANCEL = {code = 177, label = 'INPUT_CELLPHONE_CANCEL'},
    },

    Blacklist = {
        'nigger',
        'negro',
        'nebro',
        'nigga',
        'nibba',
        'diocane',
        'dioporco',
        'ritardato',
        'kordian',
        'n1bba',
        'n1gga',
        'comunista',
        'comunismo',
        'hitler',
        'mussolini',
        'duce',
        'stalin',
        'maozedong',
        'putin',
        'niger'
    },

    Text = {
        CANCEL = 'Annuller',
        MENU = {
            TITLE = 'RaySist-Spray',
            SUBTITLE = 'SPRAYINDSTILLINGER',
            FONTS = 'Font',
            COLOR = 'Farve',
            SIZE = 'Størrelse',
            SPRAY = 'Spray!'
        },
        SPRAY_ERRORS = {
            NOT_FLAT = 'Overfladen er ikke flad nok',
            TOO_FAR = 'Overfladen er for langt væk',
            INVALID_SURFACE = 'Du kan ikke bruge sprayen på denne overflade',
            AIM = 'Ret sprayen mod en flad væg',
        },
        NO_SPRAY_NEARBY = 'Der er ingen spray at fjerne',
        NEED_SPRAY = 'Du har ikke en spraydåse',
        WORD_LONG = 'Ordet kan være op til 9 tegn langt',
        USAGE = 'Anvendelse: /spray <ord>',
        BLACKLISTED = 'Dette ord er blacklisted.'
    }
}

FONTS = {
    {
        font = 'graffiti1',
        label = 'Next Custom',
        allowed = '^[A-Z0-9\\-.]+$',
        forceUppercase = true,
        allowedInverse = '[^A-Z0-9\\-.]+',
        sizeMult = 0.70
    },
    {
        font = 'graffiti2',
        label = 'Dripping Marker',
        allowed = '^[A-Za-z0-9\\-.$+-*/=%"\'#@&();:,<>!_~]+$',
        allowedInverse = '[^A-Za-z0-9\\-.$+-*/=%"\'#@&();:,<>!_~]+',
        sizeMult = 0.5
    },
    {
        font = 'graffiti3',
        label = 'Docallisme',
        allowed = '^[A-Z]+$',
        forceUppercase = true,
        allowedInverse = '[^A-Z]+',
        sizeMult = 1.45
    },
    {
        font = 'graffiti4',
        label = 'Fat Wandals',
        allowed = '^[A-Za-z\\-.$+-*/=%"\'#@&();:,<>!_~]+$',
        allowedInverse = '[^A-Za-z\\-.$+-*/=%"\'#@&();:,<>!_~]+',
        sizeMult = 0.3
    },
    {
        font = 'graffiti5',
        label = 'Sister Spray',
        allowed = '^[A-Z0-9]+$',
        forceUppercase = true,
        allowedInverse = '[^A-Z0-9]+',
        sizeMult = 0.3
    },
    {
        font = 'PricedownGTAVInt',
        label = 'Pricedown',
        allowed = '^[A-Za-z0-9]+$',
        allowedInverse = '[^A-Za-z0-9]+',
        sizeMult = 0.75
    },
    {
        font = 'Chalet-LondonNineteenSixty',
        label = 'Chalet',
        allowed = '^[A-Za-z0-9]+$',
        allowedInverse = '[^A-Za-z0-9]+',
        sizeMult = 0.6
    },
    {
        font = 'SignPainter-HouseScript',
        label = 'Sign Painter',
        allowed = '^[A-Za-z0-9]+$',
        allowedInverse = '[^A-Za-z0-9]+',
        sizeMult = 0.85
    }
}

COLORS = {
    {
        basic = 'WHITE',
        color = { hex = 'ffffff', rgb = {255, 255, 255}, alpha = 0.7 },
        colorDawn = { hex = 'f2e6d6', rgb = {242, 230, 214}, alpha = 0.7 },  -- Warmer sunrise tint
        colorDusk = { hex = 'd9cfc4', rgb = {217, 207, 196}, alpha = 0.7 },
        colorDarkest = { hex = '666666', rgb = {102, 102, 102}, alpha = 0.7 }
    },
    {
        basic = 'BLACK',
        color = { hex = '000000', rgb = {0, 0, 0}, alpha = 1.0 },
        colorDawn = { hex = '1a1a1a', rgb = {26, 26, 26}, alpha = 0.9 },
        colorDusk = { hex = '0d0d0d', rgb = {13, 13, 13}, alpha = 0.85 },
        colorDarkest = { hex = '000011', rgb = {0, 0, 17}, alpha = 0.7 } -- Slight blue tint at night
    },
    {
        basic = 'NEON_PINK',
        color = { hex = 'ff00ff', rgb = {255, 0, 255}, alpha = 1.0 },
        colorDawn = { hex = 'ff80ff', rgb = {255, 128, 255}, alpha = 0.9 },
        colorDusk = { hex = 'cc00cc', rgb = {204, 0, 204}, alpha = 0.85 },
        colorDarkest = { hex = '660066', rgb = {102, 0, 102}, alpha = 0.7 }
    },
    {
        basic = 'NEON_BLUE',
        color = { hex = '00ffff', rgb = {0, 255, 255}, alpha = 1.0 },
        colorDawn = { hex = '99ffff', rgb = {153, 255, 255}, alpha = 0.9 },
        colorDusk = { hex = '00cccc', rgb = {0, 204, 204}, alpha = 0.85 },
        colorDarkest = { hex = '004466', rgb = {0, 68, 102}, alpha = 0.7 } -- Cooler night blue
    },
    {
        basic = 'PASTEL_PINK',
        color = { hex = 'ffd1dc', rgb = {255, 209, 220}, alpha = 1.0 },
        colorDawn = { hex = 'ffcccc', rgb = {255, 204, 204}, alpha = 0.9 },
        colorDusk = { hex = 'ffb6c1', rgb = {255, 182, 193}, alpha = 0.85 },
        colorDarkest = { hex = 'ff69b4', rgb = {255, 105, 180}, alpha = 0.7 }
    },
    {
        basic = 'SUNSET_ORANGE',
        color = { hex = 'ff7e5f', rgb = {255, 126, 95}, alpha = 1.0 },
        colorDawn = { hex = 'ffa07a', rgb = {255, 160, 122}, alpha = 0.9 },
        colorDusk = { hex = 'ff6947', rgb = {255, 105, 71}, alpha = 0.85 },
        colorDarkest = { hex = 'cc2909', rgb = {204, 41, 9}, alpha = 0.7 }
    },
    {
        basic = 'OCEAN_BLUE',
        color = { hex = '0082c8', rgb = {0, 130, 200}, alpha = 1.0 },
        colorDawn = { hex = '66a3d2', rgb = {102, 163, 210}, alpha = 0.9 },
        colorDusk = { hex = '006699', rgb = {0, 102, 153}, alpha = 0.85 },
        colorDarkest = { hex = '002a4d', rgb = {0, 42, 77}, alpha = 0.7 } -- Deep sea blue at night
    },
    {
        basic = 'GOLD',
        color = { hex = 'ffd700', rgb = {255, 215, 0}, alpha = 1.0 },
        colorDawn = { hex = 'ffcc33', rgb = {255, 204, 51}, alpha = 0.9 },
        colorDusk = { hex = 'ccac00', rgb = {204, 172, 0}, alpha = 0.85 },
        colorDarkest = { hex = '806c00', rgb = {128, 108, 0}, alpha = 0.7 }
    }
}

SIMPLE_COLORS = {}

for idx, c in pairs(COLORS) do
    SIMPLE_COLORS[idx] = c.color.rgb
end
