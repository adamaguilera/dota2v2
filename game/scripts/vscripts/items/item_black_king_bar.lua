LinkLuaModifier("modifier_item_pog_black_king_bar", "items/item_black_king_bar", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_pog_black_king_bar_buff", "items/item_black_king_bar", LUA_MODIFIER_MOTION_NONE)

item_pog_black_king_bar = item_pog_black_king_bar or class({})

function item_pog_black_king_bar:GetIntrinsicModifierName()
    return "modifier_item_pog_black_king_bar"
end

function item_pog_black_king_bar:OnSpellStart()
    -- Ability properties
    local caster = self:GetCaster()
    local ability = self
    local sound_cast = "DOTA_Item.BlackKingBar.Activate"
    local modifier_bkb = "modifier_item_pog_black_king_bar_buff"

    -- Ability specials
    local duration = ability:GetSpecialValueFor("duration")
    local max_level = ability:GetSpecialValueFor("max_level")

    -- tooltip
    self.status_resistance = ability:GetSpecialValueFor("bonus_status_resistance") 
    self.magic_resistance = ability:GetSpecialValueFor("bonus_magic_resistance") 

    -- Level up the item if relevant
    if ability:GetLevel() < max_level then
        ability:SetLevel(ability:GetLevel() + 1)

        -- Set level on the caster
        caster.bkb_current_level = ability:GetLevel()        
    end

    -- Play cast sound
    EmitSoundOn(sound_cast, caster)

    -- Apply basic dispel
    caster:Purge(false, true, false, false, false)

    -- Give caster the buff
    caster:AddNewModifier(caster, ability, modifier_bkb, {duration = duration})
end


---------------------------------------
-- INTRINSIC BLACK KING BAR MODIFIER --
---------------------------------------

modifier_item_pog_black_king_bar = modifier_item_pog_black_king_bar or class({})

function modifier_item_pog_black_king_bar:IsHidden() return true end
function modifier_item_pog_black_king_bar:IsPurgable() return false end
function modifier_item_pog_black_king_bar:RemoveOnDeath() return false end
function modifier_item_pog_black_king_bar:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_pog_black_king_bar:OnCreated()
    if IsServer() then
        if not self:GetAbility() then self:Destroy() end
    end

    -- Ability properties    
    self.caster = self:GetCaster()
    self.ability = self:GetAbility()

    -- Ability specials
    self.bonus_strength = self.ability:GetSpecialValueFor("bonus_strength")
    self.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")    

    -- Set the item's level according to the caster, if any
    if IsServer() then
        if self.caster.bkb_current_level and self.ability then
            if self.caster.bkb_current_level ~= self.ability:GetLevel() then
               self.ability:SetLevel(self.caster.bkb_current_level)
            end
        end
    end
end

function modifier_item_pog_black_king_bar:DeclareFunctions()
    local decFuncs = {MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE, MODIFIER_PROPERTY_STATS_STRENGTH_BONUS}
    return decFuncs
end
function modifier_item_pog_black_king_bar:GetModifierPreAttack_BonusDamage()
    return self.bonus_damage
end

function modifier_item_pog_black_king_bar:GetModifierBonusStats_Strength()
    return self.bonus_strength
end

----------------------------------
-- BLACK KING BAR BUFF MODIFIER --
----------------------------------

modifier_item_pog_black_king_bar_buff = modifier_item_pog_black_king_bar_buff or class({})

function modifier_item_pog_black_king_bar_buff:IsHidden() return false end
function modifier_item_pog_black_king_bar_buff:IsPurgable() return false end
function modifier_item_pog_black_king_bar_buff:IsDebuff() return false end

function modifier_item_pog_black_king_bar_buff:GetEffectName()
    return "particles/items/pog_black_king_bar_avatar.vpcf" -- /black_king_bar_avatar.vpcf"
end

function modifier_item_pog_black_king_bar_buff:OnCreated()
    if IsServer() then
        if not self:GetAbility() then self:Destroy() end
    end

    -- Ability properties
    self.ability = self:GetAbility()

    -- Ability specials
    self.model_scale = self.ability:GetSpecialValueFor("model_scale") 
    
    self.bonus_status_resistance = self.ability:GetSpecialValueFor("bonus_status_resistance") 
    self.bonus_magic_resistance = self.ability:GetSpecialValueFor("bonus_magic_resistance")
    self.bonus_strength = self.ability:GetSpecialValueFor("bonus_strength") 
end


function modifier_item_pog_black_king_bar_buff:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_item_pog_black_king_bar_buff:CheckState()
    local state = {}
    return state
end

function modifier_item_pog_black_king_bar_buff:DeclareFunctions()
    local decFuncs = {MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE, MODIFIER_PROPERTY_STATS_STRENGTH_BONUS, MODIFIER_PROPERTY_MODEL_SCALE, MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS, MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING}
    return decFuncs
end

function modifier_item_pog_black_king_bar_buff:GetModifierStatusResistanceStacking()
	return self.bonus_status_resistance
end
function modifier_item_pog_black_king_bar_buff:GetModifierMagicalResistanceBonus()
	return self.bonus_magic_resistance
end

function modifier_item_pog_black_king_bar_buff:GetModifierModelScale()
    return self.model_scale
end

function modifier_item_pog_black_king_bar_buff:GetModifierBonusStats_Strength()
    return self.bonus_strength
end

function modifier_item_pog_black_king_bar_buff:GetModifierPreAttack_BonusDamage()
    return self.bonus_damage
end
