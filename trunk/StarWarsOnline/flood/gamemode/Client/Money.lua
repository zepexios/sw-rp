local Player = FindMetaTable("Player")

function Player:GetMoney()
	return self:GetNWInt("Cash")
end