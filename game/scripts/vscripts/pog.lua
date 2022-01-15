TEAM_COUNT = {}
CURRENT_MAX_TEAM_COUNT = 0
-- Sets team count so we can easily get how many players are on team X
function barebones:SetTeamCounts() 
  CURRENT_MAX_TEAM_COUNT = 0
  TEAM_COUNT = {}
  for id = 0, POG_MAX_PLAYER_COUNT do
    if PlayerResource:IsValidPlayerID(id) then
      -- DebugPrint("id: "..id.." is valid")
      local team_id = PlayerResource:GetPlayer(id):GetTeamNumber()
      -- DebugPrint("matching team is "..team_id)
      if TEAM_COUNT[team_id] == nil then
        TEAM_COUNT[team_id] = 0
      end
      TEAM_COUNT[team_id] = TEAM_COUNT[team_id] + 1
      -- DebugPrint("their team count is now "..TEAM_COUNT[team_id])
      if TEAM_COUNT[team_id] > CURRENT_MAX_TEAM_COUNT then
        CURRENT_MAX_TEAM_COUNT = TEAM_COUNT[team_id]
        -- DebugPrint("Max team count is now "..CURRENT_MAX_TEAM_COUNT)
      end
    end
  end
  for id = 0, POG_MAX_PLAYER_COUNT do
    if PlayerResource:IsValidPlayerID(id) then
      -- DebugPrint("id: "..id.." is valid")
      local hero = PlayerResource:GetPlayer(id):GetAssignedHero()
      if hero ~= nil then
        -- DebugPrint("hero is not nil")
        if barebones:PlayerOnDeficitTeam(id) then
          -- DebugPrint("On Deficit Team")
          hero:AddNewModifier(hero, nil, "modifier_player_deficit", {})
          -- DebugPrint("deficit by: "..barebones:DeficitStackCount(id))
          hero:SetModifierStackCount("modifier_player_deficit", hero, barebones:DeficitStackCount(id))
        elseif hero:HasModifier("modifier_player_deficit") then
          hero:RemoveModifierByName("modifier_player_deficit")
        end
      end
    end
  end
end

TEAM_NETWORTH = {}
TEAM_MAX_NETWORTH = 0
function barebones:SetTeamNetworth()
  TEAM_NETWORTH = {}
  TEAM_MAX_NETWORTH = 0
  for id = 0, POG_MAX_PLAYER_COUNT do
    if PlayerResource:IsValidPlayerID(id) then
      local team_id = PlayerResource:GetPlayer(id):GetTeamNumber()
      if TEAM_NETWORTH[team_id] == nil then
        TEAM_NETWORTH[team_id] = PlayerResource:GetNetWorth(id)
      else
        TEAM_NETWORTH[team_id] = TEAM_NETWORTH[team_id] + PlayerResource:GetNetWorth(id)
      end 
      if TEAM_NETWORTH[team_id] > TEAM_MAX_NETWORTH then
        TEAM_MAX_NETWORTH = TEAM_NETWORTH[team_id]
      end
    end
  end
end

function barebones:ShouldComebackNetworth(team_id)
  if POG_DYNAMIC_CALCULATIONS then
    barebones:SetTeamNetworth()
  end
  if barebones:TeamHasDeficit(team_id) then
    return false
  end
  DebugPrint('Networth diff: '..barebones:PogNetworthDifference(team_id))
  DebugPrint('Diff not percent: '..(TEAM_MAX_NETWORTH - TEAM_NETWORTH[team_id]))
  return (barebones:PogNetworthDifference(team_id) >= POG_COMEBACK_GOLD_MIN_MULTIPLIER) and (TEAM_MAX_NETWORTH - TEAM_NETWORTH[team_id] >= POG_COMEBACK_GOLD_MIN_BASE_DIFF)
end

function barebones:PogNetworthDifference(team_id)
  return POG_COMEBACK_GOLD_DIFF_MULTIPLIER * (TEAM_MAX_NETWORTH / TEAM_NETWORTH[team_id] - 1)
end

-- returns true if player is on a team with less than team with max number of players
function barebones:PlayerOnDeficitTeam(player_id) 
  if POG_DYNAMIC_CALCULATIONS then
    barebones:SetTeamCounts()
  end
  return player_id ~= nil and PlayerResource:IsValidPlayer(player_id) and barebones:TeamHasDeficit(PlayerResource:GetPlayer(player_id):GetTeamNumber())
end

function barebones:DeficitStackCount(player_id) 
  if player_id ~= nil and PlayerResource:IsValidPlayer(player_id) then
    local team = PlayerResource:GetPlayer(player_id):GetTeamNumber()
    if TEAM_COUNT[team] ~= nil and TEAM_COUNT[team] < CURRENT_MAX_TEAM_COUNT then
      return CURRENT_MAX_TEAM_COUNT - TEAM_COUNT[team]
    end
  end
  return 0
end

-- returns true if team has less players than team with max number of players
function barebones:TeamHasDeficit(team_id)
  return TEAM_COUNT[team_id] ~= nil and TEAM_COUNT[team_id] < CURRENT_MAX_TEAM_COUNT
end

function barebones:onSameTeam(first_id, second_id)
  if not PlayerResource:IsValidPlayerID(first_id) or not PlayerResource:IsValidPlayerID(first_id) then
    return false
  end 
  local first = PlayerResource:GetPlayer(first_id)
  local second = PlayerResource:GetPlayer(second_id)
  return first:GetTeamNumber() == second:GetTeamNumber()
end

function barebones:OnTeam (player_id, team_id)
  if player_id == nil or team_id == nil or not PlayerResource:IsValidPlayerID(player_id) then
    return false
  end
  return PlayerResource:GetPlayer(player_id):GetTeamNumber() == team_id
end


function barebones:Is4v4()
  return GetMapName() == 'pog4v4'
end
function barebones:Is2v2()
  return GetMapName() == 'pog2v2'
end


-- POG Variable Getter Functions
function barebones:Get_POG_HERO_GOLD_MULTIPLIER(player_id)
  local gold_multiplier = POG_HERO_GOLD_MULTIPLIER
  if player_id ~= nil and barebones:PlayerOnDeficitTeam(player_id) then
    gold_multiplier = gold_multiplier * POG_DEFICIT_GOLD_MULTIPLIER
  end
  return gold_multiplier
end

function barebones:Get_POG_NEUTRAL_GOLD_MULTIPLIER(player_id)
  local gold_multiplier = POG_NEUTRAL_GOLD_MULTIPLIER
  if player_id ~= nil and barebones:PlayerOnDeficitTeam(player_id) then
    gold_multiplier = gold_multiplier * POG_DEFICIT_GOLD_MULTIPLIER
  end
  return gold_multiplier
end

function barebones:Get_POG_CREEP_GOLD_MULTIPLIER(player_id)
  local gold_multiplier = POG_CREEP_GOLD_MULTIPLIER
  if player_id ~= nil and barebones:PlayerOnDeficitTeam(player_id) then
    DebugPrint("gold before: "..gold_multiplier)
    gold_multiplier = gold_multiplier * POG_DEFICIT_GOLD_MULTIPLIER
    DebugPrint("gold after: "..gold_multiplier)
  end
  return gold_multiplier
end

function barebones:Get_POG_CREEP_EXPERIENCE_MULTIPLIER(player_id)
  local xp_multipler = POG_CREEP_EXPERIENCE_MULTIPLIER
  if player_id ~= nil and barebones:PlayerOnDeficitTeam(player_id) then
    xp_multipler = xp_multipler * POG_DEFICIT_EXPERIENCE_MULTIPLIER
  end
  return xp_multipler
end

-- CREEP SCALING
function barebones:Get_POG_CREEP_DAMAGE_SCALING(team_id)
  local additional_damage = POG_CREEP_DAMAGE_SCALING
  if barebones:Is4v4() then
    additional_damage = additional_damage + POG_4v4_CREEP_DAMAGE_SCALING_ADD
  end

  if barebones:TeamHasDeficit(team_id) then
    additional_damage = additional_damage + POG_DEFICIT_CREEP_DAMAGE_SCALING_ADD
  end
  return additional_damage
end

function barebones:Get_POG_CREEP_HEALTH_SCALING(team_id)
  local additional_health = POG_CREEP_HEALTH_SCALING
  if barebones:Is4v4() then
    additional_health = additional_health + POG_4v4_CREEP_HEALTH_SCALING_ADD
  end

  if barebones:TeamHasDeficit(team_id) then
    additional_health = additional_health + POG_DEFICIT_CREEP_HEALTH_SCALING_ADD
  end
  return additional_health
end



-- END CREEP SCALING

-- POG RUNE MODIFIERS

function barebones:Get_POG_BOUNTY_RUNE_GOLD_AMOUNT(playerID)
  local bounty_amount = POG_BOUNTY_RUNE_BASE
  local game_time	= math.floor(GameRules:GetDOTATime(false, false) / 60)
  bounty_amount = bounty_amount * (1 + game_time * POG_BOUNTY_RUNE_SCALING)
  if barebones:PlayerOnDeficitTeam(playerID) then
    bounty_amount = bounty_amount * POG_DEFICIT_BOUNTY_MULTIPLIER
  end
  return math.floor(bounty_amount)
end

-- END POG RUNE MODIFIERS

function barebones:Get_POG_COMEBACK_KILL_AMOUNT(playerID)
  if PlayerResource:IsValidPlayerID(playerID) then
    local team_id = PlayerResource:GetPlayer(playerID):GetTeamNumber()
    if barebones:ShouldComebackNetworth(team_id) then
      return math.min((1 + barebones:PogNetworthDifference(team_id)), POG_COMEBACK_GOLD_MAX_MULTIPLIER)
    end
  end
  return 1.0
end