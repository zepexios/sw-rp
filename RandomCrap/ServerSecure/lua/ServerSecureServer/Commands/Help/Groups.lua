// Groups

local Groups = SS.ChatCommands:New("Groups")

// View groups

function Groups.View(Player, Args)
	local Group = table.concat(Args, " ")
	
	// Loop
	
	for K, V in pairs(SS.Groups.List) do
		if (Group == V[1]) then
			local Panel = SS.Panel:New(Player, V[1])
			
			// Text
			
			Panel:Words("Rank: "..V[6])
			
			// Count
			
			if (table.Count(V[8]) > 0) then
				Panel:Words("Flags: "..table.concat(V[8], ", "))
			end
			
			// Model
			
			if (V[4] != "") then
				Panel:Words("Model: "..V[4])
			end
			
			// Send
			
			Panel:Send()
			
			// Return
			
			return
		end
	end
	
	// Message
	
	SS.PlayerMessage(Player, "No such group: '"..Group.."'!", 1)
end

SS.ConsoleCommands.Simple("groupscommand", Groups.View, 1)

// Command

function Groups.Command(Player, Args)
	local Panel = SS.Panel:New(Player, "Groups")
	
	// Sort
	
	local Sort = SS.Groups.List
	
	// Sort
	
	table.sort(Sort, function(A, B) return SS.Groups.GetGroupRank(A[1]) < SS.Groups.GetGroupRank(B[1]) end)
	
	// Loop
	
	for K, V in pairs(Sort) do
		local Col = V[3]
		
		// Text
		
		local Text = V[1]
		
		// Symbol
		
		local Symbol = SS.Groups.GetGroupSymbol(V[1])
		
		// No symbol
		
		if (Symbol != "") then Text = "["..Symbol.."] "..Text end
		
		// Button
		
		Panel:Button(Text, 'ss groupscommand "'..V[1]..'"', Col.r, Col.g, Col.b)
	end
	
	// Send
	
	Panel:Send()
end

Groups:Create(Groups.Command, {"Basic"}, "View available groups")