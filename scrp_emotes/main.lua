player = nil
status = false
RegisterCommand("e", function(source, args)
    player = PlayerPedId(-1);
    local emoteToPlay = args[1]
    if GetVehiclePedIsIn(player, false) ~= 0 then return end;
    startEmote(emoteToPlay)
end)


function startEmote(anim)
    if emote[anim] and player and status == false then 
        local ped = PlayerPedId()
        TaskStartScenarioInPlace(ped, GetHashKey(emote[anim].anim), playEnterAnim, true)

        status = true
    else 
        return; 
    end;
end

Citizen.CreateThread(function()
    while true do
        if status then
            if 
                IsControlPressed(1, 0xD9D0E1C0)
            then
                ClearPedTasks(player);
                status = false
            end
        end
        Citizen.Wait(0)
    end
end)

