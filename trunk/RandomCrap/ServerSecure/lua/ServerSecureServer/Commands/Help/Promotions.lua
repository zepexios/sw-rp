// Promotions

local Promotions = SS.ChatCommands:New("Promotions")

// View command

function Promotions.Command(Player, Args)
	local Panel = SS.Panel:New(Player, "Promotions")
	
	// Sort
	
	table.sort(SS.Promotion.List, function(A, B) return A[2] > B[2] end)
	
	// Loop
	
	for K, V in pairs(SS.Promotion.List) do
		Panel:Words(V[1]..": "..V[2].." Hours")
	end
	
	// Send
	
	Panel:Send()
end

Promotions:Create(Promotions.Command, {"Basic"}, "View available promotions")