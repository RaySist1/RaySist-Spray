Config = {
    License = 'RaySist',

    SPRAY_PERSIST_DAYS = 2,
    SPRAY_PROGRESSBAR_DURATION = 20000,
    SPRAY_REMOVE_DURATION = 30000,

    Keys = {
        CANCEL = {code = 23, label = 'INPUT_ENTER'},
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
        sizeMult = 0.70,
    },
    {
        font = 'graffiti2',
        label = 'Dripping Marker',
        allowed = '^[A-Za-z0-9\\-.$+-*/=%"\'#@&();:,<>!_~]+$',
        allowedInverse = '[^A-Za-z0-9\\-.$+-*/=%"\'#@&();:,<>!_~]+',
        sizeMult = 0.5,
    },
    {
        font = 'graffiti3',
        label = 'Docallisme',
        allowed = '^[A-Z]+$',
        forceUppercase = true,
        allowedInverse = '[^A-Z]+',
        sizeMult = 1.45,
    },
    {
        font = 'graffiti4',
        label = 'Fat Wandals',
        allowed = '^[A-Za-z\\-.$+-*/=%"\'#@&();:,<>!_~]+$',
        allowedInverse = '[^A-Za-z\\-.$+-*/=%"\'#@&();:,<>!_~]+',
        sizeMult = 0.3,
    },
    {
        font = 'graffiti5',
        label = 'Sister Spray',
        allowed = '^[A-Z0-9]+$',
        forceUppercase = true,
        allowedInverse = '[^A-Z0-9]+',
        sizeMult = 0.3,
    },
    {
        font = 'PricedownGTAVInt',
        label = 'Pricedown',
        allowed = '^[A-Za-z0-9]+$',
        allowedInverse = '[^A-Za-z0-9]+',
        sizeMult = 0.75,
    },
    {
        font = 'Chalet-LondonNineteenSixty',
        label = 'Chalet',
        allowed = '^[A-Za-z0-9]+$',
        allowedInverse = '[^A-Za-z0-9]+',
        sizeMult = 0.6,
    },
    {
        font = 'SignPainter-HouseScript',
        label = 'Sign Painter',
        allowed = '^[A-Za-z0-9]+$',
        allowedInverse = '[^A-Za-z0-9]+',
        sizeMult = 0.85,
    }
}

COLORS = {
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
        basic = 'RED',
        color = {
            hex = 'c81912',
            rgb = {200, 25, 18},
        },
        colorDarker = {
            hex = '8c120d',
            rgb = {140, 18, 13},
        },
        colorDarkest = {
            hex = '3c0806',
            rgb = {60, 8, 6},
        },
    },
    {
        basic = 'RED',
        color = {
            hex = 'f64b3c',
            rgb = {246, 75, 60},
        },
        colorDarker = {
            hex = 'cd190a',
            rgb = {205, 25, 10},
        },
        colorDarkest = {
            hex = '580b04',
            rgb = {88, 11, 4},
        },
    },
    {
        basic = 'PINK',
        color = {
            hex = 'f76a8c',
            rgb = {247, 106, 140},
        },
        colorDarker = {
            hex = 'ea0c42',
            rgb = {234, 12, 66},
        },
        colorDarkest = {
            hex = '64051c',
            rgb = {100, 5, 28},
        },
    },
    {
        basic = 'PINK',
        color = {
            hex = 'fde2e2',
            rgb = {253, 226, 226},
        },
        colorDarker = {
            hex = 'f45c5c',
            rgb = {244, 92, 92},
        },
        colorDarkest = {
            hex = '860909',
            rgb = {134, 9, 9},
        },
    },
    {
        basic = 'BLUE',
        color = {
            hex = '000839',
            rgb = {0, 8, 57},
        },
        colorDarker = {
            hex = '000627',
            rgb = {0, 6, 39},
        },
        colorDarkest = {
            hex = '000211',
            rgb = {0, 2, 17},
        },
    },
    {
        basic = 'BLUE',
        color = {
            hex = '005082',
            rgb = {0, 80, 130},
        },
        colorDarker = {
            hex = '003759',
            rgb = {0, 55, 89},
        },
        colorDarkest = {
            hex = '001826',
            rgb = {0, 24, 38},
        },
    },
    {
        basic = 'BLUE',
        color = {
            hex = '00a8cc',
            rgb = {0, 168, 204},
        },
        colorDarker = {
            hex = '00768f',
            rgb = {0, 118, 143},
        },
        colorDarkest = {
            hex = '00323d',
            rgb = {0, 50, 61},
        },
    },
    {
        basic = 'YELLOW',
        color = {
            hex = 'ffd31d',
            rgb = {255, 211, 29},
        },
        colorDarker = {
            hex = 'c8a100',
            rgb = {200, 161, 0},
        },
        colorDarkest = {
            hex = '564500',
            rgb = {86, 69, 0},
        },
    },
    {
        basic = 'YELLOW',
        color = {
            hex = 'f5fcc1',
            rgb = {245, 252, 193},
        },
        colorDarker = {
            hex = 'e0f641',
            rgb = {224, 246, 65},
        },
        colorDarkest = {
            hex = '717f06',
            rgb = {113, 127, 6},
        },
    },
    {
        basic = 'GREEN',
        color = {
            hex = '2b580c',
            rgb = {43, 88, 12},
        },
        colorDarker = {
            hex = '1f3f09',
            rgb = {31, 63, 9},
        },
        colorDarkest = {
            hex = '0d1b04',
            rgb = {13, 27, 4},
        },
    },
    {
        basic = 'GREEN',
        color = {
            hex = '639a67',
            rgb = {99, 154, 103},
        },
        colorDarker = {
            hex = '466d48',
            rgb = {70, 109, 72},
        },
        colorDarkest = {
            hex = '1e2f1f',
            rgb = {30, 47, 31},
        },
    },
    {
        basic = 'ORANGE',
        color = {
            hex = 'ea6227',
            rgb = {234, 98, 39},
        },
        colorDarker = {
            hex = 'af4111',
            rgb = {175, 65, 17},
        },
        colorDarkest = {
            hex = '4b1c07',
            rgb = {75, 28, 7},
        },
    },
    {
        basic = 'ORANGE',
        color = {
            hex = 'ffa41b',
            rgb = {255, 164, 27},
        },
        colorDarker = {
            hex = 'c47600',
            rgb = {196, 118, 0},
        },
        colorDarkest = {
            hex = '543300',
            rgb = {84, 51, 0},
        },
    },
    {
        basic = 'BROWN',
        color = {
            hex = '442727',
            rgb = {68, 39, 39},
        },
        colorDarker = {
            hex = '301b1b',
            rgb = {48, 27, 27},
        },
        colorDarkest = {
            hex = '140c0c',
            rgb = {20, 12, 12},
        },
    },
    {
        basic = 'BROWN',
        color = {
            hex = '9c5518',
            rgb = {156, 85, 24},
        },
        colorDarker = {
            hex = '6c3b11',
            rgb = {108, 59, 17},
        },
        colorDarkest = {
            hex = '2e1907',
            rgb = {46, 25, 7},
        },
    },
    {
        basic = 'PURPLE',
        color = {
            hex = '844685',
            rgb = {132, 70, 133},
        },
        colorDarker = {
            hex = '5d315e',
            rgb = {93, 49, 94},
        },
        colorDarkest = {
            hex = '281528',
            rgb = {40, 21, 40},
        },
    },
    {
        basic = 'PURPLE',
        color = {
            hex = 'be79df',
            rgb = {190, 121, 223},
        },
        colorDarker = {
            hex = '912fc1',
            rgb = {145, 47, 193},
        },
        colorDarkest = {
            hex = '3e1453',
            rgb = {62, 20, 83},
        },
    },
    {
        basic = 'GREY',
        color = {
            hex = 'cccccc',
            rgb = {204, 204, 204},
        },
        colorDarker = {
            hex = '8f8f8f',
            rgb = {143, 143, 143},
        },
        colorDarkest = {
            hex = '3d3d3d',
            rgb = {61, 61, 61},
        },
    },
    {
        basic = 'GREY',
        color = {
            hex = '323232',
            rgb = {50, 50, 50},
        },
        colorDarker = {
            hex = '242424',
            rgb = {36, 36, 36},
        },
        colorDarkest = {
            hex = '0f0f0f',
            rgb = {15, 15, 15},
        },
    },
    {
        basic = 'BLACK',
        color = {
            hex = '000000',
            rgb = {0, 0, 0},
        },
        colorDarker = {
            hex = '000000',
            rgb = {0, 0, 0},
        },
        colorDarkest = {
            hex = '000000',
            rgb = {0, 0, 0},
        },
    },
}

SIMPLE_COLORS = {}

for idx, c in pairs(COLORS) do
    SIMPLE_COLORS[idx] = c.color.rgb
end
