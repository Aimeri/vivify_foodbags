fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Aimeri'
description 'Food bags for restaurants.'
version '1.0.0'

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

shared_scripts {
    'config.lua'
}

dependencies {
    'qb-menu',
    'qb-inventory',
    'interact'
}