fx_version 'cerulean'
games { 'gta5' }

author 'Roberto'
description 'Sweet-AC coded by Roberto'
version '15.1'

client_script {
    "@es_extended/locale.lua",
    "cfg/cl_sweet_cfg.lua",
    "client/cl_sweet.lua"
}

server_scripts {
    "@es_extended/locale.lua",
    "@mysql-async/lib/MySQL.lua",
    "cfg/cl_sweet_cfg.lua",
    "cfg/sv_sweet_cfg.lua",
    "server/sv_sweet.lua"
}

