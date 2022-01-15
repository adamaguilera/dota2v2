modifier_player_deficit = class({})

-- Modifier property stuff
function modifier_player_deficit:IsDebuff() return false end
function modifier_player_deficit:IsPurgable() return false end
function modifier_player_deficit:IsAura() return false end
function modifier_player_deficit:IsPermanent()
	return true
end
function modifier_player_deficit:GetTexture()
	return "alchemist_goblins_greed"
end

function modifier_player_deficit:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_player_deficit:OnCreated()
end

function modifier_player_deficit:OnRefresh()
	self:OnCreated()
end

function modifier_player_deficit:DeclareFunctions()
	local funcs = {}
	return funcs
end

function modifier_player_deficit:RemoveOnDeath()
	return false
end