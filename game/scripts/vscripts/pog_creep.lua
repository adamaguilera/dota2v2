-- GET CREEP FUNCTIONS
function barebones:getCreep(prefix, type, isRadiant, upgradesOnMelee)
	local creep = prefix
	-- local ranged = "npc_dota_creep_"
	local rangedbarracks = ""
	local meleebarracks = ""
	if isRadiant then
		creep = creep.."goodguys_"..type
		rangedbarracks = "bad_rax_range_mid"
		meleebarracks = "bad_rax_melee_mid"
	else
		creep = creep.."badguys_"..type
		rangedbarracks = "good_rax_range_mid"
		meleebarracks = "good_rax_melee_mid"
	end
	if Entities:FindByName(nil, rangedbarracks) == nil and Entities:FindByName(nil, meleebarracks) == nil then
		return creep.."_upgraded_mega"
	end
	if upgradesOnMelee and Entities:FindByName(nil, meleebarracks) == nil then
		return creep.."_upgraded"
	elseif not upgradesOnMelee and Entities:FindByName(nil, rangedbarracks) == nil then
		return creep.."_upgraded"
	else
		return creep
	end
end

function barebones:Get_POG_NEUTRAL_EXPERIENCE (playerID)
  local experience = POG_NEUTRAL_EXPERIENCE_BASE
  local game_time	= math.floor(GameRules:GetDOTATime(false, false) / 60)
  experience = experience + (game_time * POG_NEUTRAL_EXPERIENCE_SCALING)
  if barebones:PlayerOnDeficitTeam(playerID) then
    experience = experience + POG_DEFICIT_NEUTRAL_EXPERIENCE_ADDITIONAL
  end
  if barebones:Is4v4() then
    experience = experience * POG_4v4_NEUTRAL_EXPERIENCE_SCALING
  end
  return experience
end

function barebones:Get_POG_BOUNTY (bounty, killed_entity)
  local reason = 0
  local id = nil
  if killed_entity:IsPlayer() then
    reason = DOTA_ModifyGold_HeroKill
	id = killed_entity:GetPlayerID():GetOwnerEntity():GetPlayerID()
  elseif killed_entity:GetName() == "npc_dota_creep_lane" then
    reason = DOTA_ModifyGold_CreepKill
  elseif killed_entity:GetName() == "npc_dota_creep_neutral" then
    reason = DOTA_ModifyGold_NeutralKill
  end
  return barebones:Get_POG_GOLD_WITH_REASON(bounty, reason, id)
end

function barebones:Get_POG_GOLD_WITH_REASON (gold, reason, playerID)
  -- Reasons:
	-- DOTA_ModifyGold_Unspecified = 0
	-- DOTA_ModifyGold_Death = 1
	-- DOTA_ModifyGold_Buyback = 2
	-- DOTA_ModifyGold_PurchaseConsumable = 3
	-- DOTA_ModifyGold_PurchaseItem = 4
	-- DOTA_ModifyGold_AbandonedRedistribute = 5
	-- DOTA_ModifyGold_SellItem = 6
	-- DOTA_ModifyGold_AbilityCost = 7
	-- DOTA_ModifyGold_CheatCommand = 8
	-- DOTA_ModifyGold_SelectionPenalty = 9
	-- DOTA_ModifyGold_GameTick = 10
	-- DOTA_ModifyGold_Building = 11
	-- DOTA_ModifyGold_HeroKill = 12
	-- DOTA_ModifyGold_CreepKill = 13
	-- DOTA_ModifyGold_NeutralKill = 14
	-- DOTA_ModifyGold_RoshanKill = 15
	-- DOTA_ModifyGold_CourierKill = 16
	-- DOTA_ModifyGold_BountyRune = 17
	-- DOTA_ModifyGold_SharedGold = 18
	-- DOTA_ModifyGold_AbilityGold = 19
	-- DOTA_ModifyGold_WardKill = 20

  if reason == DOTA_ModifyGold_SelectionPenalty then
		gold = POG_SELECTION_PENALTY_PER_TICK
	end

	if reason == DOTA_ModifyGold_HeroKill then
		gold = math.floor(gold * barebones:Get_POG_HERO_GOLD_MULTIPLIER(playerID))
		-- if POG_COMEBACK_ENABLED then
		-- 	DebugPrint("Comeback Gold Enabled, before: "..gold)
		-- 	gold = math.floor(gold * barebones:Get_POG_COMEBACK_KILL_AMOUNT(playerID))
		-- 	DebugPrint("Comeback Gold Enabled, after: "..gold)
		-- end
	end
	
	if reason == DOTA_ModifyGold_NeutralKill or reason == DOTA_ModifyGold_CourierKill or reason == DOTA_ModifyGold_Building then
		gold = math.floor(gold * barebones:Get_POG_NEUTRAL_GOLD_MULTIPLIER(playerID))
	end

	if reason == DOTA_ModifyGold_CreepKill then
		gold = math.floor(gold * barebones:Get_POG_CREEP_GOLD_MULTIPLIER(playerID))
	end
  return gold
end

-- END GET CREEP FUNCTIONS

-- CREEP SPAWN AMOUNT FUNCTIONS
function barebones:Get_POG_RANGED_SPAWN_AMOUNT()
  local spawn_amount = POG_RANGED_SPAWN_AMOUNT
  if barebones:Is4v4() then
    spawn_amount = spawn_amount + POG_4v4_RANGED_ADDITIONAL_SPAWN
  end
  return spawn_amount
end

function barebones:Get_POG_MELEE_SPAWN_AMOUNT()
  local spawn_amount = POG_MELEE_SPAWN_AMOUNT
  if barebones:Is4v4() then
    spawn_amount = spawn_amount + POG_4v4_RANGED_ADDITIONAL_SPAWN
  end
  return spawn_amount
end

function barebones:GET_POG_SIEGE_SPAWN_AMOUNT()
  local spawn_amount = POG_SIEGE_SPAWN_AMOUNT
  if barebones:Is4v4() then
    spawn_amount = spawn_amount + POG_4v4_SIEGE_ADDITIONAL_SPAWN
  end
  return spawn_amount
end
-- END CREEP SPAWN AMOUNT

function barebones:CanSpawnSiege()
  local game_time	= math.floor(GameRules:GetDOTATime(false, false) / 60)
  return game_time >= POG_SIEGE_SPAWN_TIME
end

function barebones:spawnWave(type, amount, team, spawner, destination, isRadiant)
	Timers:CreateTimer(function()
		local point = Entities:FindByName(nil, spawner):GetAbsOrigin()
		for i = 1, amount do
      local creep_name
      if type == "siege" then
        creep_name = barebones:getCreep("npc_dota_", "siege", isRadiant, false)
        if not barebones:CanSpawnSiege() then
          return 60.0
        end
      elseif type == "ranged" then
        creep_name = barebones:getCreep("npc_dota_creep_", "ranged", isRadiant, false)
      else
        creep_name = barebones:getCreep("npc_dota_creep_", "melee", isRadiant, true)
      end
			local unit = CreateUnitByName(creep_name, point+RandomVector(RandomInt(100,200)), true, nil, nil, team)
			Timers:CreateTimer(function()
				local waypoint = Entities:FindByName(nil, destination):GetAbsOrigin() or Vector(0, 0, 0)
				local order =
				{
					UnitIndex = unit:GetEntityIndex(),
					OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
					Position = waypoint,
					Queue = true
				}
				ExecuteOrderFromTable(order)
			end)
		end
    if type == "siege" then
      return 60.0
    end
		return 30.0
	end)
end

function barebones:startTeamWaves(spawner, destination, team, isRadiant)
  -- start melee spawn
  barebones:spawnWave("melee", barebones:Get_POG_MELEE_SPAWN_AMOUNT(), team, spawner, destination, isRadiant)
  -- start ranged spawn
  barebones:spawnWave("ranged", barebones:Get_POG_RANGED_SPAWN_AMOUNT(), team, spawner, destination, isRadiant)
  -- start siege spawn
  barebones:spawnWave("siege", barebones:GET_POG_SIEGE_SPAWN_AMOUNT(), team, spawner, destination, isRadiant)
end





-- POG ROSHAN
-- ROSHAN_DEATHS = 0
-- ROSHAN_LOCATION = Vector(0, 0, 0)
-- function barebones:replaceRoshan()
-- 	if barebones:Is3v3() or barebones:Is4v4() then
-- 		-- reset deaths
-- 		ROSHAN_DEATHS = 0
-- 		-- find roshan model
-- 		local rosh = Entities:FindByName(nil, "445_npc_1")
-- 		rosh:AddItem(CreateItem("item_aegis", nil, nil))
-- 		ROSHAN_LOCATION = rosh:GetAbsOrigin()
-- 		-- create new pog rosh
-- 		-- barebones:spawnRoshan()
-- 	end
-- end

-- function barebones:spawnRoshan()
-- 	if barebones:Is3v3() or barebones:Is4v4() then
-- 		local pog_rosh = CreateUnitByName("npc_dota_roshan", ROSHAN_LOCATION, false, nil, nil, DOTA_TEAM_NEUTRALS)
-- 		-- give him aegis
-- 		Timers:CreateTimer(1, function()
-- 			pog_rosh:AddItem(CreateItem("item_aegis", nil, nil))
-- 			if ROSHAN_DEATHS >= 1 then
-- 				pog_rosh:AddItem(CreateItem("item_cheese", nil, nil))
-- 			end
-- 			if ROSHAN_DEATHS == 1 then
-- 				pog_rosh:AddItem(CreateItem("item_aghanims_shard", nil, nil))
-- 			end
-- 			if ROSHAN_DEATHS == 2 then
-- 				pog_rosh:AddItem(CreateItem("item_refresher_shard", nil, nil))
-- 				pog_rosh:AddItem(CreateItem("item_ultimate_scepter_2", nil, nil))
-- 			end
-- 		end)
-- 	end
-- end

-- function barebones:onRoshanDeath(deathLocation)
-- 	if barebones:Is3v3() or barebones:Is4v4() then
-- 		-- drop items
-- 		ROSHAN_DEATHS = ROSHAN_DEATHS + 1
-- 		-- CreateItemOnPositionSync(deathLocation, CreateItem("item_aegis", nil, nil))
-- 		-- if ROSHAN_DEATHS >= 2 then
-- 		-- 	CreateItemOnPositionSync(deathLocation, CreateItem("item_cheese", nil, nil))
-- 		-- end
-- 		-- if ROSHAN_DEATHS == 2 then
-- 		-- 	CreateItemOnPositionSync(deathLocation, CreateItem("item_aghanims_shard", nil, nil))
-- 		-- end
-- 		-- if ROSHAN_DEATHS == 3 then
-- 		-- 	CreateItemOnPositionSync(deathLocation, CreateItem("item_refresher_shard", nil, nil))
-- 		-- 	CreateItemOnPositionSync(deathLocation, CreateItem("item_ultimate_scepter_2", nil, nil))
-- 		-- end
-- 		-- create respawn of rosh
-- 		Timers:CreateTimer(RandomInt(ROSHAN_MINIMUM_RESPAWN, ROSHAN_MAXIMUM_RESPAWN), function()
-- 			barebones:spawnRoshan()
-- 		end)
--    end

-- end