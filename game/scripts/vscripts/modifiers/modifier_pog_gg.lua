modifier_pog_gg = class({})

-- Modifier property stuff
function modifier_pog_gg:IsDebuff() return false end
function modifier_pog_gg:IsPurgable() return false end
function modifier_pog_gg:IsAura() return false end
function modifier_pog_gg:IsPermanent()
	return true
end
function modifier_pog_gg:GetTexture()
	return "legion_commander_duel"
end

function modifier_pog_gg:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_pog_gg:OnCreated()
end

function modifier_pog_gg:OnRefresh()
	self:OnCreated()
end

function modifier_pog_gg:DeclareFunctions()
	local funcs = {}
	return funcs
end

function modifier_pog_gg:RemoveOnDeath()
	return false
end