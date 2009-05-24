// Groups

local Parse = SS.Parser:New("lua/ServerSecureServer/Config/Groups")

// Parse exists

local Exists = Parse:Exists()

// Check the parse exists

if (Exists) then
	local Results = Parse:Parse()
	
	// Loop
	
	for K, V in pairs(Results) do
		local Group = SS.Groups:New(K)
		
		// Loop
		
		for B, J in pairs(V) do
			if (B == "Color") then
				local Col = SS.Lib.StringColor(J)
				
				// Set group color
				
				Group:SetGroupColor(Col.r, Col.g, Col.b, Col.a)
			elseif (B == "Model") then
				Group:SetGroupModel(J)
			elseif (B == "Flags") then
				local Explode = SS.Lib.StringExplode(J, ", ")
				
				// Set group flags
				
				Group:SetGroupFlags(unpack(Explode))
			elseif (B == "Weapons") then
				local Explode = SS.Lib.StringExplode(J, ", ")
				
				// Set group weapons
				
				Group:SetGroupWeapons(unpack(Explode))
			elseif (B == "Default") then
				Group:SetGroupDefault()
			elseif (B == "Rank") then
				Group:SetGroupRank(J)
			elseif (B == "User Group") then
				Group:SetGroupUserGroup(J)
			elseif (B == "Symbol") then
				Group:SetGroupSymbol(J)
			end
		end
		
		// Create
		
		Group:Create()
	end
end