function GM:StorePlayerData( table )
	io.input(CharData.lua)
	
	for Key,Value in pairs(table) do
		io.write(Value)
	end
end

function GM:ReadPlayerData()
	io.input(CharData.lua)

	return io.read("*all")
end


function GM:SetPlayerData( ply )

	PlayerData = {}
	
	PlayerData[ply:UniqueID()] = {Name = ply:Nick(), Money = GM:GetSWMoney(), Class = GM:GetSWClass(), RifleXP = GM:GetRifleXP() }
	GM:StorePlayerData( PlayerData )
	
end



