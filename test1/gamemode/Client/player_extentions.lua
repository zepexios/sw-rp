local Player = FindMetaTable("Player")

function Player:GetMaxForce()
	return self:GetNWInt( "PlayerMaxForce" ) or 100
end

function Player:GetForce()
	return self:GetNWInt( "PlayerForce" ) or  100 
end