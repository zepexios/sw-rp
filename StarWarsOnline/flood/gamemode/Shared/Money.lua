local Meta = FindMetaTable("Player")

function Meta:GetCash()
	return self:GetNWInt("Cash")
end