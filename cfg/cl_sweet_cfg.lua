SwatCC = {}
SwatCC.Superjump = true
SwatCC.AntiFreecam = true -- BUG
SwatCC.votureflic = true
SwatCC.antigmdemi = true -- BUG
SwatCC.antitp = true 
SwatCC.AntiPNJ = true
SwatCC.Prefix = "Sweet-AC"
--si ta une base avec pas de prefix met des -- sur la lingne
SwatCC.TrigPrefix = "::{korioz#0110}::"
--
-- detection de Base
--
SwatCC.Basic = {
  on = true,
  AntiaddBlips = true,
  AntiInfiniteAmmo = true,
  AntiSuperSprint = true,
  AntiSuperSwim = true,
  AntiSpectate = true, 
}

--
--spawn car
--
SwatCC.antispawn = {
  on = true,
  --BUG
  client = false,
  --active pas le coter server il est pas adapter a ta base
  server = true,
  eulenbancar = true,
}
-- need antispawn client True
SwatCC.wlressourcespawn = {
  ["es_extended"] = true,
  ["esx_policejob"] = true,
  ["esx_avocatjob"] = true,
  ["esx_advancedgarage"] = true,
  ["esx_ambulancejob"] = true,
  ["esx_mecanojob"] = true,
  ["esx_garage"] = true,
  ["esx_vehicleshop"] = true,
  ["esx_bcsojob"] = true,
}

SwatCC.Cmd = {
  on = true, -- master switch
  -- choisi seulement un conseille
  client = false,
  server = true,
}


--
-- ESX
-- 

SwatCC.ESXoption = {
  ESXserver = true,
  antiesx = true,
  ESXTrigger = '::{korioz#0110}::esx:getSharedObject',
  antigiveweapon = true,
}

SwatCC.voitureServices = {
  --Besoin ESX
  on = false,
  policejob = 'police',
  sherifjob = 'bcso',
  mecanojob = 'mechanic',
  abulancejob = 'ambulance',
}

-- STOP/START/RESTART
SwatCC.ResourceOption = {
  AntiResourceStart = true,
  AntiResourceStop = true,
  AntiResourceRestart = true,
  ResourceCount = true,
  MaxResourceNameLength = 18,
}

-- autre
SwatCC.autre = {
  on = true,
  FPSBoost = true,
  AntiPedAttack = true,
  antistopengine = true,
  antiweaponrain = true,
  BlacklistTriggers = true,
  blacklistWeapon = true,
}



------ Grosse config
SwatCC.CommandsProtection = true
SwatCC.BlacklistedCommands = {
  --'pk',
  'haha',
  'xddd',
  'Injection',
  '^1Injection',
  'chocolate',
	'panickey',
	'jolmany',
	'killmenu',
	'Desudo',
  'ISM Menu',
	'Brutan',
	'EulenCheats',
	"discord.gg/",
	"lynxmenu",
	"HamHaxia",
	"Ham Mafia",
	"www.renalua.com",
	"Fallen#0811",
	"Rena 8",
	"HamHaxia", 
	"Ham Mafia", 
	"Xanax#0134", 
	">:D Player Crash", 
	"discord.gg", 
	"34ByTe Community", 
	"lynxmenu.com", 
	"Anti-LRAC",
	"Baran#8992",
	"iLostName#7138",
	"85.190.90.118",
	"Melon#1379",
	"hammafia.com",
	"Vyorex Community",
	"AlphaV ~ 5391",
	"vjuton.pl",
	"Soviet Bear",
	"XARIES",
	"xaries",
	"dc.xaries.pl",
	"aries",
	"aries.pl",
	"emily#6498",
	"youtube.com/c/Aries98/",
	"Aries98",
	"yo many",
	"dezet",
	"dimitri",
	"redMENU",
	"OAf14Vphu3V",
	"pcwCmJS",
	"gNVAjPTvr3OF",
	"Falcon",
	"falcon",
	"___",
	"_________",
	"WJPZ",
	"Crazymodz",
	"Proxy",
	"xseira",
	"Cience",
	"KoGuSzEk",
	"LynxEvo",
	"nkDesudoMenu",
	"JokerMenu",
	"moneymany",
	"dreanhsMod",
	"gaybuild",
	"Lynx7",
	"LynxSeven",
	"TiagoMenu",
	"SkazaMenu",
	"BlessedMenu",
	"AboDream",
	"MaestroMenu",
	"GrayMenu",
	"sixsixsix",
	"YaplonKodEvo",
	"Biznes",
	"FantaMenuEvo",
	"BrutanPremium",
	"UAE",
	"TAJNEMENUMenu",
	"xnsadifnias",
	"Outcasts666",
	"HamMafia",
	"b00mek",
	"FlexSkazaMenu",
	"Desudo",
	"AlphaVeta",
	"nietoperek",
	"OneThreeThreeSevenMenu",
	"jebacDisaMenu",
	"lynxunknowncheats",
	"Motion",
	"onionmenu",
	"onion",
	"https://discord.gg/BZuEfTp",
	"discord.gg/BZuEfTp",
	"https://discord.gg/kgUtDrC",
	"discord.gg/kgUtDrC",
	"onionexec",
	"frostedflakes",
	"AlwaysKaffa",
	"skaza",
	"b00mMenu",
	"reasMenu",
	"ariesMenu",
	"MarketMenu",
	"LoverMenu",
	"dexMenu",
	"nigmenu0001",
	"rootMenu",
	"Genesis",
	"Tuunnell",
	"HankToBallaPool",
	"Roblox",
	"werfvtghiouuiowrfetwerfio",
	"llll4874",
	"KAKAAKAKAK",
	"udwdj",
	"Ggggg",
	"jd366213",
	"KZjx",
	"ihrug",
	"WADUI",
	"FendinX",
	"oTable",
	"LeakerMenu",
	"LobatL",
	"lua",
	"malicious",
	"salamoonder",
	"watermalone",
	"neodymium",
	"baboon",
	"bab00n",
	"sam772",
	"dopamine",
	"dopameme",
	"eulen",
	"onion",
	"skid",
	"redst0nia",
	"redstonia",
	"injected",
	"resources",
	"execution",
	"static",
	"d0pa",
	"tapatio",
	"FirePlayers",
	"ExecuteLua",
	"TSE",
	"GateKeep",
	"ShootPlayer",
	"InitializeIntro",
	"tweed",
	"GetResources",
	"PreloadTextures",
	"CreateDirectory",
	"WMGang_Wait",
	"capPa",
	"cappA",
	"Resources",
	"defaultVehAction",
	"ApplyShockwave",
	"badwolfMenu",
	"IlIlIlIlIlIlIlIlII",
	"AlikhanCheats",
	"chujaries",
	"menuName",
	"NertigelFunc",
	"WM2",
	"wmmenu",
	"redMENU",
	"bps",
	"FrostedMenu",
	"https://discord.gg/7bM3z5P",
	"Lynx Menu 5",
	"fuckYouCuntBag",
	"Absolute",
	'Desudo',
	'Brutan',
	'EulenCheats',
	"Lynx 8",
	"www.lynxmenu.com",
	"HamHaxia",
	"Ham Mafia",
	"www.renalua.com",
	"Fallen#0811",
	"Rena",
	"HamHaxia", 
	"Ham Mafia", 
	"Xanax#0134", 
	">:D Player Crash",  
	"34ByTe Community", 
	"lynxmenu.com", 
	"Anti-Lynx",
	"Baran#8992",
	"iLostName#7138",
	"85.190.90.118",
	"Melon#1379",
	"hammafia.com",
	"AlphaV ~ 5391",
	"vjuton.pl",
	"Soviet Bear",
	"MARVIN menu",
	"KoGuSzEk#3251"
}


-- arme bl
SwatCC.BlacklistedWeapons = {
  'WEAPON_GRENADELAUNCHER',
	'WEAPON_RPG',
	'WEAPON_STINGER',
	'WEAPON_MINIGUN',
	'WEAPON_GRENADE',
	'WEAPON_STICKYBOMB',
	'WEAPON_RAILGUN',
	'WEAPON_COMPACTLAUNCHER',
	'WEAPON_PIPEBOMB',
	'WEAPON_PROXMINE',
	'WEAPON_GRENADELAUNCHER_SMOKE',
	'WEAPON_FIREWORK',
	'WEAPON_HOMINGLAUNCHER',
	'WEAPON_RAYPISTOL',
	'WEAPON_RAYCARBINE',
	'WEAPON_RAYMINIGUN',
	'WEAPON_DIGISCANNER',
	'weapon_hominglauncher',
  'WEAPON_CARBINERIFLE_MK2',
  'WEAPON_SPECIALCARBINE_MK2',
  'WEAPON_ASSAULTRIFLE_MK2',
  'WEAPON_COMBATMG',
  'WEAPON_PUMPSHOTGUN_MK2',
  'WEAPON_COMBATSHOTGUN',
  'WEAPON_GADGETPISTOL',
  'WEAPON_CERAMICPISTOL',
  'WEAPON_NAVYREVOLVER',
  'WEAPON_COMBATMG_MK2',
  'WEAPON_MG',
  'WEAPON_HEAVYSNIPER_MK2',
  'WEAPON_MARKSMANRIFLE',
  'WEAPON_MARKSMANRIFLE_MK2',
  'WEAPON_BZGAS',
  --'WEAPON_MOLOTOV',
  'WEAPON_STICKYBOMB',
  'WEAPON_PROXMINE',
  'WEAPON_PIPEBOMB',
  'WEAPON_BALL',
  'WEAPON_SMOKEGRENADE',
  'WEAPON_FLARE',
  'WEAPON_FIREEXTINGUISHER',
}


SwatCC.BlacklistedEvents = {
  "esx_ambulancejob:revive",
  "esx_ambulance:revive",
  "esx_mafiajob:confiscatePlayerItem",
  "lscustoms:payGarage",
  "redst0nia:checking",
  "vrp_slotmachine:server:2",
  "Banca:deposit",
  "bank:deposit",
  "esx_ambulancejob:setDeathStatus",
  "give_back",
  "esx_fueldelivery:pay",
  "esx_carthief:pay",
  "esx_godirtyjob:pay",
  "esx_pizza:pay",
  "esx_ranger:pay",
  "esx_garbagejob:pay",
  "eTruckerjob:pay",
  "xk3ly-barbasz:getfukingmony",
  "wojtek_ubereats:hajs",
  "tost:zgarnijsiano",
  "wojtek_ubereats:napiwek",
  "Sasaki_kurier:pay",
  "esx_jobs:startWork",
  "esx_jobs:stopWork",
  "kickAllPlayer",
  "kickAllPlayer2",
  "cmg3_animations:sync",
  "ems:revive",
  "whoapd:revive",
  "esx_mechanicjob:startCraft3",
  "esx_mechanicjob:startCraft2",
  "esx_mechanicjob:startCraft",
  "paramedic:revive",
  "cmg2_animations:sync",
  "AdminMenu:giveBank",
  "AdminMenu:giveCash",
  "GoFast:VenteDuVehicule",
  "KorioZ-PersonalMenu:Admin_giveCash",
  "KorioZ-PersonalMenu:Admin_giveBank",
  "KorioZ-PersonalMenu:Admin_giveDirtyMoney",
  "esx_gopostaljob:pay",
  "esx_banksecurity:pay",
  "esx_vehicleshop:setVehicleOwnedPlayerId",
  "esx_mugging:giveItems",
  "esx_slotmachine:sv:2",
  "esx:giveInventoryItem",
  "NB:recruterplayer",
  "eBilling:sendBill",
  "esx_addons_gcphone:startCall",
  "esx_jailer:sendToJail",
  "esx_jail:sendToJail",
  "js:jailuser",
  "esx-qalle-jail:jailPlayer",
  "esx:addInventoryItem",
  "esx:addWeapon",
  "esx:deleteVehicle",
  "esx:spawnPed",
  "eDmvschool:pay", 
  "LegacyFuel:PayFuel",
  "OG_cuffs:cuffCheckNearest",
  "CheckHandcuff",
  "cuffServer",
  "esx_weashopjob:addLicense",
  "esx_dmvschool:addLicense",
  "cuffGranted",
  "ServerValidEmote",
  ":Sweet::ServerValidEmote",
  "KorioZ-PersonalMenu:Boss_recruterplayer",
  "police:cuffGranted",
  "esx_handcuffs:cuffing",
  "esx_policejob:handcuff",
  "bank:withdraw",
  "dmv:success",
  "esx_skin:responseSaveSkin",
  "eDmvschool:addLicense",
  "esx_mechanicjob:startCraft",
  "esx_drugs:startHarvestWeed",
  "esx_drugs:startTransformWeed",
  "esx_drugs:startSellWeed",
  "esx_drugs:startHarvestCoke",
  "esx_drugs:startTransformCoke",
  "esx_drugs:startSellCoke",
  "esx_drugs:startHarvestMeth",
  "esx_drugs:startTransformMeth",
  "laundry:washcash",
  "esx_bitcoin:startHarvestKoda",
  "esx_drugs:startSellMeth",
  "esx_drugs:startHarvestOpium",
  "esx_drugs:startSellOpium",
  "esx_drugs:startTransformOpium",
  "esx_farms:sell",
  "esx_blanchisseur:startWhitening",
  "esx_drugs:stopHarvestCoke",
  "esx_drugs:stopTransformCoke",
  "esx_drugs:stopSellCoke",
  "esx_drugs:stopHarvestMeth",
  "esx_drugs:stopTransformMeth",
  "esx_drugs:stopSellMeth",
  "esx_drugs:stopHarvestWeed",
  "esx_drugs:stopTransformWeed",
  "esx_drugs:stopSellWeed",
  "esx_drugs:stopHarvestOpium",
  "esx_drugs:stopTransformOpium",
  "esx_drugs:stopSellOpium",
  "esx_society:openBossMenu",
  "esx_tankerjob:pay",
  "esx_vehicletrunk:giveDirty",
  "gambling:spend",
  "esx:spawnVehicle",
  "AdminMenu:giveDirtyMoney",
  "esx_givecarkeys:setVehicleOwnedPlayerId",
  "esx_policejob:getOtherPlayerData",
  "garage:addKeys",
  "esx-qalle-jail:openJailMenu",
  "esx:jackingcar",
  "f0ba1292-b68d-4d95-8823-6230cdf282b6",
  "esx_status:set",
  "265df2d8-421b-4727-b01d-b92fd6503f5e",
  "JailUpdate",
  "esx_moneywash:deposit",
  "esx_moneywash:withdraw",
  "esx_identity:setIdentity",
  "mission:completed",
  "esx_society:setJobSalary",
  "truckerJob:success",
  "99kr-burglary:addMoney",
  "esx_jailer:unjailTime",
  "UnJP",
  "pxrp_vip:setVIPStatus",
  "route68_blackjack:givemoney",
  "hentailover:xdlol",
  "esx_society:getOnlinePlayers",
  "antilynx8:anticheat",
  "antilynxr6:detection",
  "esx_society:getOnlinePlayers",
  "antilynx8r4a:anticheat",
  "FaxDisVeh:CheckPermission:Return",
  "blacklist.setAdminPermissions",
  "AOP:SendAOP",
  "PayForRepairNow",
  "dropOff",
  "paycheck:bonus",
  "yodaaop:sync_cl",
  "wyspa_jail:jai",
  "esx-qalle-jail:jailPlayerNew",
  "SEM_InteractionMenu:Cuff",
  "antilynxr4:detect",
  "js:jailuser", 
  --"esx:getSharedObject",
  "8321hiue89js",
  "esx_illegal_drugs:startHarvestWeed",
  "ynx8:anticheat",
  -- "::{korioz#0110}::jobs_civil:payement",
  -- "::{korioz#0110}::jobs_civil:pay",
  "lynx8:anticheat",
  "::{J#ul#ia#n#go#li#fe#_#00#01}::Annoncepolice",
  "::{korioz#0110}::jojo:blanchiement",
  "adminmenu:allowall",
  "h:xd",
  "ljail:jailplayer",
  "adminmenu:setsalary",
  "advancedFuel:setEssence",
  "esx_vehicleshop:resellVehicle",
  "adminmenu:cashoutall",
 -- "bank:transfer",
  "PGX:RevivePlayer",
  "paycheck:salary",
  "HCheat:TempDisableDetection",
  "anticheese:SetComponentStatus",
  "gameCheck",
  "boutique:refreshpoints",
  -- "::{korioz#0110}::cambriolage:reward",
  -- "::{korioz#0110}::esx:giveInventoryItem",
  "EasyAdmin:CaptureScreenshot",
  "esx_inventoryhud:openPlayerInventory",
  "AOP:SendPT",
  "esx_vangelico_robbery:gioielli",
  "yoda:peacetime",
  "Badssentials:SetPT",
  "Anticheat:CheckStaffReturn",
  "EasyAdmin:FreezePlayer",
  "sellDrugs",
  "esx_drugs:pickedUpCannabis",
  "esx_drugs:processCannabis",
  "esx-qalle-hunting:reward",
  "esx-qalle-hunting:sell",
  "esx_billing:sendBill",
  "esx_mecanojob:onNPCJobCompleted",
  "SEM_InteractionMenu:GlobalChat",
  "SEM_InteractionMenu:Unjail",
  "BsCuff:Cuff696999",
  "veh_SR:CheckMoneyForVeh",
  "esx_carthief:alertcops",
  "esx_ambulancejob:revivveux2",
  "mellotrainer:adminTempBan",
  "mellotrainer:adminKick",
  "tpallplayerstome:go",
  "payload",
  "esx_reprogjob:onNPCJobMissionCompleted",
  "trip_adminmenu:addMoney",
  "Impulsionjobs_civil:pay",
  "esx_identity:setIdentity",
  "esx_policejob:message",
  "esx_tabac:annonce",
  "lester:vendita",
  "esx_vangelico_robbery:gioielli",
  "esx_vehicleshop:setVehicleOwned",
  "bankrobberies:receiveCash",
  "eden_gofast:check",
  "eden_gofast:itemremove",
  "route68_blackjack:givemoney",
  "esxambulancejob:revive",
  "esx_blanchisseur:washMoney",
  "Esx-MenuPessoal:Boss_recruterplayer",
  "kc_admin:set_group",
  "011693b2-a3a4-4d15-8199-3d652263148a",
  "esx_advancedgarage:payhealth",
  "buyWeaponsIllegal",
  "buyWeapons",
  "esx_jobs:caution",
  "esx_society:withdrawMoney",
  "esx_taxijob:success",
  "esx_vehicleshop:isPlateTaken",
}

