local mysql = exports["oxmysql"]

AddEventHandler("playerConnecting", function(playerName, setKickReason)
    local playerId = GetPlayerIdentifier(source, 0) -- pegar steamid
    local respeito = 0

    mysql:execute("SELECT id FROM vorpv2.respeito WHERE id = ?", {playerId}, function(result)
        if result[1] then
            -- jogador já existe na tabela
            print("Jogador já existe na tabela respeito")
        else
            -- jogador não existe na tabela, então insere
            mysql:execute("INSERT INTO vorpv2.respeito (id, respeito) VALUES (?, ?)", {playerId, respeito}, function(rowsChanged)
                if rowsChanged == 0 then
                    print("Erro ao inserir jogador na tabela respeito")
                else
                    print("Jogador inserido com sucesso na tabela respeito")
                end
            end)
        end
    end)
end)


RegisterNetEvent('jogadorMorto')
AddEventHandler('jogadorMorto', function(killerPlayerServerId)
    local steamId = GetPlayerIdentifier(source, 0)
    local killerId = GetPlayerIdentifier(killerPlayerServerId, 0)
    print("Jogador " .. steamId .. " matou outro jogador")

    -- atualiza a coluna "respeito" do assassino com +1
    mysql:execute("UPDATE vorpv2.respeito SET respeito = respeito - 1 WHERE id = ?", {killerId}, function(rowsChanged)
        if rowsChanged == 0 then
            print("Erro ao atualizar o respeito do assassino")
        else
            print("Respeito do assassino atualizado com sucesso")
        end
    end)
end)

RegisterNetEvent('mostrarRespeitoServer')
AddEventHandler('mostrarRespeitoServer', function(source)
    local playerId = GetPlayerIdentifier(source, 0)
    mysql:execute("SELECT respeito FROM vorpv2.respeito WHERE id = ?", {playerId}, function(result)
        if result[1] then
            local respeito = result[1].respeito
            TriggerClientEvent('chat:addMessage', source, {
                color = {255, 255, 255},
                multiline = true,
                args = {'[Reputação]', 'Sua reputação atual é: ' .. respeito}
            })
        end
    end)
end)

RegisterCommand('reputacao', function(source, args, rawCommand)
    TriggerEvent('mostrarRespeitoServer', source)
end, false)

RegisterServerEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text)
	TriggerClientEvent('3dme:triggerDisplay', -1, text, source)
end)
