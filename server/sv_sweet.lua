---Sweet ac ldt

--
--- LOCAL / VAR
--
local BanList = {}
local BanListLoad = false

local msec = math.random(5000,6000)
local EntityOwner = NetworkGetEntityOwner(entity)
local phonetable = SwatCS.sql.phone_messages_Table
local policesql = SwatCS.sql.police
local ambulancesql = SwatCS.sql.ambulance
local bcsosql = SwatCS.sql.bcso
local mecanosql = SwatCS.sql.mecano
local versionac = "1.67 dc 47 d8 77"
local screenshotOptions = {
    encoding = 'png',
    quality = 1
} 
local heur = os.date('%H:%M:%S', os.time())
local detect = {}
local killcount = {}
local banrate = {}
local limiter = {}
--mass
local vehspawncount = {}
local pedsspawncount = {}
local particlesspawncount = {}
local firespawncount = {}
local propscount = {}

TriggerEvent(SwatCC.ESXoption.ESXTrigger, function(obj) Roberto8622 = obj end)


function CountDetect()
    detect = {}
    banrate = {}
    SetTimeout(30000, CountDetect)
end
function Countkill()
    killcount = {}
    SetTimeout(5000, Countkill)
end

function iosahbfastdc()
    vehspawncount = {}
    pedsspawncount = {}
    particlesspawncount = {}
    firespawncount = {}
    propscount = {}
    SetTimeout(10000, iosahbfastdc)
end

function inTable(H,I)
    for J,K in pairs(H)do 
        if K==I then 
            return J 
        end 
    end
    return false 
end

function ban(source,license,identifier,liveid,xblid,discord,playerip,hwid,targetplayername,sourceplayername,duree,reason,permanent)
    local expiration = duree * 86400
    local timeat     = os.time()
    local added      = os.date()

    if expiration < os.time() then
        expiration = os.time()+expiration
    end


    table.insert(BanList, {
        license    = license,
        identifier = identifier,
        liveid     = liveid,
        xblid      = xblid,
        discord    = discord,
        playerip   = playerip,
        hwid       = hwid,
        reason     = reason,
        expiration = expiration,
        permanent  = permanent
    })
    if SwatCS.BanIP then 
        MySQL.Async.execute('INSERT INTO '.. SwatCS.sql.sweetban ..' (license,identifier,liveid,xblid,discord,playerip,hwid,targetplayername,sourceplayername,reason,expiration,timeat,permanent) VALUES (@license,@identifier,@liveid,@xblid,@discord,@playerip,@hwid,@targetplayername,@sourceplayername,@reason,@expiration,@timeat,@permanent)', {
            ['@license']          = license,
            ['@identifier']       = identifier,
            ['@liveid']           = liveid,
            ['@xblid']            = xblid,  
            ['@discord']          = discord,
            ['@playerip']         = playerip,
            ['@hwid']             = hwid,
            ['@targetplayername'] = targetplayername,
            ['@sourceplayername'] = sourceplayername,
            ['@reason']           = reason,
            ['@expiration']       = expiration,
            ['@timeat']           = timeat,
            ['@permanent']        = permanent,
        }, function()
        end)
    else
        MySQL.Async.execute('INSERT INTO '.. SwatCS.sql.sweetban ..' (license,identifier,liveid,xblid,discord,playerip,hwid,targetplayername,sourceplayername,reason,expiration,timeat,permanent) VALUES (@license,@identifier,@liveid,@xblid,@discord,@playerip,@hwid,@targetplayername,@sourceplayername,@reason,@expiration,@timeat,@permanent)', {
            ['@license']          = license,
            ['@identifier']       = identifier,
            ['@liveid']           = liveid,
            ['@xblid']            = xblid,
            ['@discord']          = discord,
            ['@hwid']             = hwid,
            ['@targetplayername'] = targetplayername,
            ['@sourceplayername'] = sourceplayername,
            ['@reason']           = reason,
            ['@expiration']       = expiration,
            ['@timeat']           = timeat,
            ['@permanent']        = permanent,
        }, function()
        end)
    end
end

function loadBanList()
    MySQL.Async.fetchAll('SELECT * FROM '.. SwatCS.sql.sweetban, {}, function(data)
        BanList = {}

        for i=1, #data, 1 do
            if SwatCS.BanIP then 
                table.insert(BanList, {
                    license    = data[i].license,
                    identifier = data[i].identifier,
                    liveid     = data[i].liveid,
                    xblid      = data[i].xblid,
                    discord    = data[i].discord,
                    playerip   = data[i].playerip,
                    hwid       = data[i].hwid,
                    reason     = data[i].reason,
                    expiration = data[i].expiration,
                    permanent  = data[i].permanent
                })
            else
                table.insert(BanList, {
                    license    = data[i].license,
                    identifier = data[i].identifier,
                    liveid     = data[i].liveid,
                    xblid      = data[i].xblid,
                    discord    = data[i].discord,
                    hwid       = data[i].hwid,
                    reason     = data[i].reason,
                    expiration = data[i].expiration,
                    permanent  = data[i].permanent
                })
            end
        end
    end)
end

function sql()
    if SwatCS.sql.on then
        --code
        print("\t\t^2Optimisation BDD en cours ...")
        if policesql ~= nil then
            MySQL.Sync.execute("DELETE FROM ".. phonetable .." WHERE transmitter = " ..policesql, {})
            print("\t\t^2Optimisation table ".. phonetable .." # ".. policesql .." terminé.")
        end
        if ambulancesql ~= nil then
            MySQL.Sync.execute("DELETE FROM ".. phonetable .." WHERE transmitter = " .. ambulancesql, {})
            print("\t\t^2Optimisation table ".. phonetable .." # ".. ambulancesql .." terminé.")
        end
        if  bcsosql ~= nil then
            MySQL.Sync.execute("DELETE FROM ".. phonetable .." WHERE transmitter = " .. bcsosql, {})
            print("\t\t^2Optimisation table ".. phonetable .." # ".. bcsosql .." terminé.")
        end
        if mecanosql ~= nil then
            MySQL.Sync.execute("DELETE FROM ".. phonetable .." WHERE transmitter = " .. mecanosql, {})
            print("\t\t^2Optimisation table ".. phonetable .." # ".. mecanosql .." terminé.")
        end
    end
end

local validResourceList

local function cvrl()
    validResourceList = {}
    for i=0,GetNumResources()-1 do
        validResourceList[GetResourceByFindIndex(i)] = true
    end
end

function start()
    Citizen.CreateThread(function()
        Wait(2000)
        print("^3[SweetAC] ^0SweetAC's is starting...")
        Wait(100)
        logo()
        auth()
        startLeMoteur()
        Wait(10000)
    end)
end

function logo()
    print([[^7
^9  _____                  _              _____       
^8 / ____|                | |       /\   / ____|      
^7| (_____      _____  ___| |_     /  \ | |     
^5 \___ \ \ /\ / / _ \/ _ \ __|   / /\ \| |
^4 ____) \ V  V /  __/  __/ |_   / ____ \ |
^3|_____/ \_/\_/ \___|\___|\__  /_/    \_\_____|

^7
]].. "^4" .. SwatCC.Prefix )
end

function auth()
    print("\n----------------------------------------------------------------------")
    print("\n^3SweetAC ^0| Sweet anticheat is all for U <3")
    print("\n^3SweetAC ^0| Thanks for downloading my anticheat")
    print("\n^3SweetAC ^0| if you need help : discord.gg/8K4ZwstB8t")
    print("\n----------------------------------------------------------------------")
end

function loadBanListAC()
    MySQL.Async.fetchAll(
            'SELECT * FROM '.. SwatCS.sql.sweetban,
            {},
            function (data)
            BanList = {}

            for i=1, #data, 1 do
                    table.insert(BanList, {
                            license    = data[i].license,
                            identifier = data[i].identifier,
                            liveid     = data[i].liveid,
                            xblid      = data[i].xblid,
                            discord    = data[i].discord,
                            playerip   = data[i].playerip,
                            reason     = data[i].reason,
                            expiration = data[i].expiration,
                            permanent  = data[i].permanent
                    })
            end
end)
end

CreateThread(function()
    while true do
        Wait(600000)
        if BanListLoad == true then
            loadBanList() 
        end
    end
end)

CreateThread(function()
    while true do
        Wait(10000)
        if BanListLoad == false then
            loadBanList()
            if BanList ~= {} then
                BanListLoad = true
            end
        end
    end
end)

RegisterServerEvent('Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag')
AddEventHandler('Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag', function(reason,servertarget)
    if servertarget == -1 then

        local license,identifier,liveid,xblid,discord,playerip,target
        local duree     = 0
        local reason    = reason
        if not reason then reason = "Sweet-AC" end

        if tostring(source) == "" then
            target = tonumber(servertarget)
        else
            target = source
        end

        if target and target > 0 then
            local ping = GetPlayerPing(target)

            if ping and ping > 0 then
                if duree and duree < 365 then
                    local sourceplayername = SwatCC.Prefix
                    local targetplayername = GetPlayerName(target)

                    for k,v in ipairs(GetPlayerIdentifiers(target))do
                        if string.sub(v, 1, string.len("license:")) == "license:" then
                            license = v
                            ST = v
                        elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
                            identifier = v
                        elseif string.sub(v, 1, string.len("live:")) == "live:" then
                            liveid = v
                        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                            xblid  = v
                        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                            discord = v
                        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                            playerip = v
                        end
                    end

                    hwid = GetPlayerToken(servertarget)
                    if hwid == nil then 
                        hwid = '404'
                    end

                    if SwatCS.Debug ~= true then
                        TriggerClientEvent(SwatCC.TrigPrefix ..'Roberto8622_outlawalert:sync',servertarget)
                        Wait(2000)
                        if duree > 0 then
                            ban(target,license,identifier,liveid,xblid,discord,playerip,hwid,targetplayername,sourceplayername,duree,reason,0) --Timed ban here
                            DropPlayer(target, "Vous avez été banni du serveur par ".. SwatCC.Prefix .. " de Roberto#8622 | Code de ban AC: " .. reason.. ", discord : " .. SwatCS.discord)
                        else
                            ban(target,license,identifier,liveid,xblid,discord,playerip,hwid,targetplayername,sourceplayername,duree,reason,1) --Timed ban here
                            DropPlayer(target, "Vous avez été banni du serveur par ".. SwatCC.Prefix .. " de Roberto#8622 | Code de ban AC: " .. reason.. ", discord : " .. SwatCS.discord)
                        end
                    else
                        print('tes ban')
                    end
                end
            end
        end
    end
end)

RegisterServerEvent('Roberto:swtchatlogC')
AddEventHandler('Roberto:swtchatlogC', function(reason, letter)
    TriggerEvent('Roberto:swtchatlogS', reason , source, letter)
end)
--Exec function count
iosahbfastdc()
CountDetect()
Countkill()
--
AddEventHandler('detectlimit', function(ids, res)
    if detect[ids] ~= nil then
        if detect[ids] ~= 'off' then
            if detect[ids] == 9 then 
                if res == 'stop' then 
                    TriggerEvent('Roberto:swtchatlogS', 'stop Desudo / Redengine' , ids, 'B')
                    Wait(100)
                    TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "stop RedEngine / Desudo ):" ,ids)
                else
                    TriggerEvent('Roberto:swtchatlogS', 'ses trop fait detect dans la session' , ids, 'K')
                    Wait(100)
                    DropPlayer(ids, 'Vous demandez trop de requêtes a anticheat. Merci d\'éviter le Cheat, peut importe le type de Exécuteur ! Vous pouvez vous reconnecter.')
                end
                print('TO much detect '.. ids)      
                detect[ids] = 'off'
            else
                detect[ids] = detect[ids] + 1
            end
        end
    else
        detect[ids] = 1
    end
end)

-- BASE CALIF OPTION (FRENCH BASE)
if SwatCS.BaseCalifornia.on then 
    if SwatCS.BaseCalifornia.killall then
        RegisterServerEvent(SwatCC.TrigPrefix ..'cmg2_animations:sync')
        AddEventHandler(SwatCC.TrigPrefix ..'cmg2_animations:sync', function(animationLib, animation, animation2, distans, distans2, height, targetSrc, length, spin, controlFlagSrc, controlFlagTarget, animFlagTarget)
            if targetSrc == -1 then 
                TriggerEvent('Roberto:swtchatlogS', '**a essaiyer de kill all avec -1 (type 1)**' , source, 'B')
                TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "kill all" ,source)
                CancelEvent()
                return
            end
        end)

        RegisterServerEvent(SwatCC.TrigPrefix ..'cmg2_animations:stop')
        AddEventHandler(SwatCC.TrigPrefix ..'cmg2_animations:stop', function(targetSrc)
            if targetSrc == -1 then 
                TriggerEvent('Roberto:swtchatlogS', '**a essaiyer de kill all avec -1 (type 2)**' , source, 'B')
                TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "kill all" ,source)
                CancelEvent()
                return
            end
        end)

        RegisterServerEvent(SwatCC.TrigPrefix ..'cmg3_animations:sync')
        AddEventHandler(SwatCC.TrigPrefix ..'cmg3_animations:sync', function(animationLib, animationLib2, animation, animation2, distans, distans2, height, targetSrc, length, spin, controlFlagSrc, controlFlagTarget, animFlagTarget, attachFlag)
            if targetSrc == -1 then 
                TriggerEvent('Roberto:swtchatlogS', '**a essaiyer de kill all avec -1 (type 3)**' , source, 'B')
                TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "kill all" ,source)
                CancelEvent()
                return
            end
        end)

        RegisterServerEvent(SwatCC.TrigPrefix ..'cmg3_animations:stop')
        AddEventHandler(SwatCC.TrigPrefix ..'cmg3_animations:stop', function(targetSrc)
            if targetSrc == -1 then
                TriggerEvent('Roberto:swtchatlogS', '**a essaiyer de kill all avec -1 (type 4)**' , source, 'B')
                TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "kill all" ,source)
                CancelEvent()
                return
            end
        end)

    end
end

--ANTI CLEAR PED TASK
if SwatCS.anticlearpedtask then
    AddEventHandler("clearPedTasksEvent", function(source, data)
        if data.immediately then
            TriggerEvent('Roberto:swtchatlogS', '**clearPedTasks**' , source, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "681" ,source)
        end
    end)
end
--BL NAME
if SwatCS.blacklistName.on then
    AddEventHandler("playerConnecting", function(playerName, setKickReason)
        for name in pairs(SwatCS.blacklistNameList) do
            if(string.gsub(string.gsub(string.gsub(string.gsub(playerName:lower(), "-", ""), ",", ""), "%.", ""), " ", ""):find(SwatCS.blacklistNameList[name])) then
                print('[' .. SwatCC.Prefix ..'] '.. playerName .. " got reject connect because of is name")
                setKickReason('[' .. SwatCC.Prefix ..'] ' .. SwatCS.blacklistName.refusemessage)
                CancelEvent()
                break
            end
        end
    end)
end



--LOGS
RegisterServerEvent('Roberto:swtchatlogS')
AddEventHandler('Roberto:swtchatlogS', function(reason, servertarget, letter)
    if SwatCS.Chatdetect then
        if GetPlayerName(servertarget) ~= nil then
            if letter == 'D' then
                if reason ~= 'rien' then
                    TriggerEvent('detectlimit',servertarget,'Detect')
                    LogBanToDiscord(servertarget, reason,'Detect')
                end
                local xPlayers = Roberto8622.GetPlayers()
                for i = 1, #xPlayers, 1 do
                    local xPlayer = Roberto8622.GetPlayerFromId(xPlayers[i])
                    if xPlayer and xPlayer.getGroup() ~= "user" then
                        Citizen.Wait(0)
                        TriggerClientEvent('chatMessage', xPlayer.source, "^4[".. SwatCC.Prefix .. "🌊]", {
                            math.random(1, 255),
                            math.random(1, 255),
                            math.random(1, 255)
                        }, "^8Detect! 🌊^6 ["..servertarget.."] ^6".. GetPlayerName(servertarget) .."^9 got detected")
                        Citizen.Wait(0)
                    end
                end
            elseif letter == 'K' then
                if reason ~= 'rien' then
                    LogBanToDiscord(servertarget,reason,'KICK')
                end
                local xPlayers = Roberto8622.GetPlayers()
                for i = 1, #xPlayers, 1 do
                    local xPlayer = Roberto8622.GetPlayerFromId(xPlayers[i])
                    if xPlayer and xPlayer.getGroup() ~= "user" then
                        Citizen.Wait(0)
                        TriggerClientEvent('chatMessage', xPlayer.source, "^4[".. SwatCC.Prefix .. "🌊]ˇ", {
                            math.random(1, 255),
                            math.random(1, 255),
                            math.random(1, 255)
                        }, "^8Kicked! 🌊^6 ["..servertarget.."] ^6".. GetPlayerName(servertarget) .."^9 got detected")
                    end
                end
                local lol = math.random(5000,6000)
                DropPlayer(servertarget, "Server->client connection timed out. Last seen "..lol.." msec ago.")
            elseif letter == 'B' then
                if banrate[servertarget] ~= 'ban' then 
                    banrate[servertarget] = 'ban'

                    if reason ~= 'rien' then
                        LogBanToDiscord(servertarget,reason,'BAN')
                    end
                    local xPlayers = Roberto8622.GetPlayers()
                    for i = 1, #xPlayers, 1 do
                        local xPlayer = Roberto8622.GetPlayerFromId(xPlayers[i])
                        if xPlayer and xPlayer.getGroup() ~= "user" then
                            Citizen.Wait(0)
                            TriggerClientEvent('chatMessage', xPlayer.source, "^4[".. SwatCC.Prefix .. "🌊] ", {
                                math.random(1, 255),
                                math.random(1, 255),
                                math.random(1, 255)
                            }, "^8Banned! 🌊^6 ["..servertarget.."] ^6".. GetPlayerName(servertarget) .."^9 got detected")
                            Citizen.Wait(0)
                        end
                    end
                end
            elseif letter == 'spawn' then
                if reason ~= 'rien' then
                    LogSpawnVehcule(servertarget,reason,'delete vehcule')
                end
                local xPlayers = Roberto8622.GetPlayers()
                for i = 1, #xPlayers, 1 do
                    local xPlayer = Roberto8622.GetPlayerFromId(xPlayers[i])
                    if xPlayer and xPlayer.getGroup() ~= "user" then
                        Citizen.Wait(0)
                        TriggerClientEvent('chatMessage', xPlayer.source, "^4[".. SwatCC.Prefix .. "🌊] ", {
                            math.random(1, 255),
                            math.random(1, 255),
                            math.random(1, 255)
                        }, "^8Vehcule Spawn! 🌊^6 ["..servertarget.."] ^6".. GetPlayerName(servertarget) .."^9 got detected")
                        Citizen.Wait(0)
                    end
                end
            end
        end
    end
end)

AddEventHandler('playerConnecting', function(playerName,setKickReason)
    local license,steamID,liveid,xblid,discord,playerip  = "n/a","n/a","n/a","n/a","n/a","n/a"

    for k,v in ipairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamID = v
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xblid  = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            playerip = v
        end
    end

    if GetNumPlayerTokens(source) == 0 or GetNumPlayerTokens(source) == nil or GetNumPlayerTokens(source) < 0 or GetNumPlayerTokens(source) == "null" or GetNumPlayerTokens(source) == "**Invalid**" or not GetNumPlayerTokens(source) then
        setKickReason(source, "".. SwatCC.Prefix .. " : restart your fivem")
        CancelEvent()
        return
    end

    hwid = GetPlayerToken(source)

    if (Banlist == {}) then
        Citizen.Wait(1000)
    end

    for i = 1, #BanList, 1 do
        if
            ((tostring(BanList[i].license)) == tostring(license)
            or (tostring(BanList[i].identifier)) == tostring(steamID)
            or (tostring(BanList[i].liveid)) == tostring(liveid)
            or (tostring(BanList[i].xblid)) == tostring(xblid)
            or (tostring(BanList[i].discord)) == tostring(discord)
            or (tostring(BanList[i].playerip)) == tostring(playerip)
            or (tostring(BanList[i].hwid)) == tostring(hwid))
        then
            if (tonumber(BanList[i].permanent)) == 1 then
                setKickReason("Vous avez été banni du serveur par ".. SwatCC.Prefix .. " de Roberto#8622 | Code de ban AC: " .. BanList[i].reason.. ", discord : " .. SwatCS.discord)
                print("[".. SwatCC.Prefix .."]  ^7-8  ".. playerName .." [".. source .."] try to connect to the server but is ban^0")
                CancelEvent()
                break
            end
        end
    end
end)



AddEventHandler("playerConnecting", function(playerName, setKickReason)
    if playerName ~= nil then
        local color = "^"..math.random(0,9)
        print("[".. SwatCC.Prefix .."]  ^7- "..color.." ".. playerName .." [".. source .."] is connecting to the server^0")
    end
end)

LogBanToDiscord = function (playerId,reason,testuban)

    local playerId = tonumber(playerId)
    local nameplayer = GetPlayerName(playerId)
    local steamid  = "404"
    local license  = "404"
    local discord  = "404"
    local xbl      = "404"
    local liveid   = "404"
    local ip       = "404"
    if testuban == nil then
        testuban = "inconue"
    end
    

    for k,v in pairs(GetPlayerIdentifiers(playerId)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbl  = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = string.sub(v, 4)
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@"..discordid..">"
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        end
    end

    hwid = GetPlayerToken(playerId)
    if hwid == nil then 
        hwid = '404'
    end

    if nameplayer == nil then
        nameplayer = "Unknown"
    end

    local discordInfo = {
        ["color"] = "16776960",
        ["type"] = "rich",
        ["author"] = {
            name = '['.. SwatCC.Prefix ..']',
        },
        ["title"] = reason,
        ["description"] = '**__User info (::__** \n\n'
        .. '**Server ID:** `' .. playerId .. '`\n\n'
        .. '**Username:** `' .. nameplayer .. '`\n\n'
        .. '**IP:** ||' .. ip .. '||\n\n'
        .. '**Steam:** `' .. steamid .. '`\n\n'
        .. '**License:** `' .. license .. '`\n\n'
        .. '**Xbl:** `' .. xbl .. '`\n\n'
        .. '**Live:** `' .. liveid .. '`\n\n'
        .. '**Discord ID:** ' .. discord .. '\n\n\n'
        .. '**Token (fivem):** ||' .. hwid .. '||\n\n\n'
        ..'**__Other Things:__** \n\n'
        .. '**action anticheat:** `' .. testuban .. '`\n'
        .. '**time:** `' .. heur ..'`\n',
        ["footer"] = {
            ["text"] =  SwatCC.Prefix .. ' version  : '..versionac
        }
    }
    Wait(100)
    PerformHttpRequest(SwatCS.webhook.detect, function(err, text, headers) end, 'POST', json.encode({ username = SwatCC.Prefix, avatar_url = 'https://cdn.discordapp.com/icons/897281137674694726/e057d7d00c5c91edba0c606ce06d035f.webp?size=128', embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end

LogSpawnVehcule = function (playerId,reason,testuban)

    local playerId = tonumber(playerId)
    local nameplayer = GetPlayerName(playerId)
    local steamid  = "404"
    local license  = "404"
    local discord  = "404"
    local xbl      = "404"
    local liveid   = "404"

    if testuban == nil then
        local testuban = "inconue"
    end


    for k,v in pairs(GetPlayerIdentifiers(playerId)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbl  = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = string.sub(v, 4)
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@"..discordid..">"
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        end
    end
    hwid = GetPlayerToken(playerId)
    if hwid == nil then 
        hwid = '404'
    end
    local discordInfo = {
        ["color"] = "16776960",
        ["type"] = "rich",
        ["author"] = {
            name = '['.. SwatCC.Prefix ..']',
        },
        ["title"] = reason,
        ["description"] = '**__User info (::__** \n\n'
        .. '**Server ID:** `' .. playerId .. '`\n\n'
        .. '**Username:** `' .. nameplayer .. '`\n\n'
        .. '**IP:** `' .. ip .. '`\n\n'
        .. '**Steam:** `' .. steamid .. '`\n\n'
        .. '**License:** `' .. license .. '`\n\n'
        .. '**Xbl:** `' .. xbl .. '`\n\n'
        .. '**Live:** `' .. liveid .. '`\n\n'
        .. '**Discord ID:** ' .. discord .. '\n\n\n'
        .. '**Token (fivem):** ||' .. hwid .. '||\n\n\n'
        ..'**__Other Things:__** \n\n'
        .. '**action anticheat:** `' .. testuban .. '`\n'
        .. '**time:** `' .. heur ..'`\n',
        ["footer"] = {
            ["text"] =  SwatCC.Prefix .. ' version  : '..versionac
        }
    }
    Wait(100)
    PerformHttpRequest(SwatCS.webhook.spawncar, function(err, text, headers) end, 'POST', json.encode({ username = SwatCC.Prefix, avatar_url = 'https://cdn.discordapp.com/icons/897281137674694726/e057d7d00c5c91edba0c606ce06d035f.webp?size=128', embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
    
end



startLeMoteur = function ()
    Wait(1000)
    if os.getenv("USERNAME") ~= nil then
        --WINDOWS
        local discordInfo = {
            ["color"] = "3066993",
            ["type"] = "rich",
            ["title"] = SwatCC.Prefix ,
            ["description"] = '**__Other Things:__** \n\n'
            .. '**time:** `' .. heur ..'`\n'
            .. '**Anticheat status:** `Up and runing`\n'
            .. '**AC Current Version :** `'.. versionac ..'`\n'
            ..'**nombre de ressource (Server):** `' .. GetNumResources() .. '`\n'
            ..'**nom d\'utulisateur os : **`' .. os.getenv("USERNAME") .. '`\n'
            ..'**OS du serveur : **`Windows`\n',
            ["footer"] = {
                ["text"] = SwatCC.Prefix .. ' Version: '..versionac
            }
        }
        Wait(100)
        PerformHttpRequest(SwatCS.webhook.detect, function(err, text, headers) end, 'POST', json.encode({ username = SwatCC.Prefix, embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
        
    else
        --LINUX
        local discordInfo = {
            ["color"] = "3066993",
            ["type"] = "rich",
            ["title"] = SwatCC.Prefix ,
            ["description"] = '**__Other Things:__** \n\n'
            .. '**time:** `' .. heur ..'`\n'
            .. '**Anticheat status:** `Up and runing`\n'
            .. '**AC Current Version :** `'.. versionac ..'`\n'
            ..'**nombre de ressource (Server):** `' .. GetNumResources() .. '`\n'
            ..'**home directory : **`' .. os.getenv("HOME") .. '`\n'
            ..'**OS du serveur : **`Linux`\n'
            ..'**temps écoulé/CPU: **`' .. os.clock() .. '`\n'
            ..'**PATH : **||' .. os.getenv("PATH") .. '||\n',
            ["footer"] = {
                ["text"] = SwatCC.Prefix .. ' Version: '..versionac
            }
        }
        Wait(100)
        PerformHttpRequest(SwatCS.webhook.detect, function(err, text, headers) end, 'POST', json.encode({ username = SwatCC.Prefix, embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
        
    end
end


RegisterServerEvent('Roberto:detectionf748esf4esf4se85de7des7fesf5ede8sf')
AddEventHandler('Roberto:detectionf748esf4esf4se85de7des7fesf5ede8sf', function(type, item)
    local _type = type or 'default'
    local _item = item or 'none'

    _type = string.lower(_type)
        if (_type == 'default') then
            TriggerEvent('Roberto:swtchatlogS', 'Unknown Readon (sa peux etre nimp)' , source, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "B404" ,source)
        elseif (_type == 'godmode') then
            TriggerEvent('Roberto:swtchatlogS', 'a test le godmod' , source, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "66" ,source)
        elseif (_type == 'resourcestart') then
            TriggerEvent('Roberto:swtchatlogS', 'a start une ressource : '.. item , source, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "27" ,source)
        elseif (_type == 'resourcestop') then
            TriggerEvent('Roberto:swtchatlogS', 'a stop une ressource : '.. item, source, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "43" ,source)
        elseif (_type == 'esx') then
            TriggerEvent('Roberto:swtchatlogS', 'A inject un menu avec esx' , source, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "esx",source)
        elseif (_type == 'spec') then
            TriggerEvent('Roberto:swtchatlogS', 'A Spec un joueur' , source, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "15" ,source)
        elseif (_type == 'resourcecounter') then
            TriggerEvent('Roberto:swtchatlogS', 'A pas le meme nombre de resource que le depart' , source, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "77" ,source)
        elseif (_type == 'freecam') then
            TriggerEvent('Roberto:swtchatlogS', 'A une freecam' , source, 'D')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "110" ,source)
        elseif (_type == 'superJump') then
            TriggerEvent('Roberto:swtchatlogS', 'A Utuliser Superjump' , source, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "111" ,source)
        elseif (_type == 'eulenspawn') then
            TriggerEvent('Roberto:swtchatlogS', 'Eulen Code : Spawn' , source, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "Eulen ):" ,source)
        elseif (_type == 'rede') then
            TriggerEvent('Roberto:swtchatlogS', 'REDENGINE / DESUDO' , source, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "RedEngine / Desudo ):" ,source)
        elseif (_type == 'antiblips') then
            TriggerEvent('Roberto:swtchatlogS', 'A les blips' , source, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "44" ,source)
        elseif (_type == 'injection') then
            TriggerEvent('Roberto:swtchatlogS', 'a exec un command/Injection' , source, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "82" ,source)
        elseif (_type == 'blacklisted_weapon') then
            TriggerEvent('Roberto:swtchatlogS', 'Arme BL : '.. item ..'' , source, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "Arme Blacklist",source)
        elseif (_type == 'hash') then
            TriggerEvent('Roberto:swtchatlogS', 'BL CAR/HASH' , source, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "52" ,source)
        elseif (_type == 'explosion') then
            TriggerEvent('Roberto:swtchatlogS', 'fait spawn une explosion' , source, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "38" ,source)
        elseif (_type == 'event') then
            TriggerEvent('Roberto:swtchatlogS', 'bl event :'.. item .. '', source, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "22" ,source)
        elseif (_type == 'tireunknow') then
            TriggerEvent('Roberto:swtchatlogS', 'a tuer quelq\'un avec un arme qui a pas dans les main', source, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "piou piou" ,source)
        end
end)

if SwatCS.ExplosionProtection then
    AddEventHandler("explosionEvent",function(sender, ev)
        for _, v in ipairs(SwatCS.BlockedExplosions) do
            if ev ~= nil then
                if ev.explosionType == v then
                    TriggerEvent('Roberto:swtchatlogS', 'ses crue dans l\'armer avec ses explosion  type : '.. ev.explosionType ..'' , sender, 'B')
                    TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "38" ,sender)
                    CancelEvent()
                    return
                end
            end
        end
    end)
    AddEventHandler("explosionEvent",function(sender, ev)
        CancelEvent()
        return
    end)
end

if SwatCS.antiprojectil then
    AddEventHandler('startProjectileEvent', function(sender, data)
        CancelEvent()
    end)
end
if SwatCS.GiveWeaponsProtection.on then
    if SwatCS.GiveWeaponsProtection.give then
        AddEventHandler("giveWeaponEvent", function(sender, data)
            for _,theWeapon in ipairs(SwatCC.BlacklistedWeapons) do
                if GetHashKey(theWeapon) == data.weaponType then 
                    TriggerEvent('Roberto:swtchatlogS', 'a essaiyer de se give un arme bl  : '..theWeapon..'' , source, 'B')
                    TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "672" ,source)
                    break
                end
            end
            if data.ammo >= 250 then
                TriggerEvent('Roberto:swtchatlogS', 'a essaiyer de se give : '..data.ammo..' ammo' , source, 'B')
                TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "673" ,source)
            end
            ---
            CancelEvent()
        end)
    end

    if SwatCS.GiveWeaponsProtection.remove then
        AddEventHandler("RemoveWeaponEvent", function(sender, data)
            TriggerEvent('Roberto:swtchatlogS', 'a essaiyer de remove weapon ' , sender, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "673" ,sender)
            CancelEvent()
        end)
    end

    if SwatCS.GiveWeaponsProtection.removeall then
        AddEventHandler("RemoveAllWeaponsEvent", function(sender, data)
            TriggerEvent('Roberto:swtchatlogS', 'a essaiyer de remove all weapon ' , sender, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "673" ,sender)
            CancelEvent()
        end)
    end
end

if SwatCS.WordsProtection then
    AddEventHandler('chatMessage', function(source, n, message)
        for k,n in pairs(SwatCS.BlacklistedWords) do
        if string.match(message:lower(),n:lower()) then
            TriggerEvent('Roberto:swtchatlogS', 'a essaiyer de dire : '..n ..'' , source, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "22" ,source)
        end
        end
    end)
end

if SwatCS.TriggersProtection then
    for k,events in pairs(SwatCC.BlacklistedEvents) do
        RegisterServerEvent(events)
        AddEventHandler(events, function()
            CancelEvent()
            src = source 
            if src == nil then
                src = inconue
            end
            TriggerEvent('Roberto:swtchatlogS', 'a exec un event bl : '..events ..'' , source, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "22" ,source)
        end)
    end
end


start()


-- 
RegisterServerEvent("Anaconda:Sweet:ArmeProtection")
AddEventHandler("Anaconda:Sweet:ArmeProtection", function(Arme)
    local xPlayer  = Roberto8622.GetPlayerFromId(source)
    TriggerEvent('Roberto:swtchatlogS', 'Ses Give une arme : '.. Arme ..' !' , source, 'K')
    DropPlayer(source, SwatCC.Prefix .. " : Tu a éssayer de te give une arme XD sa peux etre un bug ses juste un kick")
end)


if SwatCS.domage.on then
    AddEventHandler('weaponDamageEvent', function (sender, data)
        if data.damageType == 3 then
            local xPlayer = Roberto8622.GetPlayerFromId(sender)
            if data.weaponType ~= 2725352035 then
                if SwatCS.listeArmes[data.weaponType] == nil then
                    if SwatCS.domage.multiplier then
                        TriggerEvent('Roberto:swtchatlogS', 'denne des domage avec une arme qui est NILL debug '.. data.weaponType .. ' debug 2 ' ..data.weaponType.name, sender, 'K')
                        DropPlayer(sender, '[ ' .. SwatCC.Prefix .. '] Désynchronisation avec le serveur ou Cheat detecté. ['.. data.weaponType .. ']')
                    end
                else
                    if SwatCS.domage.check then
                        if not xPlayer.hasWeapon(SwatCS.listeArmes[data.weaponType].name) then
                            TriggerEvent('Roberto:swtchatlogS', 'Tire avec une arme qui a pas debug : '.. data.weaponType  , sender, 'K')
                            DropPlayer(sender, 'Désynchronisation avec le serveur ou Cheat detecté. ['.. data.weaponType.name .. ']')
                        end
                    end
                end
            end
        end
        if SwatCS.domage.killcount then
            if data.willKill then
                if killcount[sender] ~= 'ban' then
                    if killcount[sender] ~= nil then
                        if killcount[sender] == 5 then
                            killcount[sender] = 'ban'
                            TriggerEvent('Roberto:swtchatlogS', 'A kill 5 personne en 5 seconde', sender, 'K')
                            DropPlayer(sender, 'Désynchronisation avec le serveur ou Cheat detecté. [5]')
                        else
                            killcount[sender] = killcount[sender] + 1
                        end
                    else
                        killcount[sender] = 1
                    end
                end
            end
        end
    end)
end

--wl plate system lag if you what to change all you plate system
-- if SwatCC.antispawn.on then
--     if SwatCC.antispawn.server then
--         AddEventHandler('entityCreating', function(entity)
--             local found = false
--             local vPlate = GetVehicleNumberPlateText(entity)
--             local src = NetworkGetEntityOwner(entity)
--             local global = MySQL.Sync.fetchAll("SELECT * from owned_vehicles", {})
--             Citizen.Wait(2000)
--             for k,v in pairs(global) do
--                 if v.plate == vPlate then
--                     found = true
--                 end
--             end
--             if GetPlayerName(src) ~= nil then
--                 for wlplate in pairs(SwatCS.wlplate) do
--                     if vPlate == wlplate then 
--                         found = true
--                     end
--                     if vPlate == '' then 
--                         found = true
--                     end
--                     if vPlate == ' ' then 
--                         found = true
--                     end
--                     if found == false then
--                         if src ~= nil and vPlate ~= nil then 
--                             --TriggerEvent('detectlimit',src,'stop')
--                             --print('INFO: User [' .. (src or '') .. '] ' .. (GetPlayerName(src) or '') .. ' spawn a vehcule plate : "'.. vPlate ..'" model : ' .. (entity or '') .. ' - ' .. (model or ''))
--                             DeleteEntity(entity)
--                             print( ''.. GetPlayerName(src) .. ' Vecule spawn PLATE : "' .. vPlate ..'"')
--                             TriggerEvent('Roberto:swtchatlogS', 'Spawn Vehcule : '.. vPlate ..'' , src, 'spawn')
--                             CancelEvent()
--                         end
--                     end
--                 end
--             else
--                 DeleteEntity(entity)
--                 CancelEvent()
--             end
--         end)
--     end
-- end



RegisterNetEvent(SwatCC.TrigPrefix ..'driftforscreen')
AddEventHandler(SwatCC.TrigPrefix ..'driftforscreen', function()
    local playerId = source;
    local xPlayers = Roberto8622.GetPlayers()
    for i = 1, #xPlayers, 1 do
        local xPlayer = Roberto8622.GetPlayerFromId(xPlayers[i])
        if xPlayer and xPlayer.getGroup() ~= "user" then
            TriggerClientEvent('chatMessage', xPlayer.source, "[".. SwatCC.Prefix .."🌊]", {0, 0, 255},'[Possible Modders] ' .. GetPlayerName(playerId) .. ' [ID: ' .. playerId ..  '] Trigger a blacklisted key')
        end
    end
    print('Sweet INFO: User [' .. playerId .. '] ' .. (GetPlayerName(playerId) or '') .. ' Trigger a blacklisted key')

    local playerId = tonumber(playerId)
    local nameplayer = GetPlayerName(playerId)
    local steamid  = "404"
    local license  = "404"
    local discord  = "404"
    local xbl      = "404"
    local liveid   = "404"
    local ip       = "404"
    local testubanbl = "Detect"

    

    for k,v in pairs(GetPlayerIdentifiers(playerId)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbl  = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = string.sub(v, 4)
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@"..discordid..">"
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        end
    end
    Wait(10)
    exports['discord-screenshot']:requestCustomClientScreenshotUploadToDiscord(playerId, SwatCS.webhook.touchebl, screenshotOptions, {
        username = '['.. SwatCC.Prefix ..']',
        avatar_url = 'https://cdn.discordapp.com/icons/897281137674694726/e057d7d00c5c91edba0c606ce06d035f.webp?size=128',
        content = '',
        embeds = {
            {
                color = 16711680,
                author = {
                    name = '['.. SwatCC.Prefix ..']',
                },
                title = reason,
                description = '**__User info (::__** \n\n'
                .. '**Server ID:** `' .. playerId .. '`\n\n'
                .. '**Username:** `' .. nameplayer .. '`\n\n'
                .. '**IP:** `' .. ip .. '`\n\n'
                .. '**Steam:** `' .. steamid .. '`\n\n'
                .. '**License:** `' .. license .. '`\n\n'
                .. '**Xbl:** `' .. xbl .. '`\n\n'
                .. '**Live:** `' .. liveid .. '`\n\n'
                .. '**Discord ID:** ' .. discord .. '\n\n\n'
                ..'**__Other Things:__** \n\n'
                .. '**action anticheat:** `' .. testubanbl .. '`\n'
                .. '**time:** `' .. heur ..'`\n',
            -- .. ' '
                footer = {
                    text =  SwatCC.Prefix .. ' version  : '..versionac,
                }
            }
        }
    });
end)

AddEventHandler('entityCreating', function(entity)
    if DoesEntityExist(entity) then
        local _src = NetworkGetEntityOwner(entity)
        local _entitytype = GetEntityPopulationType(entity)
        local _type = GetEntityType(entity)
        local modelentity = GetEntityModel(entity)
        if _src == nil then
            CancelEvent()
        end
        --bl entity
        if SwatCS.BlacklistedEntityDetection then
            for _,blacklistedentity in ipairs(SwatCS.BlacklistedEntities) do
                if modelentity == GetHashKey(blacklistedentity) then
                    CancelEvent()
                    TriggerEvent('Roberto:swtchatlogS', 'try to be retard whit : blacklisted entity: **'..blacklistedentity..'**' , _src, 'D')
                    break
                end
            end
        end
        --debug 
        if SwatCS.Debug then
            print('type')
            print(_entitytype)
            print(_type)
            print('model hash')
            print(modelentity)
            print('source')
            print(_src)
            print('--- Sweet-AC ---')
        end


        if GetEntityType(entity) == 2 then
            if _entitytype == 6 or _entitytype == 7 then
                vehspawncount[_src] = (vehspawncount[_src] or 0) + 1
                if vehspawncount[_src] > SwatCS.massVehicles then
                    TriggerClientEvent("Sweet:clearvehicles" , -1, _src)
                    CancelEvent()
                    TriggerEvent('Roberto:swtchatlogS', 'Tried to mass Vehcule (325)' , _src, 'B')
                    TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "325" ,_src)
                end
            end
        elseif GetEntityType(entity) == 1 then
            if _entitytype == 6 or _entitytype == 7 then
                pedsspawncount[_src] = (pedsspawncount[_src] or 0) + 1
                if pedsspawncount[_src] > SwatCS.massPeds then
                    TriggerClientEvent("Sweet:clearpeds" , -1)
                    CancelEvent()
                    TriggerEvent('Roberto:swtchatlogS', 'Tried to mass peds (326)' , _src, 'B')
                    TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "326" ,_src)
                end
            end
        elseif GetEntityType(entity) == 3 then
            propscount[_src] = (propscount[_src] or 0) + 1
            if vehspawncount[_src] > SwatCS.massprops then
                TriggerClientEvent("Sweet:clearvehicles" , -1, _src)
                CancelEvent()
                TriggerEvent('Roberto:swtchatlogS', 'Tried to mass Props (329)' , _src, 'B')
                TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "329" ,_src)
            end
        end
    end
end)



AddEventHandler('explosionEvent', function(sender, data)
    if sender == nil then
        CancelEvent()
        print('explosion send whit nil sender (i cancel it for u)')
    end
    if data.posX == 0.0 or data.posY == 0.0 or data.posZ == 0.0 or data.posZ == -1700.0 or (data.cameraShake == 0.0 and data.damageScale == 0.0 and data.isAudible == false and data.isInvisible == false) then
        CancelEvent()
        TriggerEvent('Roberto:swtchatlogS', 'Tried to send a weird explosion (466)' , _src, 'B')
        TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "466" ,sender)
        return
    end
end)

RegisterCommand("c", function(source) 
    if source == 0 then
        loadBanList()
        print('Banlist Refresh')
    end
end)

if SwatCC.Cmd.on then
    if SwatCC.Cmd.server then
        for i,v in pairs(SwatCC.Cmd.BlacklistedCommandslist) do
            if SwatCC.Cmd.on then
                RegisterCommand(v, function(source, args, rawCommand)
                    TriggerEvent('Roberto:swtchatlogS', 'a exec un command/Injection' , source, 'B')
                    TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "82" ,source)
                end, false)
            end
        end
    end
end

if SwatCS.Ratelimit.on then
    local function netLog(s)
        print(string.format('Sweet-Rate - [%s]: %s^7', os.date("%Y-%m-%d %H:%M:%S", os.time()), s))
    end

    for i = 1, #SwatCS.Ratelimit.Ratelist do
        local eventName = SwatCS.Ratelimit.Ratelist[i]

        RegisterServerEvent(eventName)
        AddEventHandler(eventName, function()
            local playerId = tonumber(source)
            if not playerId or playerId == 0 then return end
            local timerNow = GetGameTimer()

            if not limiter[playerId] then limiter[playerId] = {} end

            local limit = limiter[playerId][eventName]

            if not limit then
                limiter[playerId][eventName] = { counter = 1, started = timerNow }
                return
            else
                if (timerNow - limit.started) >= 1000 then
                    limit.counter = 1
                    limit.started = timerNow
                    return
                else
                    limit.counter = limit.counter + 1
                end
            end

            if limit.counter > SwatCS.Ratelimit.Maxratelimit then
                TriggerEvent('Roberto:swtchatlogS', 'Rate Limit : avec Trigger : '.. eventName .. '\n debug :'.. limit.counter, playerId, 'K')
                netLog(string.format('User [%i] %s exceeded rate-limit - INFO : %s [%i/%i]', playerId, GetPlayerName(playerId), eventName, limit.counter, SwatCS.Ratelimit.Maxratelimit))
                DropPlayer(playerId, "Vous n'êtes pas autorisé à faire autant de R/s.")
            end
        end)
    end

    AddEventHandler('playerDropped', function(reason)
        if limiter[source] then
            limiter[source] = nil
        end
    end)
    
end

cvrl()

AddEventHandler("onResourceListRefresh", cvrl) 

RegisterNetEvent("Roberto:Rcheck")
AddEventHandler("Roberto:Rcheck", function(givenList)
    for _, resource in ipairs(givenList) do
        if not validResourceList[resource] then
            TriggerEvent('Roberto:swtchatlogS', "Eulen isolate detect : **"..resource.."**" , source, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "Eulen" ,source)
            break
        end
    end
end)
--- parti des rate
AddEventHandler('ptFxEvent', function(sender, data)
    particlesspawncount[sender] = (particlesspawncount[sender] or 0) + 1
    if particlesspawncount[sender] > SwatCS.MassParticles then
        CancelEvent()
        if banrate[sender] ~= 'ban' then 
            banrate[sender] = 'ban'
            TriggerEvent('Roberto:swtchatlogS', 'Tried to mass Particul (code : 404)' , sender, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "404" ,sender)
    
        end
    end
end)

AddEventHandler('fireEvent', function(sender, data)
    firespawncount[sender] = (firespawncount[sender] or 0) + 1
    if firespawncount[sender] > SwatCS.massfire then
        CancelEvent()
        if banrate[sender] ~= 'ban' then 
            banrate[sender] = 'ban'
            TriggerEvent('Roberto:swtchatlogS', 'Tried to mass fire (code : 405)' , sender, 'B')
            TriggerEvent("Roberto:banqcdjadhaudghbyatgdsvuyagduygai8dag", "405" ,sender)
        end
    end
end)

-----------------wl contry
if SwatCS.wlcountrysetting.on then
    AddEventHandler("playerConnecting", function(playerName, setKickReason, deferrals)
        local ip = tostring(GetPlayerEndpoint(source))
        deferrals.defer()
        Wait(0)
        PerformHttpRequest(
            "https://freegeoip.app/json/" .. ip,
            function(M,ax,O)
                if M==200 then
                    local ay = json.decode(ax)
                    if inTable(SwatCS.wlcountrysetting.wlcountrys, ay['country_code']) == false then 
                        deferrals.done("Les connection depuis ["..ay['country_name'].."] ne sont pas autorisées")
                    print("^6[".. SwatCC.Prefix .."]^1  ^0("..playerName..")^1 a essaiyer de se co depuie le pays ^0("..ay['country_name']..")^1 !^0")
                    else
                        deferrals.done()
                    end
                else
                    deferrals.done()
                end
            end
        )
    end)
end

------------ System Anti VPN

if SwatCS.vpnsetting.AntiVPN then

    function webhooklog(a, b, d, e, f)
        if SwatCS.AntiVPN then
            if SwatCS.webhook.antivpn ~= "" or SwatCS.webhook.antivpn ~= nil then
                PerformHttpRequest(
                    SwatCS.webhook.antivpn,
                    function(err, text, headers)
                    end,
                    "POST",
                    json.encode(
                        {
                            embeds = {
                                {
                                    author = {name = SwatCC.Prefix .." AntiVPN", url = "", icon_url = ""},
                                    title = "Connection " .. a,
                                    description = "**Player:** " .. b .. "\nIP: " .. d .. "\n" .. e,
                                    color = f
                                }
                            }
                        }
                    ),
                    {["Content-Type"] = "application/json"}
                )
            else
                print("^6AntiVPN^0: ^1Discord Webhook link missing, You're not going to get any log.^0")
            end
        end
    end

    AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
        local player = source
        local name, setKickReason, deferrals = name, setKickReason, deferrals;
        local ipIdentifier
        local identifiers = GetPlayerIdentifiers(player)
        deferrals.defer()
        Wait(0)
        deferrals.update(string.format("Bienvenue. Votre adresse IP est en cours de vérification.", name))
        for _, v in pairs(identifiers) do
            if string.find(v, "ip") then
                ipIdentifier = v:sub(4)
                break
            end
        end
        Wait(0)
        if not ipIdentifier then
            deferrals.done("Nous n'avons pas trouvé votre adresse IP.")
        else
            PerformHttpRequest("http://ip-api.com/json/" .. ipIdentifier .. "?fields=proxy", function(err, text, headers)
                if tonumber(err) == 200 then
                    local tbl = json.decode(text)
                    if tbl["proxy"] == false then
                        deferrals.done()
                    else
                        print("^6[".. SwatCC.Prefix .."]^0: ^1Player ^0" .. name .. " ^1KICK POUR VPN, ^8IP: ^0" .. ip .. "^0")
                        if SwatCS.vpnsetting.AntiVPNDiscordLogs then
                            webhooklog("Unauthorized", name, ipIdentifier, "VPN/PROXY Detecté...", 16515843)
                        end
                        deferrals.done(SwatCC.Prefix .. " : Desactive ton VPN/PROXY (:")
                    end
                else
                    deferrals.done("Une erreur s'est produite dans l'API.")
                end
            end)
        end
    end)
end
