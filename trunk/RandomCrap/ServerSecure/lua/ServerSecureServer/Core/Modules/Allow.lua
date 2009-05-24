// Allow

SS.Allow = {}

// PlayerSetVariables hook

function SS.Allow.PlayerSetVariables(Player)
	TVAR.New(Player, "Allowed", {})
end

// Hook into player set variables

SS.Hooks.Add("SS.Allow.PlayerSetVariables", "PlayerSetVariables", SS.Allow.PlayerSetVariables)

// PlayerWeapons hook

function SS.Allow.PlayerGivenWeapons(Player)
	local Allowed = SS.Allow.PlayerGetAllowed(Player, "Spawn")
	
	// Return false
	
	if not (Allowed) then Player:StripWeapons() end
end

// Hook into player set variables

SS.Hooks.Add("SS.Allow.PlayerGivenWeapons", "PlayerGivenWeapons", SS.Allow.PlayerGivenWeapons)

// Player allow

function SS.Allow.PlayerAllow(Player, ID, Activity, Bool)
	// Allow or disallow it
	
	TVAR.Request(Player, "Allowed")[ID] = TVAR.Request(Player, "Allowed")[ID] or {}
	TVAR.Request(Player, "Allowed")[ID][Activity] = Bool
end

// Player allowed

function SS.Allow.PlayerGetAllowed(Player, Activity)
	local Table = TVAR.Request(Player, "Allowed")
	
	// Check the table exists
	
	if (Table) then
		for K, V in pairs(Table) do
			for B, J in pairs(V) do
				if (B == Activity) then
					local Allowed = J
					
					// Return false
					
					if not (Allowed) then return false end
				end
			end
		end
	end
	
	// Return true
	
	return true
end

// Player spawn object hook

function SS.Allow.PlayerSpawnObject(Player)
	local Allowed = SS.Allow.PlayerGetAllowed(Player, "Spawn")
	
	// Return false
	
	if not (Allowed) then return false end
end

hook.Add("PlayerSpawnObject", "SS.Allow.PlayerSpawnObject", SS.Allow.PlayerSpawnObject)

// Player noclip hook

function SS.Allow.PlayerNoClip(Player)
	local Allowed = SS.Allow.PlayerGetAllowed(Player, "Noclip")
	
	// Return false
	
	if not (Allowed) then return false end
end

hook.Add("PlayerNoClip", "SS.Allow.PlayerNoClip", SS.Allow.PlayerNoClip)

// Can tool hook

function SS.Allow.CanTool(Player)
	local Allowed = SS.Allow.PlayerGetAllowed(Player, "Tool")
	
	// Return false
	
	if not (Allowed) then return false end
end

hook.Add("CanTool", "SS.Allow.CanTool", SS.Allow.CanTool)

// Player spawn hook

function SS.Allow.PlayerSpawn(Player)
	local Allowed = SS.Allow.PlayerGetAllowed(Player, "Death")
	
	// Spawn at the saved position
	
	if not (Allowed) then
		local Position = TVAR.Request(Player, "Death Position")
		
		// Position
		
		if (Position) then
			Player:SetPos(Position)
		end
	end
end

// Hook into player spawn

SS.Hooks.Add("SS.Allow.PlayerSpawn", "PlayerSpawn", SS.Allow.PlayerSpawn)

// Do player death hook

function SS.Allow.DoPlayerDeath(Player)
	local Allowed = SS.Allow.PlayerGetAllowed(Player, "Death")
	
	// Position
	
	local Position = Player:GetPos()
	
	// TVAR
	
	TVAR.Update(Player, "Death Position", Position)
end

hook.Add("DoPlayerDeath", "SS.Allow.DoPlayerDeath", SS.Allow.DoPlayerDeath)

// Physgun pickup hook

function SS.Allow.PhysgunPickup(Player)
	local Allowed = SS.Allow.PlayerGetAllowed(Player, "Physgun")
	
	// Return false
	
	if not (Allowed) then return false end
end

hook.Add("PhysgunPickup", "SS.Allow.PhysgunPickup", SS.Allow.PhysgunPickup)