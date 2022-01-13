-- POG SETUP FUNCTIONS
function barebones:setup_map()
    if barebones:Is3v3() or barebones:Is4v4() then
        barebones:setup_3v3()
   end
end

function barebones:setup_3v3()
    Entities:FindByName(nil, "npc_dota_watch_tower_top"):RemoveModifierByName("modifier_invulnerable")
    Entities:FindByName(nil, "npc_dota_watch_tower_bottom"):RemoveModifierByName("modifier_invulnerable")
    Timers:CreateTimer(3, function()
        Entities:FindByName(nil, "radiant_shrine_1"):FindAbilityByName("filler_ability"):EndCooldown()
	end)
    Timers:CreateTimer(3, function()
        Entities:FindByName(nil, "dire_shrine_1"):FindAbilityByName("filler_ability"):EndCooldown()
    end)
end

function barebones:Is2v2()
    return GetMapName() == 'pog2v2'
  end
function barebones:Is3v3()
    return GetMapName() == 'pog3v3'
end
function barebones:Is4v4()
    return GetMapName() == 'pog4v4'
end