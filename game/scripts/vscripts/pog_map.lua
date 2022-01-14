-- POG SETUP FUNCTIONS
function barebones:setup_map()
    if barebones:Is3v3() or barebones:Is4v4() then
        barebones:setup_jungle()
   end
    Timers:CreateTimer(PRE_GAME_TIME, function ()
        barebones:GrantBehindExperience()
        return POG_BEHIND_EXPERIENCE_DELAY
    end)
end

function barebones:setup_jungle()
    Timers:CreateTimer(POG_OUTPOST_INVULNERABLE_DURATION, function()
        Entities:FindByName(nil, "npc_dota_watch_tower_top"):RemoveModifierByName("modifier_invulnerable")
        Entities:FindByName(nil, "npc_dota_watch_tower_bottom"):RemoveModifierByName("modifier_invulnerable")
    end)
    Timers:CreateTimer(3, function()
        Entities:FindByName(nil, "npc_dota_goodguys_healers"):FindAbilityByName("filler_ability"):EndCooldown()
	end)
    Timers:CreateTimer(3, function()
        Entities:FindByName(nil, "npc_dota_badguys_healers"):FindAbilityByName("filler_ability"):EndCooldown()
    end)
    Timers:CreateTimer(PRE_GAME_TIME + POG_OUTPOST_EXPERIENCE_DELAY, function()
        barebones:GrantWatchpostExperience("npc_dota_watch_tower_bottom")
        barebones:GrantWatchpostExperience("npc_dota_watch_tower_top")
        return POG_OUTPOST_EXPERIENCE_DELAY
    end) 
end

function barebones:GrantWatchpostExperience(watch_tower_name)
    local team_id = Entities:FindByName(nil, watch_tower_name):GetTeam()
    for playerID = 0, DOTA_MAX_TEAM_PLAYERS-1 do
        if PlayerResource:IsValidPlayerID(playerID) and PlayerResource:GetPlayer(playerID):GetTeam() == team_id then
            PlayerResource:GetSelectedHeroEntity(playerID):AddExperience(POG_OUTPOST_EXPERIENCE, DOTA_ModifyXP_Outpost, false, true)
        end
    end
end

function barebones:GrantBehindExperience()
    local maxLevel = 0
    for playerID = 0, DOTA_MAX_TEAM_PLAYERS  do
        if PlayerResource:IsValidPlayerID(playerID) then
            local level = PlayerResource:GetSelectedHeroEntity(playerID):GetLevel()
            if level > maxLevel then
                maxLevel = level
            end
        end
    end
    for playerID = 0, DOTA_MAX_TEAM_PLAYERS  do
        if PlayerResource:IsValidPlayerID(playerID) and PlayerResource:GetSelectedHeroEntity(playerID):GetLevel() < maxLevel then
            local difference = maxLevel - PlayerResource:GetSelectedHeroEntity(playerID):GetLevel()
            local amount = POG_BEHIND_EXPERIENCE_AMOUNT * difference
            PlayerResource:GetSelectedHeroEntity(playerID):AddExperience(amount, DOTA_ModifyXP_Unspecified , false, true)
        end
    end
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