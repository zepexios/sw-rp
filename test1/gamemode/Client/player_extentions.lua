local Player = FindMetaTable("Player")

function Player:GetMaxForce()
	return self:GetNWInt( "PlayerMaxForce" ) or 100
end

function Player:GetForce()
	return self:GetNWInt( "PlayerForce" ) or  100 
end

function Player:GetXP()
	return self:GetNWInt( "XP" ) or  0
end

function Player:GetNeededXP()
	return self:GetNWInt( "XPNextLevel" ) or  0
end

function Player:GetLevel()
	return self:GetNWInt( "level" ) or  0
end
