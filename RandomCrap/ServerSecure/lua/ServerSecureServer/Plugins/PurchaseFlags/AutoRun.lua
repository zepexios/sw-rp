// Purchase flags

SS.PurchaseFlags = SS.Plugins:New("SS.PurchaseFlags")

// Store all flags

SS.PurchaseFlags.List = {}

// Add a flag to the list

function SS.PurchaseFlags.Add(Flag, ID, Cost, Description, Function)
	SS.PurchaseFlags.List[Flag] = {Cost, ID, Flag, Description, Function}
	
	// Create it
	
	local Flag = SS.Purchases:New(ID, Flag)
	
	// Purchase condition
	
	function Flag.PurchaseCondition(Player, Item)
		for K, V in pairs(SS.PurchaseFlags.List) do
			if (Item == V[2]) then
				if (SS.Flags.PlayerHas(Player, V[3])) then
					return false
				end
			end
		end
		
		// Return true
		
		return true
	end
	
	// Purchase removed
	
	function Flag.PurchaseRemoved(Player, Item)
		for K, V in pairs(SS.PurchaseFlags.List) do
			if (Item == V[2]) then
				if (SS.Flags.PlayerHas(Player, V[3])) then
					SS.Flags.PlayerTake(Player, V[3])
				end
			end
		end
	end
	
	// Purchase given
	
	function Flag.PurchaseGiven(Player, Item)
		for K, V in pairs(SS.PurchaseFlags.List) do
			if (Item == V[2]) then
				if not (SS.Flags.PlayerHas(Player, V[3])) then
					SS.Flags.PlayerGive(Player, V[3])
					
					// Check function
					
					if (V[5]) then
						V[5](Player)
					end
				end
			end
		end
	end
	
	// Create
	
	Flag:Create(Cost, {}, "Flags", Description)
end

// Include the config file

include("Config.lua")

// Create

SS.PurchaseFlags:Create()