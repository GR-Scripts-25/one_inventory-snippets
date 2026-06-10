fx_version 'cerulean'
game 'gta5'
author 'Martttins'
description 'Most popular restaurants script on FiveM, now better!'
version '3.0.14'

shared_script '@ox_lib/init.lua'

client_scripts {
    '@qbx_core/modules/playerdata.lua',
    'freecam/utils.lua',
    'freecam/config.lua',
    'freecam/camera.lua',
    'freecam/main.lua',
    'resource/**/client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'resource/**/server.lua'
}

files {
    'web/build/index.html',
    'web/build/**/*',
    'locales/*.json',
    'config/*.lua',
    'data/**/*.lua',
    'modules/**/*.lua',
    'restaurants.json'
}

dependencies {
    'one_inventory',
    'ox_lib',
    'oxmysql',
    'ox_target'
}

ui_page 'web/build/index.html'

escrow_ignore {
    'config/*.lua',
    'data/**/*.lua',
    'modules/**/*.lua',
    'freecam/**/*.lua',
    -- 'resource/garage/client.lua',
    -- 'resource/delivery/client.lua',
    -- 'resource/drivethru/client.lua',
    'resource/**/*.lua'
}

dependency '/assetpacks'