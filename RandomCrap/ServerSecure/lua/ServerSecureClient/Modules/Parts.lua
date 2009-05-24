// Parts

SS.Parts      = {} // Bar table
SS.Parts.List = {} // Top bar

// Add part

function SS.Parts.Add(ID, Type)
	table.insert(SS.Parts.List, {ID, Type})
end

// Request part

function SS.Parts.Request(Player, Type)
	local Table = {}
	local Count = 0
	
	// Loop through the list of parts
	
	for K, V in pairs(SS.Parts.List) do
		if (V[2] == Type) then
			local Text = "Error"
			
			// Type
			
			local Type = type(V[1])
			
			// Function
			
			if (Type == "function") then
				Text = V[1]()
			else
				Text = Player:GetNetworkedString(V[1])
			end
			
			// Trim
			
			Text = string.Trim(Text)
			
			// Check if the string is empty
			
			if (Text != "") then
				table.insert(Table, Text)
				
				// Increase count
				
				Count = Count + 1
			end
		end
	end
	
	// Return false is there is no parts
	
	if (Count == 0) then
		return false
	end
	
	// Return the parts
	
	return Table
end