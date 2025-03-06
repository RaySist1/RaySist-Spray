fx_version 'cerulean'
game 'gta5'

description 'RaySist-Spray'
version '1.0.2'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'config.lua'
}

client_scripts {
    'client/warmenu.lua',
    'client/fonts.lua',
    'client/determinant.lua',
    'client/raycast.lua',
    'client/client.lua',
    'client/spray_rotation.lua',
    'client/control.lua',
    'client/remove.lua',
    'client/time.lua',
    'client/cancellable_progress.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

lua54 'yes'
use_fxv2_oal 'yes'
