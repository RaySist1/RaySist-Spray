Config = {
    License = '',

    SPRAY_ITEM = 'spray',

    SPRAY_PERSIST_DAYS = 2,
    SPRAY_PROGRESSBAR_DURATION = 8000,
    SPRAY_REMOVE_DURATION = 15000,

    UI = {
        FONT = 'Roboto',
        PRIMARY_COLOR = '#3b82f6',
        SECONDARY_COLOR = '#1e40af',
        BACKGROUND_COLOR = '#1f2937',
        TEXT_COLOR = '#ffffff'
    },

    Keys = {
        CANCEL = {code = 23, label = 'INPUT_ENTER'},
    },

    Text = {
        CANCEL = 'Cancel',
        MENU = {
            TITLE = 'RaySist-Spray',
            SUBTITLE = 'SPRAY SETTINGS',
            FONTS = 'Font Style',
            COLOR = 'Color',
            SIZE = 'Size',
            SPRAY = 'Confirm'
        },
        SPRAY_ERRORS = {
            NOT_FLAT = 'Surface is not flat enough',
            TOO_FAR = 'Surface is too far away',
            INVALID_SURFACE = 'Cannot spray on this surface',
            AIM = 'Aim at a flat wall',
        },
        NO_SPRAY_NEARBY = 'No graffiti nearby to remove',
        NEED_SPRAY = 'You need a spray can',
        WORD_LONG = 'Text can be up to 9 characters long',
        USAGE = 'Use /spray to start',
        BLACKLISTED = 'This text is not allowed.'
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
    -- Standard Colors
    {
        basic = 'WHITE',
        color = {
            hex = 'ffffff',
            rgb = {255, 255, 255},
        },
        colorDarker = {
            hex = 'b3b3b3',
            rgb = {179, 179, 179},
        },
        colorDarkest = {
            hex = '4d4d4d',
            rgb = {77, 77, 77},
        },
    },
    {
        basic = 'BLACK',
        color = {
            hex = '000000',
            rgb = {0, 0, 0},
        },
        colorDarker = {
            hex = '333333',
            rgb = {51, 51, 51},
        },
        colorDarkest = {
            hex = '1a1a1a',
            rgb = {26, 26, 26},
        },
    },
    {
        basic = 'RED',
        color = {
            hex = 'ff0000',
            rgb = {255, 0, 0},
        },
        colorDarker = {
            hex = 'b30000',
            rgb = {179, 0, 0},
        },
        colorDarkest = {
            hex = '800000',
            rgb = {128, 0, 0},
        },
    },
    {
        basic = 'GREEN',
        color = {
            hex = '00ff00',
            rgb = {0, 255, 0},
        },
        colorDarker = {
            hex = '00b300',
            rgb = {0, 179, 0},
        },
        colorDarkest = {
            hex = '008000',
            rgb = {0, 128, 0},
        },
    },
    {
        basic = 'BLUE',
        color = {
            hex = '0000ff',
            rgb = {0, 0, 255},
        },
        colorDarker = {
            hex = '0000b3',
            rgb = {0, 0, 179},
        },
        colorDarkest = {
            hex = '000080',
            rgb = {0, 0, 128},
        },
    },
    {
        basic = 'YELLOW',
        color = {
            hex = 'ffff00',
            rgb = {255, 255, 0},
        },
        colorDarker = {
            hex = 'b3b300',
            rgb = {179, 179, 0},
        },
        colorDarkest = {
            hex = '808000',
            rgb = {128, 128, 0},
        },
    },
    {
        basic = 'ORANGE',
        color = {
            hex = 'ffa500',
            rgb = {255, 165, 0},
        },
        colorDarker = {
            hex = 'b36b00',
            rgb = {179, 107, 0},
        },
        colorDarkest = {
            hex = '804000',
            rgb = {128, 64, 0},
        },
    },

    -- Metallic Colors
    {
        basic = 'GOLD',
        color = {
            hex = 'ffd700',
            rgb = {255, 215, 0},
        },
        colorDarker = {
            hex = 'cc9e00',
            rgb = {204, 158, 0},
        },
        colorDarkest = {
            hex = '997300',
            rgb = {153, 115, 0},
        },
    },
    {
        basic = 'SILVER',
        color = {
            hex = 'c0c0c0',
            rgb = {192, 192, 192},
        },
        colorDarker = {
            hex = 'a6a6a6',
            rgb = {166, 166, 166},
        },
        colorDarkest = {
            hex = '808080',
            rgb = {128, 128, 128},
        },
    },
    {
        basic = 'BRONZE',
        color = {
            hex = 'cd7f32',
            rgb = {205, 127, 50},
        },
        colorDarker = {
            hex = 'a66e2e',
            rgb = {166, 110, 46},
        },
        colorDarkest = {
            hex = '7f4c1e',
            rgb = {127, 76, 30},
        },
    },

    -- Neon Colors
    {
        basic = 'NEON GREEN',
        color = {
            hex = '39ff14',
            rgb = {57, 255, 20},
        },
        colorDarker = {
            hex = '2dba11',
            rgb = {45, 186, 17},
        },
        colorDarkest = {
            hex = '1f7f0f',
            rgb = {31, 127, 15},
        },
    },
    {
        basic = 'NEON PINK',
        color = {
            hex = 'ff1493',
            rgb = {255, 20, 147},
        },
        colorDarker = {
            hex = 'cc1278',
            rgb = {204, 18, 120},
        },
        colorDarkest = {
            hex = '99105a',
            rgb = {153, 16, 90},
        },
    },
    {
        basic = 'NEON BLUE',
        color = {
            hex = '1e90ff',
            rgb = {30, 144, 255},
        },
        colorDarker = {
            hex = '187bcd',
            rgb = {24, 123, 205},
        },
        colorDarkest = {
            hex = '126a9b',
            rgb = {18, 106, 155},
        },
    },

    -- Pastel Colors
    {
        basic = 'PASTEL PINK',
        color = {
            hex = 'ffb3d9',
            rgb = {255, 179, 217},
        },
        colorDarker = {
            hex = 'cc99b3',
            rgb = {204, 153, 179},
        },
        colorDarkest = {
            hex = '996680',
            rgb = {153, 102, 128},
        },
    },
    {
        basic = 'PASTEL BLUE',
        color = {
            hex = 'aec6cf',
            rgb = {174, 198, 207},
        },
        colorDarker = {
            hex = '7fa3b4',
            rgb = {127, 163, 180},
        },
        colorDarkest = {
            hex = '5e7b8a',
            rgb = {94, 123, 138},
        },
    },
    {
        basic = 'PASTEL YELLOW',
        color = {
            hex = 'fdfd96',
            rgb = {253, 253, 150},
        },
        colorDarker = {
            hex = 'c8c87a',
            rgb = {200, 200, 122},
        },
        colorDarkest = {
            hex = '979745',
            rgb = {151, 151, 69},
        },
    },

    -- Modern Colors
    {
        basic = 'CHARCOAL',
        color = {
            hex = '36454f',
            rgb = {54, 69, 79},
        },
        colorDarker = {
            hex = '2d3b42',
            rgb = {45, 59, 66},
        },
        colorDarkest = {
            hex = '1f2a2e',
            rgb = {31, 42, 46},
        },
    },
    {
        basic = 'TURQUOISE',
        color = {
            hex = '40e0d0',
            rgb = {64, 224, 208},
        },
        colorDarker = {
            hex = '32b5a5',
            rgb = {50, 181, 165},
        },
        colorDarkest = {
            hex = '258c82',
            rgb = {37, 140, 130},
        },
    },
    {
        basic = 'MINT',
        color = {
            hex = 'a8ff98',
            rgb = {168, 255, 152},
        },
        colorDarker = {
            hex = '80cc7a',
            rgb = {128, 204, 122},
        },
        colorDarkest = {
            hex = '5a9954',
            rgb = {90, 153, 84},
        },
    },

    -- Earthy Tones
    {
        basic = 'TERRA COTTA',
        color = {
            hex = 'e2725b',
            rgb = {226, 114, 91},
        },
        colorDarker = {
            hex = 'b85a46',
            rgb = {184, 90, 70},
        },
        colorDarkest = {
            hex = '7f3e2f',
            rgb = {127, 62, 47},
        },
    },
    {
        basic = 'OLIVE',
        color = {
            hex = '808000',
            rgb = {128, 128, 0},
        },
        colorDarker = {
            hex = '666600',
            rgb = {102, 102, 0},
        },
        colorDarkest = {
            hex = '4d4d00',
            rgb = {77, 77, 0},
        },
    },
}



-- Initialize SIMPLE_COLORS
SIMPLE_COLORS = {}
for idx, c in pairs(COLORS) do
    SIMPLE_COLORS[idx] = c.color.rgb
end
