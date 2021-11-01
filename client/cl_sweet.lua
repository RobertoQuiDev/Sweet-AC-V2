print('ss')
--
-- variable
--
local pickupList = {"PICKUP_AMMO_BULLET_MP","PICKUP_AMMO_FIREWORK","PICKUP_AMMO_FLAREGUN","PICKUP_AMMO_GRENADELAUNCHER","PICKUP_AMMO_GRENADELAUNCHER_MP","PICKUP_AMMO_HOMINGLAUNCHER","PICKUP_AMMO_MG","PICKUP_AMMO_MINIGUN","PICKUP_AMMO_MISSILE_MP","PICKUP_AMMO_PISTOL","PICKUP_AMMO_RIFLE","PICKUP_AMMO_RPG","PICKUP_AMMO_SHOTGUN","PICKUP_AMMO_SMG","PICKUP_AMMO_SNIPER","PICKUP_ARMOUR_STANDARD","PICKUP_CAMERA","PICKUP_CUSTOM_SCRIPT","PICKUP_GANG_ATTACK_MONEY","PICKUP_HEALTH_SNACK","PICKUP_HEALTH_STANDARD","PICKUP_MONEY_CASE","PICKUP_MONEY_DEP_BAG","PICKUP_MONEY_MED_BAG","PICKUP_MONEY_PAPER_BAG","PICKUP_MONEY_PURSE","PICKUP_MONEY_SECURITY_CASE","PICKUP_MONEY_VARIABLE","PICKUP_MONEY_WALLET","PICKUP_PARACHUTE","PICKUP_PORTABLE_CRATE_FIXED_INCAR","PICKUP_PORTABLE_CRATE_UNFIXED","PICKUP_PORTABLE_CRATE_UNFIXED_INCAR","PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL","PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW","PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE","PICKUP_PORTABLE_PACKAGE","PICKUP_SUBMARINE","PICKUP_VEHICLE_ARMOUR_STANDARD","PICKUP_VEHICLE_CUSTOM_SCRIPT","PICKUP_VEHICLE_CUSTOM_SCRIPT_LOW_GLOW","PICKUP_VEHICLE_HEALTH_STANDARD","PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW","PICKUP_VEHICLE_MONEY_VARIABLE","PICKUP_VEHICLE_WEAPON_APPISTOL","PICKUP_VEHICLE_WEAPON_ASSAULTSMG","PICKUP_VEHICLE_WEAPON_COMBATPISTOL","PICKUP_VEHICLE_WEAPON_GRENADE","PICKUP_VEHICLE_WEAPON_MICROSMG","PICKUP_VEHICLE_WEAPON_MOLOTOV","PICKUP_VEHICLE_WEAPON_PISTOL","PICKUP_VEHICLE_WEAPON_PISTOL50","PICKUP_VEHICLE_WEAPON_SAWNOFF","PICKUP_VEHICLE_WEAPON_SMG","PICKUP_VEHICLE_WEAPON_SMOKEGRENADE","PICKUP_VEHICLE_WEAPON_STICKYBOMB","PICKUP_WEAPON_ADVANCEDRIFLE","PICKUP_WEAPON_APPISTOL","PICKUP_WEAPON_ASSAULTRIFLE","PICKUP_WEAPON_ASSAULTSHOTGUN","PICKUP_WEAPON_ASSAULTSMG","PICKUP_WEAPON_AUTOSHOTGUN","PICKUP_WEAPON_BAT","PICKUP_WEAPON_BATTLEAXE","PICKUP_WEAPON_BOTTLE","PICKUP_WEAPON_BULLPUPRIFLE","PICKUP_WEAPON_BULLPUPSHOTGUN","PICKUP_WEAPON_CARBINERIFLE","PICKUP_WEAPON_COMBATMG","PICKUP_WEAPON_COMBATPDW","PICKUP_WEAPON_COMBATPISTOL","PICKUP_WEAPON_COMPACTLAUNCHER","PICKUP_WEAPON_COMPACTRIFLE","PICKUP_WEAPON_CROWBAR","PICKUP_WEAPON_DAGGER","PICKUP_WEAPON_DBSHOTGUN","PICKUP_WEAPON_FIREWORK","PICKUP_WEAPON_FLAREGUN","PICKUP_WEAPON_FLASHLIGHT","PICKUP_WEAPON_GRENADE","PICKUP_WEAPON_GRENADELAUNCHER","PICKUP_WEAPON_GUSENBERG","PICKUP_WEAPON_GOLFCLUB","PICKUP_WEAPON_HAMMER","PICKUP_WEAPON_HATCHET","PICKUP_WEAPON_HEAVYPISTOL","PICKUP_WEAPON_HEAVYSHOTGUN","PICKUP_WEAPON_HEAVYSNIPER","PICKUP_WEAPON_HOMINGLAUNCHER","PICKUP_WEAPON_KNIFE","PICKUP_WEAPON_KNUCKLE","PICKUP_WEAPON_MACHETE","PICKUP_WEAPON_MACHINEPISTOL","PICKUP_WEAPON_MARKSMANPISTOL","PICKUP_WEAPON_MARKSMANRIFLE","PICKUP_WEAPON_MG","PICKUP_WEAPON_MICROSMG","PICKUP_WEAPON_MINIGUN","PICKUP_WEAPON_MINISMG","PICKUP_WEAPON_MOLOTOV","PICKUP_WEAPON_MUSKET","PICKUP_WEAPON_NIGHTSTICK","PICKUP_WEAPON_PETROLCAN","PICKUP_WEAPON_PIPEBOMB","PICKUP_WEAPON_PISTOL","PICKUP_WEAPON_PISTOL50","PICKUP_WEAPON_POOLCUE","PICKUP_WEAPON_PROXMINE","PICKUP_WEAPON_PUMPSHOTGUN","PICKUP_WEAPON_RAILGUN","PICKUP_WEAPON_REVOLVER","PICKUP_WEAPON_RPG","PICKUP_WEAPON_SAWNOFFSHOTGUN","PICKUP_WEAPON_SMG","PICKUP_WEAPON_SMOKEGRENADE","PICKUP_WEAPON_SNIPERRIFLE","PICKUP_WEAPON_SNSPISTOL","PICKUP_WEAPON_SPECIALCARBINE","PICKUP_WEAPON_STICKYBOMB","PICKUP_WEAPON_STUNGUN","PICKUP_WEAPON_SWITCHBLADE","PICKUP_WEAPON_VINTAGEPISTOL","PICKUP_WEAPON_WRENCH", "PICKUP_WEAPON_RAYCARBINE"}
local firstSpawnAC = true
CamerasEdit = {}
--- DEV MODE
local Firstspawnfreecam = true
avertg1 = 0
avertg2 = 0
avertg3 = 0
avertg4 = 0
avertf4 = 0
local num23 = math.random(1,31)
local firstco = true
local ressourcecountvar = GetNumResources()
local bleedtouch = false
local PlayerData                = {}
local HasAlreadyEnteredMarker   = false
-- var function

if SwatCC.TrigPrefix == nil then
	SwatCC.TrigPrefix = ""
end


local a = function()
    return Citizen.InvokeNative(0x048746E388762E11, Citizen.ReturnResultAnyway())
end

SWTS = TriggerServerEvent

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
	return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

function eulencar()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(10)
            for vehicle in EnumerateVehicles() do
                Citizen.Wait(5)
                local handle = GetEntityScript(vehicle)
                if handle ~= nil then
					if SwatCC.antispawn.on then
						if SwatCC.antispawn.client then
							if (handle ~= '' and not SwatCC.wlressourcespawn[handle] and handle ~= 'scr_2') then
								roberttgana(vehicle)
								print(handle)
								SWTS('Roberto:swtchatlogC', 'Spawn car avec "'.. handle..'"',  'spawn')
							end
							
						end
					end
					--eulen
					if SwatCC.antispawn.eulenbancar then
						if handle == 'scr_2' then
							roberttgana(vehicle)
							SWTS("Roberto:detectionf748esf4esf4se85de7des7fesf5ede8sf", "eulenspawn", "^^")
						end
					end
                end
            end
        end
    end)
end


--




function RemoveWeaponDrops()
	Citizen.Wait(5)
    for a = 1, #pickupList do
		N_0x616093ec6b139dd9(PlayerId(), GetHashKey(pickupList[a]), false)
    end
end

Citizen.CreateThread(function()     
    RemoveWeaponDrops()
end)

function antiesx()
	AddEventHandler("esx:getSharedObject", function(cb)
		SWTS("Roberto:detectionf748esf4esf4se85de7des7fesf5ede8sf", "esx", "^^")
	end)
end

jedevokfdp = true
function InitRessource()
    Citizen.CreateThread(function()
        while true do

            local resourceList = {}
            for i=0,GetNumResources()-1 do
                resourceList[i+1] = GetResourceByFindIndex(i)
            end
			if jedevokfdp then
            	SWTS("Roberto:Rcheck", resourceList)
			end

            Wait(15000)
        end
    end)
end

function roberttgana(entity)
	if DoesEntityExist(entity) then
		NetworkRequestControlOfEntity(entity)
		local gameTime = GetGameTimer()

		while DoesEntityExist(entity) and (not NetworkHasControlOfEntity(entity) or ((GetGameTimer() - gameTime) < 2000)) do
			Citizen.Wait(10)
		end

		if DoesEntityExist(entity) then
			DetachEntity(entity, false, false)
			SetEntityAsMissionEntity(entity, false, false)
			SetEntityCollision(entity, false, false)
			SetEntityAlpha(entity, 0, true)
			SetEntityAsNoLongerNeeded(entity)

			if IsAnEntity(entity) then
				DeleteEntity(entity)
			elseif IsEntityAPed(entity) then
				DeletePed(entity)
			elseif IsEntityAVehicle(entity) then
				DeleteVehicle(entity)
			elseif IsEntityAnObject(entity) then
				DeleteObject(entity)
			end

			gameTime = GetGameTimer()

			while DoesEntityExist(entity) and ((GetGameTimer() - gameTime) < 2000) do
				Citizen.Wait(10)
			end

			if DoesEntityExist(entity) then
				SetEntityCoords(entity, vector3(10000.0, -1000.0, 10000.0), vector3(0.0, 0.0, 0.0), false)
			end
		end
	end
end


--
-- Event
--
RegisterNetEvent('Sweet:clearvehicles')
AddEventHandler('Sweet:clearvehicles', function(vehicles)
    if vehicles == nil then
        local vehs = GetGamePool('CVehicle')
        for _, vehicle in ipairs(vehs) do
            if not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1)) then
                if NetworkGetEntityIsNetworked(vehicle) then
                    DeleteNetworkedEntity(vehicle)
                else
                    SetVehicleHaRobertoestlafdpeenOwnedByPlayer(vehicle, false)
                    SetEntityAsMissionEntity(vehicle, true, true)
                    DeleteEntity(vehicle)
                end
            end
        end
    end
end)



RegisterNetEvent('Sweet:clearpeds')
AddEventHandler('Sweet:clearpeds', function()
    local idpedjoueurs = GetGamePool('CPed')
    for _, ped in ipairs(idpedjoueurs) do
        if not (IsPedAPlayer(ped)) then
            RemoveAllPedWeapons(ped, true)
            if NetworkGetEntityIsNetworked(ped) then
                DeleteNetworkedEntity(ped)
            else
                DeleteEntity(ped)
            end
        end
    end
end)


AddEventHandler("playerSpawned", function()
	nbcmds = #GetRegisteredCommands()
	nbres = GetNumResources()
	if firstSpawnAC then
		firstSpawnAC = false
	end
    if Firstspawnfreecam then
        Citizen.Wait(120000)
		Firstspawnfreecam = false
	end
end)

if SwatCC.ResourceOption.AntiResourceStart then
    AddEventHandler("onClientResourceStart", function(resourceName)
        local lenn = string.len(resourceName)
	    local subb = string.sub(resourceName, 1, 1)

	    if lenn >= SwatCC.ResourceOption.MaxResourceNameLength and subb == "_" then
		    SWTS("Roberto:detectionf748esf4esf4se85de7des7fesf5ede8sf", "resourcestart", resourceName)
	    end

    	if not firstSpawnAC then
    		SWTS("Roberto:detectionf748esf4esf4se85de7des7fesf5ede8sf", "resourcestart", resourceName)
    	end
    end)
end

if SwatCC.ResourceOption.AntiResourceStop then
    AddEventHandler("onClientResourceStop", function(resourceName)
        if not firstSpawnAC then
            SWTS("Roberto:detectionf748esf4esf4se85de7des7fesf5ede8sf", "resourcestop", resourceName)
        end
    end)
end




if SwatCC.autre.blacklistWeapon then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)

			
			local blacklistedWeapons = SwatCC.BlacklistedWeapons or {}

			for blacklistedWeaponName, blacklistedWeaponHash in pairs(blacklistedWeapons) do
				Citizen.Wait(10)

				if (HasPedGotWeapon(PlayerPedId(), blacklistedWeaponHash, false)) then
					RemoveAllPedWeapons(PlayerPedId())
					Citizen.Wait(250)
					SWTS("Roberto:detectionf748esf4esf4se85de7des7fesf5ede8sf", "blacklisted_weapon", blacklistedWeaponHash)
				end
			end
		end
	end)
end

--ESX EVENT
InitRessource()
if SwatCC.ESXoption.ESXserver then
    if SwatCC.ESXoption.ESXserver then
        Robertoestlafdp = nil
        Citizen.CreateThread(function()
            while Robertoestlafdp == nil do
            TriggerEvent(SwatCC.ESXoption.ESXTrigger, function(obj) Robertoestlafdp = obj end)
            end
            Citizen.Wait(3000)
        end)
    end


	if SwatCC.voitureServices.on then
		Citizen.CreateThread(function()
			while true do
				Citizen.Wait(500)
				local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false) 
				local vehicleClass = GetVehicleClass(vehicle)
				PlayerData = Robertoestlafdp.GetPlayerData()
				
				if vehicleClass == 18 and GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
					if PlayerData.job.name ~= SwatCC.voitureServices.policejob and PlayerData.job.name ~= SwatCC.voitureServices.abulancejob and PlayerData.job.name ~= SwatCC.voitureServices.mecanojob and PlayerData.job.name ~= SwatCC.voitureServices.sherifjob then
						ClearPedTasksImmediately(PlayerPedId())
						TaskLeaveVehicle(PlayerPedId(),vehicle,0)
						--TriggerEvent('Roberto:printwtf',num23 ,"^4SweetAC \n^3Sort du vehcule\n^3Sortie effectué")
					end
				end
			end
		end)
	end

	if SwatCC.ESXoption.antigiveweapon then
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(1000)
                PlayerData = Robertoestlafdp.GetPlayerData()
                local found = false

                local weaponName = GetSelectedPedWeapon(GetPlayerPed(PlayerId()))

                TheWeapon = nil

                for key, value in pairs(TableWeapon) do
                    if value == weaponName then
                        TheWeapon = key
                    end
                end
                                   if PlayerData.group ~= 'user' then return end

                for i = 1, #PlayerData.loadout, 1 do
                    if PlayerData.loadout[i].name == TheWeapon then
                        found = true
                        break    
                    end
                end	
				if PlayerData.permloadout ~= nil then

					for i = 1, #PlayerData.permloadout, 1 do
						if PlayerData.permloadout[i].name == TheWeapon then
							found = true
							break    
						end
					end
				end

                if found then 
                    
                else
                    if TheWeapon == nil then
                        RemoveWeaponFromPed(GetPlayerPed(PlayerId()), weaponName)
                    else
                        if TheWeapon == "WEAPON_UNARMED" then
                        else
                            RemoveWeaponFromPed(GetPlayerPed(PlayerId()), GetHashKey(TheWeapon))
                            Citizen.Wait(2000)
                            SWTS("Anaconda:Sweet:ArmeProtection", TheWeapon)
                        end
                    end
                end
            end
        end)
    end 
else
	antiesx()
	degaantiesx = true
end
--BL Event
if SwatCC.autre.BlacklistTriggers then
    for k, event in pairs(SwatCC.BlacklistedEvents) do
        RegisterNetEvent(event)
        AddEventHandler(event, function()
            CancelEvent()
            SWTS("Roberto:detectionf748esf4esf4se85de7des7fesf5ede8sf", "event", event)
        end)
    end
end

-- Tread
if SwatCC.autre.FPRobertoestlafdpoost then
    Citizen.CreateThread(function()
        while true do
			Wait(1800000)
            ClearAllBrokenGlass()
            ClearAllHelpMessages()
            LeaderboardsReadClearAll()
            ClearBrief()
            ClearGpsFlags()
            ClearPrints()
            ClearSmallPrints()
            ClearReplayStats()
            LeaderboardsClearCacheData()
            ClearFocus()
            ClearHdArea()
            --TriggerEvent('Roberto:printwtf',num23 ,"^4SweetAC \n^3Debug props effectué\n^3FPS BOOST")
        end
    end)
end

if SwatCC.antispawn.on then
    eulencar()
end

if SwatCC.autre.antistopengine then
    Citizen.CreateThread(function()
        while true do 
            Wait(5000)
            if IsPedSittingInAnyVehicle(PlayerPedId()) then
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                if GetVehicleEngineHealth(vehicle) <= 500 then
                    if not GetIsVehicleEngineRunning(vehicle) then
                        SetVehicleEngineOn(vehicle, true, false, true)
                        SetVehicleUndriveable(vehicle, false)
                    end
                    SetVehicleEngineHealth(vehicle, 1000.0)
                end
            end
        end
    end)
end

RegisterCommand("cd", function() 
	if jedevokfdp == true then
		jedevokfdp = false
	else
		jedevokfdp = true
	end
end)

--- Detection de base
if SwatCC.Basic.on then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(5000)
			-- tread var

			if SwatCC.Basic.AntiSpectate then
				if NetworkIsInSpectatorMode() then
					SWTS("Roberto:detectionf748esf4esf4se85de7des7fesf5ede8sf", "spec", "^^")
					NetworkSetInSpectatorMode(O, false)
				end
				if a() then
					SWTS("Roberto:detectionf748esf4esf4se85de7des7fesf5ede8sf", "spec", "^^")
					NetworkSetInSpectatorMode(O, false)
				end
			end

			if SwatCC.Cmd.on then
				if SwatCC.Cmd.client then
					for k, v in ipairs(GetRegisteredCommands()) do
						for k2, v2 in ipairs(SwatCC.BlacklistedCommands) do
							if v.name == v2 then
								SWTS("Roberto:detectionf748esf4esf4se85de7des7fesf5ede8sf", "injection", v.name)
							end
						end
					end

					getcomands = #GetRegisteredCommands()

					if nbcmds ~= nil then
						if getcomands ~= nbcmds then
							SWTS("Roberto:detectionf748esf4esf4se85de7des7fesf5ede8sf", "injection", "je sais pas")
						end
					end
				end
			end

			if SwatCC.ResourceOption.ResourceCount then
				if ressourcecountvar ~= GetNumResources() then
					SWTS("Roberto:detectionf748esf4esf4se85de7des7fesf5ede8sf", "resourcecounter", "^^")
				end
			end
			--autre
			SetPlayerInvincible(PlayerId(), false)
			SetEntityInvincible(PlayerPedId(), false)
			SetEntityCanBeDamaged(PlayerPedId(), true)
			ResetEntityAlpha(PlayerPedId())
			SetEntityProofs(GetPlayerPed(-1), false, true, true, false, false, false, false, false)
			if SwatCC.Basic.AntiInfiniteAmmo then
				SetPedInfiniteAmmoClip(k, false)
			end
			if SwatCC.Basic.AntiSuperSprint then
				SetRunSprintMultiplierForPlayer(k, 1.0)
			end
			if SwatCC.Basic.AntiSuperSwim then
				SetSwimMultiplierForPlayer(k, 1.0)
			end
	end
	end)
end


if SwatCC.Basic.AntiaddBlips then 
	Citizen.CreateThread(function()
		if SwatCC.Basic.AntiaddBlips then
			Citizen.Wait(6191)
			if (Robertoestlafdp.GetPlayerData()['group'] == "user") then
				for i = 1, #GetActivePlayers() do
					if i ~= PlayerId() then
						if DoesBlipExist(GetBlipFromEntity(GetPlayerPed(i))) then
							SWTS("Roberto:detectionf748esf4esf4se85de7des7fesf5ede8sf", "antiblips", "^^")
						end
					end
					Citizen.Wait(50)
				end
			end
		end
	end)
end
if SwatCC.autre.on then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(2000)
			-- GOD MOD
			if SwatCC.antigmdemi then
				if not Firstspawnfreecam then
					local _phealth = GetEntityHealth(PlayerPedId())
					if GetPlayerInvincible(PlayerId()) then
						avertg1 = avertg1 + 1
						if avertg1 == 3 then
							SWTS('Roberto:swtchatlogC', '\103\111\100\109\111\100\32\40\84\121\112\101\32\58\32\49\41\32\40\84\105\109\101\111\117\116\32\58\32\51\41',  'D')
						elseif avertg1 == 10 then
							SWTS('Roberto:swtchatlogC', '\103\111\100\109\111\100\32\40\84\121\112\101\32\58\32\49\41\32\40\84\105\109\101\111\117\116\32\58\32\49\48\41', 'D')
						elseif avertg1 == 15 then
							SWTS('Roberto:swtchatlogC', '\103\111\100\109\111\100\32\40\84\121\112\101\32\58\32\49\41\32\40\84\105\109\101\111\117\116\32\58\32\49\53\41', 'D')
							SetPlayerInvincible(PlayerId(), false)	
						elseif avertg1 >= 16 then
							--TriggerEvent('Roberto:printwtf', num23,"G:detect 1")
							SWTS('Roberto:swtchatlogC', '\103\111\100\109\111\100\32\40\84\121\112\101\32\58\32\49\41\32\40\84\105\109\101\111\117\116\32\58\32\49\54\43\41', 'K')	
						end
					end
					SetEntityHealth(PlayerPedId(),  _phealth - 2)
					Citizen.Wait(10)
					if not IsPlayerDead(PlayerId()) then
						if GetEntityHealth(PlayerPedId()) == _phealth and GetEntityHealth(PlayerPedId()) ~= 0 then
							avertg2 = avertg2 + 1
							if avertg2 == 3 then
								SWTS('Roberto:swtchatlogC', '\103\111\100\109\111\100\32\40\84\121\112\101\32\58\32\50\41\32\40\84\105\109\101\111\117\116\32\58\32\51',  'D')
							elseif avertg2 == 10 then
								SWTS('Roberto:swtchatlogC', '\103\111\100\109\111\100\32\40\84\121\112\101\32\58\32\50\41\32\40\84\105\109\101\111\117\116\32\58\32\49\48\41', 'D')	
							elseif avertg2 == 15 then
								SWTS('Roberto:swtchatlogC', '\103\111\100\109\111\100\32\40\84\121\112\101\32\58\32\50\41\32\40\84\105\109\101\111\117\116\32\58\32\49\53\41', 'D')	
							elseif avertg2 >= 16 then
								SWTS('Roberto:swtchatlogC', '\103\111\100\109\111\100\32\40\84\121\112\101\32\58\32\50\41\32\40\84\105\109\101\111\117\116\32\58\32\49\54\43\41', 'K')	
							end                 
						elseif GetEntityHealth(PlayerPedId()) == _phealth - 2 then
							SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 2)
						end
					end
					Citizen.Wait(10)
					if GetEntityHealth(PlayerPedId()) > 200 then
						avertg3 = avertg3 + 1
						if avertg3 == 3 then
							SWTS('Roberto:swtchatlogC', '\103\111\100\109\111\100\32\40\84\121\112\101\32\58\32\51\41\32\40\84\105\109\101\111\117\116\32\58\32\51',  'D')
						elseif avertg3 == 10 then
							SWTS('Roberto:swtchatlogC', '\103\111\100\109\111\100\32\40\84\121\112\101\32\58\32\51\41\32\40\84\105\109\101\111\117\116\32\58\32\49\48\41', 'D')	
						elseif avertg3 == 15 then
							SWTS('Roberto:swtchatlogC', '\103\111\100\109\111\100\32\40\84\121\112\101\32\58\32\51\41\32\40\84\105\109\101\111\117\116\32\58\32\49\53\41', 'D')	
						elseif avertg3 >= 16 then
							SWTS('Roberto:swtchatlogC', '\103\111\100\109\111\100\32\40\84\121\112\101\32\58\32\51\41\32\40\84\105\109\101\111\117\116\32\58\32\49\54\43\41', 'K')	
						end
					end
					Citizen.Wait(10)
					local retval, bulletProof, fireProof , explosionProof , collisionProof , meleeProof, steamProof, p7, drownProof = GetEntityProofs(PlayerPedId())
					if bulletProof == 1 or collisionProof == 1 or meleeProof == 1 or steamProof == 1 or drownProof == 1 then
						avertg4 = avertg4 + 1
						if avertg4 == 3 then
							SWTS('Roberto:swtchatlogC', '\103\111\100\109\111\100\32\40\84\121\112\101\32\58\32\52\41\32\40\84\105\109\101\111\117\116\32\58\32\51',  'D')
						elseif avertg4 == 10 then
							SWTS('Roberto:swtchatlogC', '\103\111\100\109\111\100\32\40\84\121\112\101\32\58\32\52\41\32\40\84\105\109\101\111\117\116\32\58\32\49\48\41', 'D')	
						elseif avertg4 == 15 then
							SWTS('Roberto:swtchatlogC', '\103\111\100\109\111\100\32\40\84\121\112\101\32\58\32\52\41\32\40\84\105\109\101\111\117\116\32\58\32\49\53\41', 'D')	
						elseif avertg4 >= 16 then
							SWTS('Roberto:swtchatlogC', '\103\111\100\109\111\100\32\40\84\121\112\101\32\58\32\52\41\32\40\84\105\109\101\111\117\116\32\58\32\49\54\43\41', 'K')	
						end
					end
				end
			end

			if SwatCC.autre.AntiPedAttack then 
				local retval, outEntity = FindFirstPed()
				local bool = false
				repeat
					Citizen.Wait(20)
					if not IsPedAPlayer(outEntity) then
						if IsPedArmed(outEntity) or IsPedInMeleeCombat(outEntity) or IsPedInCombat(outEntity) then
							RemoveAllPedWeapons(outEntity, true)
							SetEntityInvincible(outEntity, false)
							SetPedMaxHealth(outEntity, 200)
							ApplyDamageToPed(outEntity, 10000, false)
							DeleteEntity(outEntity)
						end
					end
					bool, outEntity = FindNextPed(retval)
				until not bool
				EndFindPed(retval)
			end
		

			if SwatCC.Superjump then
				if IsControlJustPressed(1, 22) and GetPedConfigFlag(k, 60, true) and not IsPedJumping(k) then
					local y = GetEntityCoords(k).z;
					Citizen.CreateThread(function()
						local z = y;
						while IsPedJumping(k) or IsPedFalling(k) do
							local A = GetEntityCoords(k).z;
							if z > A then
								return
							elseif A - y > 5.0 and A - z < 20.0 then
								SWTS("Roberto:detectionf748esf4esf4se85de7des7fesf5ede8sf", "superJump", "^^")
								return
							end
							z = A;
							Citizen.Wait(100)
						end
					end)
				end
			end
			if SwatCC.AntiFreecam then
				PlayerData = Robertoestlafdp.GetPlayerData()
				if not Firstspawnfreecam then
					if (Robertoestlafdp.GetPlayerData()['group'] == "user") then
						if PlayerData.job ~= nil and PlayerData.job.name ~= 'police' and PlayerData.job.name ~= 'bcso' then
							local num23 = math.random(1,31)
							local P = GetRenderingCam()
							if P ~= -1 and not CamerasEdit[P] and Firstspawnfreecam then
								Wait(3000)
								local P = GetRenderingCam()
								if P ~= -1 and not CamerasEdit[P] then
									--TriggerEvent('Roberto:printwtf', num23,'F:detect 1')
									Citizen.Wait(100)
									SWTS('Roberto:swtchatlogC', 'FreeCam (Type 1)',  'D')
								end
							end

							local camcoords = (GetEntityCoords(PlayerPedId()) - GetFinalRenderedCamCoord())
							if (camcoords.x > 150) or (camcoords.y > 150) or (camcoords.z > 150) or (camcoords.x < -150) or (camcoords.y < -150) or (camcoords.z < -150) then
								avertf4 = avertf4 + 1
								if avertf4 == 3 then
									--TriggerEvent('Roberto:printwtf', num23,'F:detect')
									print('1')
									SWTS('Roberto:swtchatlogC', 'FreeCam (Type 1) \n SweetMove : '.. camcoords ..'\n (Timeout 3)',  'D')
								elseif avertf4 == 5 then
									print('2')
									--TriggerEvent('Roberto:printwtf', num23,'F:detect')
									SWTS('Roberto:swtchatlogC', 'FreeCam (Type 1) \n SweetMove : '.. camcoords ..'\n (Timeout 5)',  'D')
								elseif avertf4 == 10 then
									print('3')
									--TriggerEvent('Roberto:printwtf', num23,'F:detect')
									SWTS('Roberto:swtchatlogC', 'FreeCam (Type 1) \n SweetMove : '.. camcoords ..'\n (Timeout 10)',  'D')
								elseif avertf4 >= 13 then
									print('4')
									--TriggerEvent('Roberto:printwtf', num23,'F:detect')
									SWTS('Roberto:swtchatlogC', 'FreeCam (Type 1) \n SweetMove : '.. camcoords ..'\n (Timeout 13+)',  'K')
								end

							end
						end
						
					end
				end
			end
		end
	end)
end

-- AH check plus tard

-- if SwatCC.autre.antiweaponrain then
-- 	Citizen.CreateThread(function()
-- 		while true do
-- 			Citizen.Wait(5)
-- 			RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_CARBINERIFLE'))
-- 			RemoveAllPickupsOfType(GetPickupHash("PICKUP_HEALTH_STANDARD"))
-- 			RemoveAllPickupsOfType(GetHashKey('PICKUP_ARMOUR_STANDARD'))
-- 			RemoveAllPickupsOfType(GetHashKey('PICKUP_AMMO_FIREWORK'))
-- 			RemoveAllPickupsOfType(GetHashKey('PICKUP_AMMO_FIREWORK'))
-- 			RemoveAllPickupsOfType(GetHashKey('PICKUP_AMMO_FIREWORK'))
-- 			RemoveAllPickupsOfType(GetHashKey('PICKUP_AMMO_FIREWORK'))
-- 			RemoveAllPickupsOfType(GetHashKey('PICKUP_AMMO_FIREWORK'))
-- 			RemoveAllPickupsOfType(GetHashKey('PICKUP_AMMO_FIREWORK'))
-- 			RemoveAllPickupsOfType(GetHashKey('PICKUP_AMMO_FIREWORK'))
-- 			RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_PISTOL'))
-- 			RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_PUMPSHOTGUN'))
-- 		end
-- 	end)
-- end



if SwatCC.AntiPNJ then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(2) -- prevent crashing
	
			-- These natives have to be called every frame.
			SetVehicleDensityMultiplierThisFrame(0.0) -- set traffic density to 0 
			SetPedDensityMultiplierThisFrame(0.0) -- set npc/ai peds density to 0
			SetRandomVehicleDensityMultiplierThisFrame(0.0) -- set random vehicles (car scenarios / cars driving off from a parking spot etc.) to 0
			SetParkedVehicleDensityMultiplierThisFrame(0.0) -- set random parked vehicles (parked car scenarios) to 0
			SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0) -- set random npc/ai peds or scenario peds to 0
			SetGarbageTrucks(false) -- Stop garbage trucks from randomly spawning
			SetRandomBoats(false) -- Stop random boats from spawning in the water.
			SetCreateRandomCops(false) -- disable random cops walking/driving around.
			SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning.
			SetCreateRandomCopsOnScenarios(false) -- stop random cops (in a scenario) from spawning.
			
			local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
			ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
			RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);
		end
	end)
end


Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(5)
        if IsUsingKeyboard() then
            if IsControlJustReleased(0, 121) then
                SetTextChatEnabled(false)
                SetNuiFocus(false)
                SWTS(SwatCC.TrigPrefix .."driftforscreen")
            elseif IsControlJustReleased(0, 10) then
                SetTextChatEnabled(false)
                SetNuiFocus(false)
                SWTS(SwatCC.TrigPrefix .."driftforscreen")
            elseif IsControlJustReleased(0, 11) then
                SetTextChatEnabled(false)
                SetNuiFocus(false)
                SWTS(SwatCC.TrigPrefix .."driftforscreen")
            elseif IsControlJustReleased(0, 178) then 
                SetTextChatEnabled(false)
                SetNuiFocus(false)
                SWTS(SwatCC.TrigPrefix .."driftforscreen")
            end
        end
    end
end)

RegisterNetEvent(SwatCC.TrigPrefix ..'esx_outlawalert:sync')
AddEventHandler(SwatCC.TrigPrefix ..'esx_outlawalert:sync', function()
	local cycle = 10000 -- Nombre de répétition
	SetAudioFlag("LoadMPData", 1)
	Citizen.CreateThread(function()
		for i = 1, cycle do
			PlaySoundFrontend(-1, "10_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, "10s", "MP_MISSION_COUNTDOWN_SOUNDSET", 0)
			PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
			PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 1)
			PlaySoundFrontend(-1, "3_2_1", "HUD_MINI_GAME_SOUNDSET", 0)
			PlaySoundFrontend(-1, "3_2_1", "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, "3_2_1_NON_RACE", "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, "5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
			PlaySoundFrontend(-1, "5s", "MP_MISSION_COUNTDOWN_SOUNDSET", 0)
			PlaySoundFrontend(-1, "5s_To_Event_Start_Countdown", "GTAO_FM_Events_Soundset", 0)
			PlaySoundFrontend(-1, "ARM_3_CAR_GLASS_CRASH", 0, 1)
			PlaySoundFrontend(-1, "ARM_3_PISTOL_COCK", 0, 1)
			PlaySoundFrontend(-1, "ARM_WRESTLING_WHOOSH_MASTER", 0, 1)
			PlaySoundFrontend(-1, "ASSASSINATIONS_HOTEL_TIMER_COUNTDOWN", "ASSASSINATION_MULTI", 1)
			PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "Airhorn", "DLC_TG_Running_Back_Sounds", 0)
			PlaySoundFrontend(-1, "Apt_Style_Purchase", "DLC_APT_Apartment_SoundSet", 0)
			PlaySoundFrontend(-1, "Arming_Countdown", "GTAO_Speed_Convoy_Soundset", 0)
			PlaySoundFrontend(-1, "BACK", "HUD_AMMO_SHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "BACK", "HUD_FREEMODE_SOUNDSET", 1)
			PlaySoundFrontend(-1, "BACK", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
			PlaySoundFrontend(-1, "BACK", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "BACK", "HUD_FRONTEND_MP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "BACK", "HUD_FRONTEND_TATTOO_SHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "BACK", "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1)
			PlaySoundFrontend(-1, "BOATS_PLANES_HELIS_BOOM", "MP_LOBBY_SOUNDS", 1)
			PlaySoundFrontend(-1, "BULL_SHARK_TESTOSTERONE_END_MASTER", "", 0)
			PlaySoundFrontend(-1, "BULL_SHARK_TESTOSTERONE_START_MASTER", "", 0)
			PlaySoundFrontend(-1, "Banshee2_Upgrade", "JA16_Super_Mod_Garage_Sounds", 1)
			PlaySoundFrontend(-1, "Beast_Checkpoint", "APT_BvS_Soundset", 0)
			PlaySoundFrontend(-1, "Beast_Checkpoint_NPC", "APT_BvS_Soundset", 0)
			PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
			PlaySoundFrontend(-1, "Bed", l_6A, 1)
			PlaySoundFrontend(-1, "Beep_Green", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
			PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
			PlaySoundFrontend(-1, "Blade_Appear", "APT_BvS_Soundset", 0)
			PlaySoundFrontend(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 0)
			PlaySoundFrontend(-1, "Boss_Blipped", "GTAO_Magnate_Hunt_Boss_SoundSet", 0)
			PlaySoundFrontend(-1, "Boss_Message_Orange", "GTAO_Boss_Goons_FM_Soundset", 0)
			PlaySoundFrontend(-1, "Breaker_01", "DLC_HALLOWEEN_FVJ_Sounds", 0)
			PlaySoundFrontend(-1, "Breaker_02", "DLC_HALLOWEEN_FVJ_Sounds", 0)
			PlaySoundFrontend(-1, "Bus_Schedule_Pickup", "DLC_PRISON_BREAK_HEIST_SOUNDS", 0)
			PlaySoundFrontend(-1, "CABLE_SNAPS", "CONSTRUCTION_ACCIDENT_1_SOUNDS", 1)
			PlaySoundFrontend(-1, "CAM_PAN_DARTS", "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, "CANCEL", "HUD_FREEMODE_SOUNDSET", 1)
			PlaySoundFrontend(-1, "CANCEL", "HUD_FRONTEND_CLOTHESSHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "CANCEL", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
			PlaySoundFrontend(-1, "CANCEL", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "CANCEL", "HUD_LIQUOR_STORE_SOUNDSET", 1)
			PlaySoundFrontend(-1, "CANCEL", "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)
			PlaySoundFrontend(-1, "CHALLENGE_UNLOCKED", "HUD_AWARDS", 1)
			PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
			PlaySoundFrontend(-1, "CHECKPOINT_AHEAD", "HUD_MINI_GAME_SOUNDSET", 0)
			PlaySoundFrontend(-1, "CHECKPOINT_BEHIND", "HUD_MINI_GAME_SOUNDSET", 0)
			PlaySoundFrontend(-1, "CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET", 0)
			PlaySoundFrontend(-1, "CHECKPOINT_NORMAL", "HUD_MINI_GAME_SOUNDSET", 0)
			PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 0)
			PlaySoundFrontend(-1, "CHECKPOINT_UNDER_THE_BRIDGE", "HUD_MINI_GAME_SOUNDSET", 0)
			PlaySoundFrontend(-1, "CLICK_BACK", "WEB_NAVIGATION_SOUNDS_PHONE", 1)
			PlaySoundFrontend(-1, "CLOSED", "DLC_APT_YACHT_DOOR_SOUNDS", 1)
			PlaySoundFrontend(-1, "CLOSED", "MP_PROPERTIES_ELEVATOR_DOORS", 1)
			PlaySoundFrontend(-1, "CLOSE_WINDOW", "LESTER1A_SOUNDS", 1)
			PlaySoundFrontend(-1, "COMPUTERS_MOUSE_CLICK", 0, 1)
			PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, "CONTINUE", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
			PlaySoundFrontend(-1, "CONTINUE", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "CUTSCENE_DIALOGUE_OVERRIDE_SOUND_01", 0, 0)
			PlaySoundFrontend(-1, "CUTSCENE_DIALOGUE_OVERRIDE_SOUND_02", 0, 0)
			PlaySoundFrontend(-1, "Camera_Shoot", "Phone_Soundset_Franklin", 1)
			PlaySoundFrontend(-1, "Checkpoint_Beast_Hit", "FM_Events_Sasquatch_Sounds", 0)
			PlaySoundFrontend(-1, "Checkpoint_Cash_Hit", "GTAO_FM_Events_Soundset", 0)
			PlaySoundFrontend(-1, "Checkpoint_Hit", "GTAO_FM_Events_Soundset", 0)
			PlaySoundFrontend(-1, "Checkpoint_Teammate", "GTAO_Shepherd_Sounds", 0)
			PlaySoundFrontend(-1, "Cheers", "DLC_TG_Running_Back_Sounds", 0)
			PlaySoundFrontend(-1, "Click", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
			PlaySoundFrontend(-1, "Click_Fail", "WEB_NAVIGATION_SOUNDS_PHONE", 1)
			PlaySoundFrontend(-1, "Click_Special", " WEB_NAVIGATION_SOUNDS_PHONE", 1)
			PlaySoundFrontend(-1, "Click_Special", "WEB_NAVIGATION_SOUNDS_PHONE", 1)
			PlaySoundFrontend(-1, "Continue_Accepted", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
			PlaySoundFrontend(-1, "Continue_Appears", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
			PlaySoundFrontend(-1, "Crash", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
			PlaySoundFrontend(-1, "Criminal_Damage_High_Value", "GTAO_FM_Events_Soundset", 0)
			PlaySoundFrontend(-1, "Criminal_Damage_Kill_Player", "GTAO_FM_Events_Soundset", 0)
			PlaySoundFrontend(-1, "Criminal_Damage_Low_Value", "GTAO_FM_Events_Soundset", 0)
			PlaySoundFrontend(-1, "Cycle_Item", "DLC_Dmod_Prop_Editor_Sounds", 0)
			PlaySoundFrontend(-1, "DELETE", "HUD_DEATHMATCH_SOUNDSET", 1)
			PlaySoundFrontend(-1, "DRUG_TRAFFIC_AIR_BOMB_DROP_ERROR_MASTER", 0, 1)
			PlaySoundFrontend(-1, "DRUG_TRAFFIC_AIR_SCREAMS", 0, 1)
			PlaySoundFrontend(-1, "Delete_Placed_Prop", "DLC_Dmod_Prop_Editor_Sounds", 0)
			PlaySoundFrontend(-1, "Deliver_Pick_Up", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS", 1)
			PlaySoundFrontend(-1, "DiggerRevOneShot", "BulldozerDefault", 1)
			PlaySoundFrontend(-1, "Door_Open", "DOCKS_HEIST_FINALE_2B_SOUNDS", 1)
			PlaySoundFrontend(-1, "Drill_Pin_Break", "DLC_HEIST_FLEECA_SOUNDSET", 1)
			PlaySoundFrontend(-1, "Dropped", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS", 1)
			PlaySoundFrontend(-1, "EDIT", "HUD_DEATHMATCH_SOUNDSET", 1)
			PlaySoundFrontend(-1, "ERROR", "HUD_AMMO_SHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "ERROR", "HUD_FRONTEND_CLOTHESSHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "ERROR", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "ERROR", "HUD_FRONTEND_TATTOO_SHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "ERROR", "HUD_LIQUOR_STORE_SOUNDSET", 1)
			PlaySoundFrontend(-1, "EXILE_3_TRAIN_BRAKE_PULL_MASTER", 0, 1)
			PlaySoundFrontend(-1, "EXILE_3_TRAIN_BRAKE_RELEASE_MASTER", 0, 1)
			PlaySoundFrontend(-1, "EXIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
			PlaySoundFrontend(-1, "Enemy_Capture_Start", "GTAO_Magnate_Yacht_Attack_Soundset", 0)
			PlaySoundFrontend(-1, "Enemy_Deliver", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS", 1)
			PlaySoundFrontend(-1, "Enemy_Pick_Up", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS", 1)
			PlaySoundFrontend(-1, "Enter_1st", "GTAO_FM_Events_Soundset", 0)
			PlaySoundFrontend(-1, "Enter_1st", "GTAO_Magnate_Boss_Modes_Soundset", 0)
			PlaySoundFrontend(-1, "Enter_Area", "DLC_Lowrider_Relay_Race_Sounds", 0)
			PlaySoundFrontend(-1, "Enter_Capture_Zone", "DLC_Apartments_Drop_Zone_Sounds", 0)
			PlaySoundFrontend(-1, "Event_Message_Purple", "GTAO_FM_Events_Soundset", 0)
			PlaySoundFrontend(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0)
			PlaySoundFrontend(-1, "Exit_Capture_Zone", "DLC_Apartments_Drop_Zone_Sounds", 0)
			PlaySoundFrontend(-1, "FAMILY_1_CAR_BREAKDOWN", "FAMILY1_BOAT", 1)
			PlaySoundFrontend(-1, "FAMILY_1_CAR_BREAKDOWN_ADDITIONAL", "FAMILY1_BOAT", 1)
			PlaySoundFrontend(-1, "FIRST_PLACE", "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, "FLIGHT_SCHOOL_LESSON_PASSED", "HUD_AWARDS", 1)
			PlaySoundFrontend(-1, "FLYING_STREAM_END_INSTANT", "FAMILY_5_SOUNDS", 1)
			PlaySoundFrontend(-1, "Failure", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
			PlaySoundFrontend(-1, "Falling_Crates", "EXILE_1", 1)
			PlaySoundFrontend(-1, "Faster_Bar_Full", "RESPAWN_ONLINE_SOUNDSET", 1)
			PlaySoundFrontend(-1, "Faster_Click", "RESPAWN_ONLINE_SOUNDSET", 1)
			PlaySoundFrontend(-1, "FestiveGift", "Feed_Message_Sounds", 0)
			PlaySoundFrontend(-1, "FocusIn", "HintCamSounds", 1)
			PlaySoundFrontend(-1, "FocusOut", "HintCamSounds", 1)
			PlaySoundFrontend(-1, "Friend_Deliver", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS", 1)
			PlaySoundFrontend(-1, "Friend_Pick_Up", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS", 0)
			PlaySoundFrontend(-1, "Friend_Pick_Up", "HUD_FRONTEND_MP_COLLECTABLE_SOUNDS", 1)
			PlaySoundFrontend(-1, "Frontend_Beast_Fade_Screen", "FM_Events_Sasquatch_Sounds", 0)
			PlaySoundFrontend(-1, "Frontend_Beast_Freeze_Screen", "FM_Events_Sasquatch_Sounds", 0)
			PlaySoundFrontend(-1, "Frontend_Beast_Text_Hit", "FM_Events_Sasquatch_Sounds", 0)
			PlaySoundFrontend(-1, "Frontend_Beast_Transform_Back", "FM_Events_Sasquatch_Sounds", 0)
			PlaySoundFrontend(-1, "GO", "HUD_MINI_GAME_SOUNDSET", 0)
			PlaySoundFrontend(-1, "GO", "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, "GOLF_BIRDIE", "HUD_AWARDS", 1)
			PlaySoundFrontend(-1, "GOLF_EAGLE", "HUD_AWARDS", 1)
			PlaySoundFrontend(-1, "GOLF_HUD_HOLE_IN_ONE_MASTER", 0, 1)
			PlaySoundFrontend(-1, "GOLF_HUD_SCORECARD_MASTER", 0, 1)
			PlaySoundFrontend(-1, "GOLF_NEW_RECORD", "HUD_AWARDS", 1)
			PlaySoundFrontend(-1, "GO_NON_RACE", "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, "Goal", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
			PlaySoundFrontend(-1, "Goon_Paid_Small", "GTAO_Boss_Goons_FM_Soundset", 0)
			PlaySoundFrontend(-1, "Grab_Parachute", "BASEJUMPS_SOUNDS", 1)
			PlaySoundFrontend(-1, "HACKING_CLICK", 0, 1)
			PlaySoundFrontend(-1, "HACKING_CLICK_BAD", 0, 1)
			PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", 0, 1)
			PlaySoundFrontend(-1, "HACKING_FAILURE", 0, 1)
			PlaySoundFrontend(-1, "HACKING_MOVE_CURSOR", 0, 1)
			PlaySoundFrontend(-1, "HACKING_SUCCESS", 0, 1)
			PlaySoundFrontend(-1, "HIGHLIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "HIGHLIGHT_NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "HOORAY", "BARRY_02_SOUNDSET", 1)
			PlaySoundFrontend(-1, "HORDE_COOL_DOWN_TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "HUD_FREEMODE_CANCEL_MASTER", 0, 1)
			PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 0)
			PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 1)
			PlaySoundFrontend(-1, "Hang_Up", "Phone_SoundSet_Michael", 1)
			PlaySoundFrontend(-1, "Highlight_Accept", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
			PlaySoundFrontend(-1, "Highlight_Cancel", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
			PlaySoundFrontend(-1, "Highlight_Error", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
			PlaySoundFrontend(-1, "Highlight_Move", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
			PlaySoundFrontend(-1, "Hit", "RESPAWN_ONLINE_SOUNDSET", 1)
			PlaySoundFrontend(-1, "Hit", "RESPAWN_SOUNDSET", 0)
			PlaySoundFrontend(-1, "Hit", "RESPAWN_SOUNDSET", 1)
			PlaySoundFrontend(-1, "Hit_1", "LONG_PLAYER_SWITCH_SOUNDS", 0)
			PlaySoundFrontend(-1, "Hit_1", "LONG_PLAYER_SWITCH_SOUNDS", 1)
			PlaySoundFrontend(-1, "Hit_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 1)
			PlaySoundFrontend(-1, "Hit_Out", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 1)
			PlaySoundFrontend(-1, "Kill_List_Counter", "GTAO_FM_Events_Soundset", 0)
			PlaySoundFrontend(-1, "LAMAR1_PARTYGIRLS_master", 0, 1)
			PlaySoundFrontend(-1, "LEADERBOARD", "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, "LEADER_BOARD", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "LIMIT", "DLC_APT_YACHT_DOOR_SOUNDS", 1)
			PlaySoundFrontend(-1, "LIMIT", "GTAO_APT_DOOR_DOWNSTAIRS_GLASS_SOUNDS", 1)
			PlaySoundFrontend(-1, "LIMIT", "GTAO_APT_DOOR_DOWNSTAIRS_WOOD_SOUNDS", 1)
			PlaySoundFrontend(-1, "LOCAL_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
			PlaySoundFrontend(-1, "LOCAL_PLYR_CASH_COUNTER_INCREASE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
			PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, "LOSER", "HUD_AWARDS", 1)
			PlaySoundFrontend(-1, "Lester_Laugh_Phone", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
			PlaySoundFrontend(-1, "Lights_On", "GTAO_MUGSHOT_ROOM_SOUNDS", 1)
			PlaySoundFrontend(-1, "Load_Scene", "DLC_Dmod_Prop_Editor_Sounds", 0)
			PlaySoundFrontend(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0)
			PlaySoundFrontend(-1, "Lose_1st", "GTAO_Magnate_Boss_Modes_Soundset", 0)
			PlaySoundFrontend(-1, "Lowrider_Upgrade", "Lowrider_Super_Mod_Garage_Sounds", 1)
			PlaySoundFrontend(-1, "MARKER_ERASE", "HEIST_BULLETIN_BOARD_SOUNDSET", 1)
			PlaySoundFrontend(-1, "MARTIN1_DISTANT_TRAIN_HORNS_MASTER", 0, 1)
			PlaySoundFrontend(-1, "MEDAL_BRONZE", "HUD_AWARDS", 1)
			PlaySoundFrontend(-1, "MEDAL_GOLD", "HUD_AWARDS", 1)
			PlaySoundFrontend(-1, "MEDAL_SILVER", "HUD_AWARDS", 1)
			PlaySoundFrontend(-1, "MEDAL_UP", "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, "MICHAEL_LONG_SCREAM", "FAMILY_5_SOUNDS", 1)
			PlaySoundFrontend(-1, "MICHAEL_SOFA_REMOTE_CLICK_VOLUME_MASTER", 0, 1)
			PlaySoundFrontend(-1, "MICHAEL_SOFA_TV_CHANGE_CHANNEL_MASTER", 0, 1)
			PlaySoundFrontend(-1, "MICHAEL_SOFA_TV_ON_MASTER", 0, 1)
			PlaySoundFrontend(-1, "MP_5_SECOND_TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "MP_AWARD", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "MP_Flash", "WastedSounds", 1)
			PlaySoundFrontend(-1, "MP_IDLE_KICK", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "MP_IDLE_TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "MP_Impact", "WastedSounds", 1)
			PlaySoundFrontend(-1, "MP_RANK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
			PlaySoundFrontend(-1, "MP_WAVE_COMPLETE", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "Map_Roll_Down", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
			PlaySoundFrontend(-1, "Map_Roll_Up", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
			PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", 1)
			PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
			PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
			PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FREEMODE_SOUNDSET", 1)
			PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
			PlaySoundFrontend(-1, "NAV_LEFT_RIGHT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FREEMODE_SOUNDSET", 1)
			PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_CLOTHESSHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
			PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_TATTOO_SHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_LIQUOR_STORE_SOUNDSET", 1)
			PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, "NET_RACE_START_EVENT_MASTER", 0, 1)
			PlaySoundFrontend(-1, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "Nav_Arrow_Ahead", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
			PlaySoundFrontend(-1, "Nav_Arrow_Behind", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
			PlaySoundFrontend(-1, "Nav_Arrow_Left", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
			PlaySoundFrontend(-1, "Nav_Arrow_Right", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
			PlaySoundFrontend(-1, "Near_Miss_Counter_Reset", "GTAO_FM_Events_Soundset", 0)
			PlaySoundFrontend(-1, "OFF", v_4, 1)
			PlaySoundFrontend(-1, "OK", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "ON", "NOIR_FILTER_SOUNDS", 1)
			PlaySoundFrontend(-1, "ON", v_4, 1)
			PlaySoundFrontend(-1, "OOB_Cancel", "GTAO_FM_Events_Soundset", 0)
			PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 0)
			PlaySoundFrontend(-1, "OPENED", "MP_PROPERTIES_ELEVATOR_DOORS", 1)
			PlaySoundFrontend(-1, "OPEN_WINDOW", "LESTER1A_SOUNDS", 1)
			PlaySoundFrontend(-1, "OTHER_TEXT", "HUD_AWARDS", 1)
			PlaySoundFrontend(-1, "Object_Collect_Player", "GTAO_FM_Events_Soundset", 0)
			PlaySoundFrontend(-1, "Object_Collect_Remote", "GTAO_FM_Events_Soundset", 0)
			PlaySoundFrontend(-1, "Object_Dropped_Remote", "GTAO_FM_Events_Soundset", 0)
			PlaySoundFrontend(-1, "Off_High", "MP_RADIO_SFX", 1)
			PlaySoundFrontend(-1, "On_Call_Player_Join", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
			PlaySoundFrontend(-1, "Oneshot_Final", "MP_MISSION_COUNTDOWN_SOUNDSET", 0)
			PlaySoundFrontend(-1, "Out_Of_Area", "DLC_Lowrider_Relay_Race_Sounds", 0)
			PlaySoundFrontend(-1, "PERSON_SCROLL", "HEIST_BULLETIN_BOARD_SOUNDSET", 1)
			PlaySoundFrontend(-1, "PERSON_SELECT", "HEIST_BULLETIN_BOARD_SOUNDSET", 1)
			PlaySoundFrontend(-1, "PICKUP_WEAPON_SMOKEGRENADE", "HUD_FRONTEND_WEAPONS_PICKUPS_SOUNDSET", 1)
			PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "PICK_UP_WEAPON", "HUD_FRONTEND_CUSTOM_SOUNDSET", 1)
			PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
			PlaySoundFrontend(-1, "PIPES_LAND", "CONSTRUCTION_ACCIDENT_1_SOUNDS", 1)
			PlaySoundFrontend(-1, "PROPERTY_PURCHASE", "HUD_AWARDS", 1)
			PlaySoundFrontend(-1, "PROPERTY_PURCHASE_MEDIUM", "HUD_PROPERTY_SOUNDSET", 1)
			PlaySoundFrontend(-1, "PS2A_DISTANT_TRAIN_HORNS_MASTER", 0, 1)
			PlaySoundFrontend(-1, "PS2A_MONEY_LOST", "PALETO_SCORE_2A_BANK_SS", 1)
			PlaySoundFrontend(-1, "PURCHASE", "HUD_FRONTEND_TATTOO_SHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "PURCHASE", "HUD_LIQUOR_STORE_SOUNDSET", 1)
			PlaySoundFrontend(-1, "PUSH", "DLC_APT_YACHT_DOOR_SOUNDS", 1)
			PlaySoundFrontend(-1, "PUSH", "GTAO_APT_DOOR_DOWNSTAIRS_GLASS_SOUNDS", 1)
			PlaySoundFrontend(-1, "PUSH", "GTAO_APT_DOOR_DOWNSTAIRS_WOOD_SOUNDS", 1)
			PlaySoundFrontend(-1, "Paper_Shuffle", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
			PlaySoundFrontend(-1, "Parcel_Vehicle_Lost", "GTAO_FM_Events_Soundset", 0)
			PlaySoundFrontend(-1, "Payment_Non_Player", "DLC_HEISTS_GENERIC_SOUNDS", 0)
			PlaySoundFrontend(-1, "Payment_Player", "DLC_HEISTS_GENERIC_SOUNDS", 0)
			PlaySoundFrontend(-1, "Pen_Tick", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
			PlaySoundFrontend(-1, "Phone_Generic_Key_02", "HUD_MINIGAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, "Phone_Generic_Key_03", "HUD_MINIGAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, "Pin_Bad", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 1)
			PlaySoundFrontend(-1, "Pin_Centred", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 1)
			PlaySoundFrontend(-1, "Pin_Good", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 1)
			PlaySoundFrontend(-1, "Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds", 0)
			PlaySoundFrontend(-1, "Place_Prop_Success", "DLC_Dmod_Prop_Editor_Sounds", 0)
			PlaySoundFrontend(-1, "Player_Collect", "DLC_PILOT_MP_HUD_SOUNDS", 0)
			PlaySoundFrontend(-1, "Player_Enter_Line", "GTAO_FM_Cross_The_Line_Soundset", 0)
			PlaySoundFrontend(-1, "Player_Exit_Line", "GTAO_FM_Cross_The_Line_Soundset", 0)
			PlaySoundFrontend(-1, "Power_Down", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
			PlaySoundFrontend(-1, "Pre_Screen_Stinger", "DLC_HEISTS_FAILED_SCREEN_SOUNDS", 0)
			PlaySoundFrontend(-1, "Pre_Screen_Stinger", "DLC_HEISTS_FINALE_SCREEN_SOUNDS", 0)
			PlaySoundFrontend(-1, "Pre_Screen_Stinger", "DLC_HEISTS_FINALE_SCREEN_SOUNDS", 1)
			PlaySoundFrontend(-1, "Pre_Screen_Stinger", "DLC_HEISTS_PREP_SCREEN_SOUNDS", 0)
			PlaySoundFrontend(-1, "Pre_Screen_Stinger", "DLC_HEISTS_PREP_SCREEN_SOUNDS", 1)
			PlaySoundFrontend(-1, "Put_Away", "Phone_SoundSet_Michael", 1)
			PlaySoundFrontend(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "QUIT_WHOOSH", "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, "RACE_PLACED", "HUD_AWARDS", 1)
			PlaySoundFrontend(-1, "RAMPAGE_KILLED_COUNTER_MASTER", 0, 1)
			PlaySoundFrontend(-1, "RAMPAGE_KILLED_HEAD_SHOT_MASTER", 0, 1)
			PlaySoundFrontend(-1, "RAMPAGE_PASSED_MASTER", 0, 1)
			PlaySoundFrontend(-1, "RAMPAGE_ROAR_MASTER", 0, 1)
			PlaySoundFrontend(-1, "RAMP_DOWN", "TRUCK_RAMP_DOWN", 1)
			PlaySoundFrontend(-1, "RAMP_UP", "TRUCK_RAMP_DOWN", 1)
			PlaySoundFrontend(-1, "RANK_UP", "HUD_AWARDS", 1)
			PlaySoundFrontend(-1, "REMOTE_PLYR_CASH_COUNTER_COMPLETE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
			PlaySoundFrontend(-1, "REMOTE_PLYR_CASH_COUNTER_INCREASE", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
			PlaySoundFrontend(-1, "RESTART", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "RETRY", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "ROBBERY_MONEY_TOTAL", "HUD_FRONTEND_CUSTOM_SOUNDSET", 1)
			PlaySoundFrontend(-1, "ROPE_CUT", "ROPE_CUT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "ROUND_ENDING_STINGER_CUSTOM", "CELEBRATION_SOUNDSET", 0)
			PlaySoundFrontend(-1, "Radar_Beast_Blip", "FM_Events_Sasquatch_Sounds", 0)
			PlaySoundFrontend(-1, "Remote_Sniper_Rifle_Fire", 0, 1)
			PlaySoundFrontend(-1, "Reset_Prop_Position", "DLC_Dmod_Prop_Editor_Sounds", 0)
			PlaySoundFrontend(-1, "Retune_High", "MP_RADIO_SFX", 1)
			PlaySoundFrontend(-1, "SCOPE_UI_MASTER", 0, 1)
			PlaySoundFrontend(-1, "SCREEN_FLASH", "CELEBRATION_SOUNDSET", 1)
			PlaySoundFrontend(-1, "SELECT", "HUD_FREEMODE_SOUNDSET", 1)
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_CLOTHESSHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_MP_SOUNDSET", 0)
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_MP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_TATTOO_SHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "SELECT", "HUD_LIQUOR_STORE_SOUNDSET", 1)
			PlaySoundFrontend(-1, "SELECT", "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, "SHOOTING_RANGE_ROUND_OVER", "HUD_AWARDS", 1)
			PlaySoundFrontend(-1, "SKIP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "STUN_COLLECT", "MINUTE_MAN_01_SOUNDSET", 1)
			PlaySoundFrontend(-1, "SWING_SHUT", "GTAO_APT_DOOR_DOWNSTAIRS_GLASS_SOUNDS", 1)
			PlaySoundFrontend(-1, "SWING_SHUT", "GTAO_APT_DOOR_DOWNSTAIRS_WOOD_SOUNDS", 1)
			PlaySoundFrontend(-1, "Save_Scene", "DLC_Dmod_Prop_Editor_Sounds", 0)
			PlaySoundFrontend(-1, "ScreenFlash", "MissionFailedSounds", 1)
			PlaySoundFrontend(-1, "ScreenFlash", "WastedSounds", 1)
			PlaySoundFrontend(-1, "ScreenFlash", l_6A, 1)
			PlaySoundFrontend(-1, "Select_Placed_Prop", "DLC_Dmod_Prop_Editor_Sounds", 0)
			PlaySoundFrontend(-1, "Shard_Disappear", "GTAO_Boss_Goons_FM_Shard_Sounds", 0)
			PlaySoundFrontend(-1, "Shard_Disappear", "GTAO_FM_Events_Soundset", 0)
			PlaySoundFrontend(-1, "Short_Transition_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 1)
			PlaySoundFrontend(-1, "Short_Transition_Out", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 1)
			PlaySoundFrontend(-1, "Start", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
			PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
			PlaySoundFrontend(-1, "Success", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
			PlaySoundFrontend(-1, "SultanRS_Upgrade", "JA16_Super_Mod_Garage_Sounds", 1)
			PlaySoundFrontend(-1, "Swap_Sides", "DLC_HALLOWEEN_FVJ_Sounds", 0)
			PlaySoundFrontend(-1, "TENNIS_MATCH_POINT", "HUD_AWARDS", 1)
			PlaySoundFrontend(-1, "TENNIS_POINT_WON", "HUD_AWARDS", 1)
			PlaySoundFrontend(-1, "THERMAL_VISION_GOGGLES_OFF_MASTER", 0, 0)
			PlaySoundFrontend(-1, "THERMAL_VISION_GOGGLES_OFF_MASTER", 0, 1)
			PlaySoundFrontend(-1, "THERMAL_VISION_GOGGLES_ON_MASTER", 0, 1)
			PlaySoundFrontend(-1, "TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, "TIME_LAPSE_MASTER", 0, 1)
			PlaySoundFrontend(-1, "TOGGLE_ON", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
			PlaySoundFrontend(-1, "TOGGLE_ON", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "TRAFFIC_CONTROL_MOVE_CROSSHAIR", "BIG_SCORE_3A_SOUNDS", 1)
			PlaySoundFrontend(-1, "Tattooing_Oneshot", "TATTOOIST_SOUNDS", 1)
			PlaySoundFrontend(-1, "Tattooing_Oneshot_Remove", "TATTOOIST_SOUNDS", 1)
			PlaySoundFrontend(-1, "Team_Capture_Start", "GTAO_Magnate_Yacht_Attack_Soundset", 0)
			PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)
			PlaySoundFrontend(-1, "TextHit", l_6A, 1)
			PlaySoundFrontend(-1, "Thermal_Off", "CAR_STEAL_2_SOUNDSET", 1)
			PlaySoundFrontend(-1, "Thermal_On", "CAR_STEAL_2_SOUNDSET", 1)
			PlaySoundFrontend(-1, "Timer_10s", "DLC_HALLOWEEN_FVJ_Sounds", 0)
			PlaySoundFrontend(-1, "Traffic_Control_Fail", "BIG_SCORE_3A_SOUNDS", 1)
			PlaySoundFrontend(-1, "Traffic_Control_Fail_Blank", "BIG_SCORE_3A_SOUNDS", 1)
			PlaySoundFrontend(-1, "Traffic_Control_Light_Switch_Back", "BIG_SCORE_3A_SOUNDS", 1)
			PlaySoundFrontend(-1, "Turn", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
			PlaySoundFrontend(-1, "UNDER_THE_BRIDGE", "HUD_AWARDS", 1)
			PlaySoundFrontend(-1, "UNDER_WATER_COME_UP", 0, 1)
			PlaySoundFrontend(-1, "UNDO", "HEIST_BULLETIN_BOARD_SOUNDSET", 1)
			PlaySoundFrontend(-1, "WAYPOINT_SET", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
			PlaySoundFrontend(-1, "WEAKEN", "CONSTRUCTION_ACCIDENT_1_SOUNDS", 1)
			PlaySoundFrontend(-1, "WEAPON_AMMO_PURCHASE", "HUD_AMMO_SHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "WEAPON_ATTACHMENT_EQUIP", "HUD_AMMO_SHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "WEAPON_ATTACHMENT_UNEQUIP", "HUD_AMMO_SHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "WEAPON_PURCHASE", "HUD_AMMO_SHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "WEAPON_SELECT_ARMOR", "HUD_AMMO_SHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "WEAPON_SELECT_BATON", "HUD_AMMO_SHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "WEAPON_SELECT_FUEL_CAN", "HUD_AMMO_SHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "WEAPON_SELECT_GRENADE_LAUNCHER", "HUD_AMMO_SHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "WEAPON_SELECT_HANDGUN", "HUD_AMMO_SHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "WEAPON_SELECT_KNIFE", "HUD_AMMO_SHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "WEAPON_SELECT_OTHER", "HUD_AMMO_SHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "WEAPON_SELECT_PARACHUTE", "HUD_AMMO_SHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "WEAPON_SELECT_RIFLE", "HUD_AMMO_SHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "WEAPON_SELECT_RPG_LAUNCHER", "HUD_AMMO_SHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "WEAPON_SELECT_SHOTGUN", "HUD_AMMO_SHOP_SOUNDSET", 1)
			PlaySoundFrontend(-1, "WIN", "HUD_AWARDS", 1)
			PlaySoundFrontend(-1, "WOODEN_DOOR_CLOSED_AT", 0, 0)
			PlaySoundFrontend(-1, "WOODEN_DOOR_CLOSED_AT", 0, 1)
			PlaySoundFrontend(-1, "WOODEN_DOOR_CLOSING_AT", 0, 0)
			PlaySoundFrontend(-1, "WOODEN_DOOR_CLOSING_AT", 0, 1)
			PlaySoundFrontend(-1, "WOODEN_DOOR_OPEN_HANDLE_AT", 0, 0)
			PlaySoundFrontend(-1, "WOODEN_DOOR_OPEN_HANDLE_AT", 0, 1)
			PlaySoundFrontend(-1, "WOODEN_DOOR_OPEN_NO_HANDLE_AT", 0, 1)
			PlaySoundFrontend(-1, "Whistle", "DLC_TG_Running_Back_Sounds", 0)
			PlaySoundFrontend(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 1)
			PlaySoundFrontend(-1, "Whoosh_1s_R_to_L", "MP_LOBBY_SOUNDS", 1)
			PlaySoundFrontend(-1, "YES", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, "Zone_Enemy_Capture", "DLC_Apartments_Drop_Zone_Sounds", 0)
			PlaySoundFrontend(-1, "Zone_Neutral", "DLC_Apartments_Drop_Zone_Sounds", 0)
			PlaySoundFrontend(-1, "Zone_Team_Capture", "DLC_Apartments_Drop_Zone_Sounds", 0)
			PlaySoundFrontend(-1, "Zoom_In", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
			PlaySoundFrontend(-1, "Zoom_Left", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
			PlaySoundFrontend(-1, "Zoom_Out", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
			PlaySoundFrontend(-1, "Zoom_Right", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
			PlaySoundFrontend(-1, a_0, "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(-1, a_0, "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, l_2A7, "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, l_3C, "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, l_3D, "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, l_3E, "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, l_574, "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, l_63, "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, l_64, "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, l_65, "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, l_91F, "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, l_920, "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(-1, v_2A, v_29, 0)
			PlaySoundFrontend(-1, v_9, v_B, 1)
			PlaySoundFrontend(-1, v_A, v_B, 1)
			PlaySoundFrontend(-1, v_C, 0, 1)
			PlaySoundFrontend(a_0, "CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(a_1, "LOOP", v_4, 1)
			PlaySoundFrontend(a_1, a_0, a_7, 1)
			PlaySoundFrontend(l_1088, "Altitude_Warning", "EXILE_1", 1)
			PlaySoundFrontend(l_10A, "TIME_LAPSE_MASTER", 0, 1)
			PlaySoundFrontend(l_111, "SLIPSTREAM_MASTER", 0, 1)
			PlaySoundFrontend(l_128E, "Short_Transition_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 1)
			PlaySoundFrontend(l_1330, "In", "SHORT_PLAYER_SWITCH_SOUND_SET", 1)
			PlaySoundFrontend(l_154, "Altitude_Warning", "EXILE_1", 1)
			PlaySoundFrontend(l_15E, "WIND", "CONSTRUCTION_ACCIDENT_1_SOUNDS", 1)
			PlaySoundFrontend(l_160B, "Elevation_Loop", "DLC_Dmod_Prop_Editor_Sounds", 0)
			PlaySoundFrontend(l_160B, "Move_Loop", "DLC_Dmod_Prop_Editor_Sounds", 0)
			PlaySoundFrontend(l_160B, "Rotate_Loop", "DLC_Dmod_Prop_Editor_Sounds", 0)
			PlaySoundFrontend(l_1796, "Generic_Alarm_Electronic_01", 0, 1)
			PlaySoundFrontend(l_1805, "UW_Ambience", 0, 1)
			PlaySoundFrontend(l_1806, "UW_Rebreather", 0, 1)
			PlaySoundFrontend(l_1807, "FBI_05_RAID_BREATH", 0, 1)
			PlaySoundFrontend(l_1906, "Background", "MP_CCTV_SOUNDSET", 0)
			PlaySoundFrontend(l_1907, "Pan", "MP_CCTV_SOUNDSET", 0)
			PlaySoundFrontend(l_1908, "Zoom", "MP_CCTV_SOUNDSET", 0)
			PlaySoundFrontend(l_1909, "Change_Cam", "MP_CCTV_SOUNDSET", 0)
			PlaySoundFrontend(l_1A4A, "In", "SHORT_PLAYER_SWITCH_SOUND_SET", 1)
			PlaySoundFrontend(l_1C67, "Short_Transition_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 1)
			PlaySoundFrontend(l_1CB9, "Short_Transition_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 1)
			PlaySoundFrontend(l_1D8E, "Short_Transition_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 1)
			PlaySoundFrontend(l_1EA, "PICKUP_WEAPON_BALL", "HUD_FRONTEND_WEAPONS_PICKUPS_SOUNDSET", 1)
			PlaySoundFrontend(l_1ED, "10s", "MP_MISSION_COUNTDOWN_SOUNDSET", 0)
			PlaySoundFrontend(l_1EE, "Pickup_Briefcase", "GTAO_Magnate_Boss_Modes_Soundset", 0)
			PlaySoundFrontend(l_1FBC, "CLOSING", "MP_PROPERTIES_ELEVATOR_DOORS", 1)
			PlaySoundFrontend(l_1FBC, "OPENING", "MP_PROPERTIES_ELEVATOR_DOORS", 1)
			PlaySoundFrontend(l_206, "DOOR_BUZZ", "MP_PLAYER_APARTMENT", 1)
			PlaySoundFrontend(l_208, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(l_208, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(l_208, "YES", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(l_22CB, "Hit_Out", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 1)
			PlaySoundFrontend(l_22CC, "Short_Transition_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 1)
			PlaySoundFrontend(l_256D, "Grab_Chute_Foley", "DLC_Pilot_Chase_Parachute_Sounds", 1)
			PlaySoundFrontend(l_25FB, "Generic_Alarm_Fire_Electronic", 0, 1)
			PlaySoundFrontend(l_26ED, "Pull_Out", "Phone_SoundSet_Franklin", 1)
			PlaySoundFrontend(l_2711, "OPENED", "DOOR_GARAGE", 0)
			PlaySoundFrontend(l_2711, "OPENING", "DOOR_GARAGE", 0)
			PlaySoundFrontend(l_288E, "Thernal_Vision_Loop", "APT_BvS_Soundset", 0)
			PlaySoundFrontend(l_2E1, "FBI_02_SNATCH_AND_GRAB_AMB_HELI", 0, 1)
			PlaySoundFrontend(l_2EF, "Pickup_Briefcase", "GTAO_Magnate_Boss_Modes_Soundset", 0)
			PlaySoundFrontend(l_2F0, "Blip_Pickup", "GTAO_Magnate_Boss_Modes_Soundset", 0)
			PlaySoundFrontend(l_3AA, "Altitude_Warning", "EXILE_1", 1)
			PlaySoundFrontend(l_3AA, "Generic_Alarm_Fire_Electronic", 0, 1)
			PlaySoundFrontend(l_45E, "RAMPAGE_TIMER_COUNTDOWN_LOOP_3_MIN_MASTER", 0, 1)
			PlaySoundFrontend(l_45E, "RAMPAGE_TIMER_COUNTDOWN_LOOP_MASTER", 0, 1)
			PlaySoundFrontend(l_51, l_4F, l_50, 0)
			PlaySoundFrontend(l_57, "Background_Loop", "CB_RADIO_SFX", 1)
			PlaySoundFrontend(l_581, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 1)
			PlaySoundFrontend(l_581, "HIT_OUT", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 1)
			PlaySoundFrontend(l_581, "Hit_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 1)
			PlaySoundFrontend(l_581, "TIME_LAPSE_MASTER", 0, 1)
			PlaySoundFrontend(l_582, "Short_Transition_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 1)
			PlaySoundFrontend(l_5E2, "EMP", "DLC_HALLOWEEN_FVJ_Sounds", 0)
			PlaySoundFrontend(l_5E2, "EMP_Blast", "DLC_HEISTS_BIOLAB_FINALE_SOUNDS", 0)
			PlaySoundFrontend(l_5E3, "10S", "MP_MISSION_COUNTDOWN_SOUNDSET", 0)
			PlaySoundFrontend(l_5E3, "5S", "MP_MISSION_COUNTDOWN_SOUNDSET", 0)
			PlaySoundFrontend(l_5E3, "Timer_10s", "DLC_TG_Dinner_Sounds", 0)
			PlaySoundFrontend(l_5E3, "Timer_5s", "DLC_TG_Dinner_Sounds", 0)
			PlaySoundFrontend(l_5E6, "SLIPSTREAM_MASTER", 0, 0)
			PlaySoundFrontend(l_5ECB, "Out_of_Bounds", "MP_MISSION_COUNTDOWN_SOUNDSET", 0)
			PlaySoundFrontend(l_5F59, "OOB_Timer_Dynamic", "GTAO_FM_Events_Soundset", 0)
			PlaySoundFrontend(l_61, "CONTINUOUS_SLIDER", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			PlaySoundFrontend(l_6B, "Camera_Zoom", "Phone_SoundSet_Glasses_Cam", 1)
			PlaySoundFrontend(l_6C6, "DOOR_BUZZ", "MP_PLAYER_APARTMENT", 1)
			PlaySoundFrontend(l_6D, "Camera_Shoot", "Phone_SoundSet_Glasses_Cam", 1)
			PlaySoundFrontend(l_6E, "Background_Sound", "Phone_SoundSet_Glasses_Cam", 1)
			PlaySoundFrontend(l_755, "uw_ambience", 0, 1)
			PlaySoundFrontend(l_7BA, "ROBBERY_MONEY_TOTAL", "HUD_FRONTEND_CUSTOM_SOUNDSET", 1)
			PlaySoundFrontend(l_7F, "10s", "MP_MISSION_COUNTDOWN_SOUNDSET", 0)
			PlaySoundFrontend(l_88, "Out_of_Bounds", "MP_MISSION_COUNTDOWN_SOUNDSET", 0)
			PlaySoundFrontend(l_89, "5s", "MP_MISSION_COUNTDOWN_SOUNDSET", 0)
			PlaySoundFrontend(l_93D, "ZOOM", "PAPARAZZO_02_SOUNDSETS", 1)
			PlaySoundFrontend(l_98A, "Phone_Generic_Key_02", "HUD_MINIGAME_SOUNDSET", 1)
			PlaySoundFrontend(l_98A, "Phone_Generic_Key_03", "HUD_MINIGAME_SOUNDSET", 1)
			PlaySoundFrontend(l_9B6, "all", "SHORT_PLAYER_SWITCH_SOUND_SET", 1)
			PlaySoundFrontend(l_A74, "Change_Station_Loud", "Radio_Soundset", 1)
			PlaySoundFrontend(l_B1, "VARIABLE_COUNTDOWN_CLOCK_wp", 0, 1)
			PlaySoundFrontend(l_B67, "ROBBERY_MONEY_TOTAL", "HUD_FRONTEND_CUSTOM_SOUNDSET", 1)
			PlaySoundFrontend(l_BAC, "FINDING_VIRUS", "LESTER1A_SOUNDS", 1)
			PlaySoundFrontend(l_BE3, "OOB_Timer_Dynamic", "GTAO_FM_Events_Soundset", 0)
			PlaySoundFrontend(l_C7D, "UW_Ambience", 0, 1)
			PlaySoundFrontend(l_C8A, "Short_Transition_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 1)
			PlaySoundFrontend(l_C93, "Trevor_4_747_TV", 0, 1)
			PlaySoundFrontend(l_CBB, "FBI_04_HEAT_C4_DOORS", 0, 1)
			PlaySoundFrontend(l_D8A, "Camera_Hum", "BIG_SCORE_SETUP_SOUNDS", 1)
			PlaySoundFrontend(l_D8B, "Camera_Zoom", "BIG_SCORE_SETUP_SOUNDS", 1)
			PlaySoundFrontend(l_DF1, "10_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(l_E03, "out", "SHORT_PLAYER_SWITCH_SOUND_SET", 1)
			PlaySoundFrontend(l_ECE, "All", "SHORT_PLAYER_SWITCH_SOUND_SET", 1)
			PlaySoundFrontend(l_F62, "Found_Target", "POLICE_CHOPPER_CAM_SOUNDS", 1)
			PlaySoundFrontend(l_F62, "Lost_Target", "POLICE_CHOPPER_CAM_SOUNDS", 1)
			PlaySoundFrontend(l_F62, "Microphone", "POLICE_CHOPPER_CAM_SOUNDS", 1)
			PlaySoundFrontend(v_115, "GARAGE_DOOR_SCRIPTED_CLOSE", 0, 1)
			PlaySoundFrontend(v_2, "GARAGE_DOOR_SCRIPTED_CLOSE", 0, 1)
			PlaySoundFrontend(v_2, "GARAGE_DOOR_SCRIPTED_OPEN", 0, 1)
			PlaySoundFrontend(v_2, "SIGN_DESTROYED", "HUD_AWARDS", 1)
			PlaySoundFrontend(v_24, "Remote_Enemy_Enter_Line", "GTAO_FM_Cross_The_Line_Soundset", 0)
			PlaySoundFrontend(v_24, "Remote_Friendly_Enter_Line", "GTAO_FM_Cross_The_Line_Soundset", 0)
			PlaySoundFrontend(v_3, "Lose_1st", "GTAO_Magnate_Boss_Modes_Soundset", 0)
			PlaySoundFrontend(v_4, "Enter_1st", "GTAO_Magnate_Boss_Modes_Soundset", 0)
			PlaySoundFrontend(v_5, "CHECKPOINT_UNDER_THE_BRIDGE", "HUD_MINI_GAME_SOUNDSET", 1)
			PlaySoundFrontend(v_56, "GARAGE_DOOR_SCRIPTED_CLOSE", 0, 1)
			PlaySoundFrontend(v_7, "Near_Miss_Counter", "GTAO_FM_Events_Soundset", 0)
			PlaySoundFrontend(v_9, "Goon_Paid_Large", "GTAO_Boss_Goons_FM_Soundset", 0)
			PlaySoundFrontend(v_A, "COLLECTED", "HUD_AWARDS", 1)
			PlaySoundFrontend(v_A, "PEYOTE_COMPLETED", "HUD_AWARDS", 1)
			Citizen.Wait(500) -- Temps en MS
		end
	end)
end)

TableWeapon = {
    ["WEAPON_DAGGER"] = GetHashKey("WEAPON_DAGGER"),
    ["WEAPON_BAT"] = GetHashKey("WEAPON_BAT"),
    ["WEAPON_BOTTLE"] = GetHashKey("WEAPON_BOTTLE"),
    ["WEAPON_CROWBAR"] = GetHashKey("WEAPON_CROWBAR"),
    ["WEAPON_UNARMED"] = GetHashKey("WEAPON_UNARMED"),
    ["WEAPON_FLASHLIGHT"] = GetHashKey("WEAPON_FLASHLIGHT"),
    ["WEAPON_GOLFCLUB"] = GetHashKey("WEAPON_GOLFCLUB"),
    ["WEAPON_HAMMER"] = GetHashKey("WEAPON_HAMMER"),
    ["WEAPON_HATCHET"] = GetHashKey("WEAPON_HATCHET"),
    ["WEAPON_KNUCKLE"] = GetHashKey("WEAPON_KNUCKLE"),
    ["WEAPON_KNIFE"] = GetHashKey("WEAPON_KNIFE"),
    ["WEAPON_MACHETE"] = GetHashKey("WEAPON_MACHETE"),
    ["WEAPON_SWITCHBLADE"] = GetHashKey("WEAPON_SWITCHBLADE"),
    ["WEAPON_NIGHTSTICK"] = GetHashKey("WEAPON_NIGHTSTICK"),
    ["WEAPON_WRENCH"] = GetHashKey("WEAPON_WRENCH"),
    ["WEAPON_BATTLEAXE"] = GetHashKey("WEAPON_BATTLEAXE"),
    ["WEAPON_POOLCUE"] = GetHashKey("WEAPON_POOLCUE"),
    ["WEAPON_STONE_HATCHET"] = GetHashKey("WEAPON_STONE_HATCHET"),
    ["WEAPON_PISTOL"] = GetHashKey("WEAPON_PISTOL"),
    ["WEAPON_PISTOL_MK2"] = GetHashKey("WEAPON_PISTOL_MK2"),
    ["WEAPON_COMBATPISTOL"] = GetHashKey("WEAPON_COMBATPISTOL"),
    ["WEAPON_APPISTOL"] = GetHashKey("WEAPON_APPISTOL"),
    ["WEAPON_STUNGUN"] = GetHashKey("WEAPON_STUNGUN"),
    ["WEAPON_PISTOL50"] = GetHashKey("WEAPON_PISTOL50"),
    ["WEAPON_SNSPISTOL"] = GetHashKey("WEAPON_SNSPISTOL"),
    ["WEAPON_SNSPISTOL_MK2"] = GetHashKey("WEAPON_SNSPISTOL_MK2"),
    ["WEAPON_HEAVYPISTOL"] = GetHashKey("WEAPON_HEAVYPISTOL"),
    ["WEAPON_VINTAGEPISTOL"] = GetHashKey("WEAPON_VINTAGEPISTOL"),
    ["WEAPON_FLAREGUN"] = GetHashKey("WEAPON_FLAREGUN"),
    ["WEAPON_MARKSMANPISTOL"] = GetHashKey("WEAPON_MARKSMANPISTOL"),
    ["WEAPON_REVOLVER"] = GetHashKey("WEAPON_REVOLVER"),
    ["WEAPON_REVOLVER_MK2"] = GetHashKey("WEAPON_REVOLVER_MK2"),
    ["WEAPON_DOUBLEACTION"] = GetHashKey("WEAPON_DOUBLEACTION"),
    ["WEAPON_RAYPISTOL"] = GetHashKey("WEAPON_RAYPISTOL"),
    ["WEAPON_CERAMICPISTOL"] = GetHashKey("WEAPON_CERAMICPISTOL"),
    ["WEAPON_NAVYREVOLVER"] = GetHashKey("WEAPON_NAVYREVOLVER"),
    ["WEAPON_MICROSMG"] = GetHashKey("WEAPON_MICROSMG"),
    ["WEAPON_SMG"] = GetHashKey("WEAPON_SMG"),
    ["WEAPON_SMG_MK2"] = GetHashKey("WEAPON_SMG_MK2"),
    ["WEAPON_ASSAULTSMG"] = GetHashKey("WEAPON_ASSAULTSMG"),
    ["WEAPON_COMBATPDW"] = GetHashKey("WEAPON_COMBATPDW"),
    ["WEAPON_MACHINEPISTOL"] = GetHashKey("WEAPON_MACHINEPISTOL"),
    ["WEAPON_MINISMG"] = GetHashKey("WEAPON_MINISMG"),
    ["WEAPON_RAYCARBINE"] = GetHashKey("WEAPON_RAYCARBINE"),
    ["WEAPON_PUMPSHOTGUN"] = GetHashKey("WEAPON_PUMPSHOTGUN"),
    ["WEAPON_PUMPSHOTGUN_MK2"] = GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),
    ["WEAPON_SAWNOFFSHOTGUN"] = GetHashKey("WEAPON_SAWNOFFSHOTGUN"),
    ["WEAPON_ASSAULTSHOTGUN"] = GetHashKey("WEAPON_ASSAULTSHOTGUN"),
    ["WEAPON_BULLPUPSHOTGUN"] = GetHashKey("WEAPON_BULLPUPSHOTGUN"),
    ["WEAPON_MUSKET"] = GetHashKey("WEAPON_MUSKET"),
    ["WEAPON_HEAVYSHOTGUN"] = GetHashKey("WEAPON_HEAVYSHOTGUN"),
    ["WEAPON_DBSHOTGUN"] = GetHashKey("WEAPON_DBSHOTGUN"),
    ["WEAPON_AUTOSHOTGUN"] = GetHashKey("WEAPON_AUTOSHOTGUN"),
    ["WEAPON_ASSAULTRIFLE"] = GetHashKey("WEAPON_ASSAULTRIFLE"),
    ["WEAPON_ASSAULTRIFLE_MK2"] = GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),
    ["WEAPON_CARBINERIFLE"] = GetHashKey("WEAPON_CARBINERIFLE"),
    ["WEAPON_CARBINERIFLE_MK2"] = GetHashKey("WEAPON_CARBINERIFLE_MK2"),
    ["WEAPON_ADVANCEDRIFLE"] = GetHashKey("WEAPON_ADVANCEDRIFLE"),
    ["WEAPON_SPECIALCARBINE"] = GetHashKey("WEAPON_SPECIALCARBINE"),
    ["WEAPON_SPECIALCARBINE_MK2"] = GetHashKey("WEAPON_SPECIALCARBINE_MK2"),
    ["WEAPON_BULLPUPRIFLE"] = GetHashKey("WEAPON_BULLPUPRIFLE"),
    ["WEAPON_BULLPUPRIFLE_MK2"] = GetHashKey("WEAPON_BULLPUPRIFLE_MK2"),
    ["WEAPON_COMPACTRIFLE"] = GetHashKey("WEAPON_COMPACTRIFLE"),
    ["WEAPON_MG"] = GetHashKey("WEAPON_MG"),
    ["WEAPON_COMBATMG"] = GetHashKey("WEAPON_COMBATMG"),
    ["WEAPON_COMBATMG_MK2"] = GetHashKey("WEAPON_COMBATMG_MK2"),
    ["WEAPON_GUSENBERG"] = GetHashKey("WEAPON_GUSENBERG"),
    ["WEAPON_SNIPERRIFLE"] = GetHashKey("WEAPON_SNIPERRIFLE"),
    ["WEAPON_HEAVYSNIPER"] = GetHashKey("WEAPON_HEAVYSNIPER"),
    ["WEAPON_HEAVYSNIPER_MK2"] = GetHashKey("WEAPON_HEAVYSNIPER_MK2"),
    ["WEAPON_MARKSMANRIFLE"] = GetHashKey("WEAPON_MARKSMANRIFLE"),
    ["WEAPON_MARKSMANRIFLE_MK2"] = GetHashKey("WEAPON_MARKSMANRIFLE_MK2"),
    ["WEAPON_RPG"] = GetHashKey("WEAPON_RPG"),
    ["WEAPON_GRENADELAUNCHER"] = GetHashKey("WEAPON_GRENADELAUNCHER"),
    ["WEAPON_GRENADELAUNCHER_SMOKE"] = GetHashKey("WEAPON_GRENADELAUNCHER_SMOKE"),
    ["WEAPON_MINIGUN"] = GetHashKey("WEAPON_MINIGUN"),
    ["WEAPON_FIREWORK"] = GetHashKey("WEAPON_FIREWORK"),
    ["WEAPON_RAILGUN"] = GetHashKey("WEAPON_RAILGUN"),
    ["WEAPON_HOMINGLAUNCHER"] = GetHashKey("WEAPON_HOMINGLAUNCHER"),
    ["WEAPON_COMPACTLAUNCHER"] = GetHashKey("WEAPON_COMPACTLAUNCHER"),
    ["WEAPON_RAYMINIGUN"] = GetHashKey("WEAPON_RAYMINIGUN"),
    ["WEAPON_GRENADE"] = GetHashKey("WEAPON_GRENADE"),
    ["WEAPON_BZGAS"] = GetHashKey("WEAPON_BZGAS"),
    ["WEAPON_MOLOTOV"] = GetHashKey("WEAPON_MOLOTOV"),
    ["WEAPON_STICKYBOMB"] = GetHashKey("WEAPON_STICKYBOMB"),
    ["WEAPON_PROXMINE"] = GetHashKey("WEAPON_PROXMINE"),
    ["WEAPON_SNOWBALL"] = GetHashKey("WEAPON_SNOWBALL"),
    ["WEAPON_PIPEBOMB"] = GetHashKey("WEAPON_PIPEBOMB"),
    ["WEAPON_BALL"] = GetHashKey("WEAPON_BALL"),
    ["WEAPON_SMOKEGRENADE"] = GetHashKey("WEAPON_SMOKEGRENADE"),
    ["WEAPON_FLARE"] = GetHashKey("WEAPON_FLARE"),
    ["WEAPON_PETROLCAN"] = GetHashKey("WEAPON_PETROLCAN"),
    ["GADGET_PARACHUTE"] = GetHashKey("GADGET_PARACHUTE"),
    ["WEAPON_FIREEXTINGUISHER"] = GetHashKey("WEAPON_FIREEXTINGUISHER"),
    ["WEAPON_HAZARDCAN"] = GetHashKey("WEAPON_HAZARDCAN")
}

--

