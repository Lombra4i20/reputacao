local time = 7000

RegisterNetEvent('3dme:triggerDisplay')
AddEventHandler('3dme:triggerDisplay', function(text, source)
    Display(GetPlayerFromServerId(source), text)
end)

function Display(mePlayer, text)
    local displaying = true
    if chatMessage then
        local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
        local coords = GetEntityCoords(PlayerPedId(), false)
        local dist = Vdist2(coordsMe, coords)
        if dist < 2500 then
            TriggerEvent('chat:addMessage', {
                color = { color.r, color.g, color.b },
                multiline = true,
                args = { text}
            })
        end
    end

    Citizen.CreateThread(function()
    	Wait(time)
        displaying = false
    end)
    Citizen.CreateThread(function()
        while displaying do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)
            if dist < 2500 then
                DrawText3D(coordsMe['x'], coordsMe['y'], coordsMe['z'], text)
            end
        end
    end)
end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())  
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    if onScreen then
    	SetTextScale(0.30, 0.30)
  		SetTextFontForCurrentCommand(6)
    	SetTextColor(255, 255, 255, 215)
    	SetTextCentre(1)
    	DisplayText(str,_x,_y)
    	local factor = (string.len(text)) / 225
    	DrawSprite("feeds", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 35, 35, 35, 190, 0)
    	DrawSprite("feeds", "toast_bg", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 100, 1, 1, 190, 0)
    end
end



RegisterNetEvent('chat:addMessage')

-- Remova a chamada do evento 'chat:addMessage' em 'mostrarRespeitoClient'

-- Adicione o manipulador de eventos 'chat:addMessage'
AddEventHandler('chat:addMessage', function(message)
    if message.args[1] == '[Reputação]' then
        local text = message.args[2]
        local respeito = string.match(text, "-?%d+")
        if respeito then
            local ped = GetPlayerPed(-1)
            local pos = GetEntityCoords(ped)
            TriggerServerEvent('3dme:shareDisplay', "Reputação: ".. tonumber(respeito))
			TriggerServerEvent('idPlayer', PlayerID)
        end
    end
end)


local DeathReason, Killer, DeathCauseHash, Weapon

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(6000)
		if IsEntityDead(PlayerPedId()) then
			Citizen.Wait(500)
			local PedKiller = GetPedSourceOfDeath(PlayerPedId())
			DeathCauseHash = GetPedCauseOfDeath(PlayerPedId())
			Weapon = WeaponNames[tostring(DeathCauseHash)]

			if IsEntityAPed(PedKiller) and IsPedAPlayer(PedKiller) then
				Killer = NetworkGetPlayerIndexFromPed(PedKiller)
			elseif IsEntityAVehicle(PedKiller) and IsEntityAPed(GetPedInVehicleSeat(PedKiller, -1)) and IsPedAPlayer(GetPedInVehicleSeat(PedKiller, -1)) then
				Killer = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(PedKiller, -1))
			end

			if (Killer == PlayerId()) then
				DeathReason = 'committed suicide'
			elseif (Killer == nil) then
				DeathReason = 'died'
			else
				DeathReason = 'killed'
			end

			if DeathReason == 'killed' then -- adiciona condição para só executar jogadorMorto se DeathReason for igual a "killed"
				TriggerServerEvent('jogadorMorto', GetPlayerServerId(Killer), Weapon)
			end

			Killer = nil
			DeathReason = nil
			DeathCauseHash = nil
			Weapon = nil 
		end

		while IsEntityDead(PlayerPedId()) do
			Citizen.Wait(0)
		end
	end
end)

