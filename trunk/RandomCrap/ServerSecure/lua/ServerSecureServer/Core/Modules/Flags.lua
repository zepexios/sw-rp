// Flags

SS.Flags      = {} // Flags table
SS.Flags.Tree = {} // Where flags are stored

// Player has

function SS.Flags.PlayerHas(Player, Flag)
	local Valid = Player:IsPlayer()
	
	// Check valid
	
	if not (Valid) then return true end
	
	// Ready
	
	if not (Player:IsPlayerReady()) then return false end
	
	// Type
	
	local Type = type(Flag)
	
	// String
	
	if (Type == "string") then
		for K, V in pairs(SS.Flags.Tree) do
			for B, J in pairs(V) do
				if (J == Flag) then
					if (SS.Flags.PlayerHas(Player, K)) then
						return true
					end
				end
			end
		end
		
		// CVAR
		
		if (CVAR.Request(Player, "Flags")[Flag]) then
			return true
		end
	else
		for B, J in pairs(Flag) do
			if SS.Flags.PlayerHas(Player, J) then
				return true
			end
		end
	end
	
	// Return false
	
	return false
end

// Player take group flags

function SS.Flags.PlayerTakeGroupFlags(Player, Group)
	for K, V in pairs(SS.Groups.List) do
		if (V[1] == Group) then
			for B, J in pairs(V[8]) do
				SS.Flags.PlayerTake(Player, J)
			end
		end
	end
end

// Player give

function SS.Flags.PlayerGive(Player, Flag)
	local Type = type(Flag)
	
	// Flags
	
	if (Type == "table") then
		for K, V in pairs(Flag) do
			SS.Flags.PlayerGive(Player, V)
		end
		
		// Return true
		
		return true
	end
	
	// Check
	
	if (CVAR.Request(Player, "Flags")[Flag]) then
		return false
	end
	
	// Add it
	
	CVAR.Request(Player, "Flags")[Flag] = Flag
	
	// Hook
	
	SS.Hooks.Run("PlayerGivenFlag", Player, Flag)
	
	// Purchases
	
	SS.Purchases.GiveFree(Player)
	
	// Return true
	
	return true
end

// Add flag to tree

function SS.Flags.Branch(Tree, Flag)
	SS.Flags.Tree[Tree] = SS.Flags.Tree[Tree] or {}
	SS.Flags.Tree[Tree][Flag] = Flag
end

// Player take

function SS.Flags.PlayerTake(Player, Flag)
	if (CVAR.Request(Player, "Flags")[Flag]) then
		CVAR.Request(Player, "Flags")[Flag] = nil
		
		// Run hook
		
		SS.Hooks.Run("PlayerTakenFlag", Player, Flag)
		
		// Return true
		
		return true
	end
	
	// Return false
	
	return false
end

// Check if player should get free flag

function SS.Flags.GiveFree(Player)
	CVAR.New(Player, "Flags", {})
	
	// Give basic flags
	
	SS.Flags.PlayerGive(Player, "Basic")
	
	// Default
	
	for K, V in pairs(SS.Groups.List) do
		if (V[1] == SS.Player.Rank(Player)) then
			for B, J in pairs(V[8]) do
				SS.Flags.PlayerGive(Player, J)
			end
		end
	end
	
	// Run hook
	
	SS.Hooks.Run("PlayerGiveFreeFlags", Player)
end

// Hook into player set variables

SS.Hooks.Add("SS.Flags.GiveFree", "PlayerSetVariables", SS.Flags.GiveFree)