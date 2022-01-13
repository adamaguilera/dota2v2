
function barebones:PogRuneOnUnitKilled (killer_unit, killed_unit)
  -- check if should trigger rune
  if killed_unit:GetUnitName() == "npc_dota_pog_regen_rune" then
    -- do rune effect
    killer_unit:AddNewModifier(killer_unit, nil, "modifier_pog_regen_rune", {duration=POG_RUNE_REGEN_DURATION})
    killer_unit:EmitSoundParams("Rune.Regen", 1, 0.44, 0)
    -- EmitSoundOnLocationForAllies(killer_unit:GetAbsOrigin(), "Rune.Regen", killer_unit)
  end

  -- check if should spawn rune
  if killed_unit:GetName() == "npc_dota_creep_lane" then
    if RollPercentage(LANE_CREEP_RUNE_DROP_CHANCE) then
      -- spawn rune
      -- killer_unit:AddNewModifier(killer_unit, nil, "modifier_pog_regen_rune", {duration=POG_RUNE_REGEN_DURATION})
      -- EmitSoundOnLocationForAllies(killer_unit:GetAbsOrigin(), "Rune.Regen", killer_unit)
      local rune = CreateUnitByName("npc_dota_pog_regen_rune", killed_unit:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_NEUTRALS)
      rune:AddNewModifier(rune, nil, "modifier_kill", { duration = 15 } )
    end
  elseif killed_unit:GetName() == "npc_dota_creep_neutral" then
    -- neutral creeps
    if RollPercentage(NEUTRAL_RUNE_DROP_CHANCE) then
      -- spawn rune
      local rune = CreateUnitByName("npc_dota_pog_regen_rune", killed_unit:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_NEUTRALS)
      rune:AddNewModifier(rune, nil, "modifier_kill", { duration = 20 } )
      -- local circle = ParticleManager:CreateParticle("particles/units/heroes/hero_void_spirit/void_spirit_astral_step_real_destination_b.vpcf", PATTACH_CUSTOMORIGIN, rune)
      -- "C:\Program Files (x86)\Steam\steamapps\common\dota 2 beta\content\dota\particles\units\heroes\hero_void_spirit\void_spirit_astral_step_real_destination_b.vpcf"
    end
  end
end
