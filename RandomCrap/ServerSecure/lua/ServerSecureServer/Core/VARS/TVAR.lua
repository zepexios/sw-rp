// TVAR

TVAR 	   = {} // TVAR table
TVAR.Store = {} // Where TVARS are stored

// New TVAR

function TVAR.New(Player, Index, Value)
	local Identity = Player:SteamID()
	
	// Store
	
	TVAR.Store[Identity] = TVAR.Store[Identity] or {}
	TVAR.Store[Identity][Index] = TVAR.Store[Identity][Index] or Value
end

// Get a TVAR

function TVAR.Request(Player, Index)
	local Identity = Player:SteamID()
	
	// Store
	
	TVAR.Store[Identity] = TVAR.Store[Identity] or {}
	
	// Store
	
	if (TVAR.Store[Identity][Index]) then
		TVAR.Store[Identity][Index] = SS.Lib.StringValue(TVAR.Store[Identity][Index])
	end
	
	// Return
	
	return TVAR.Store[Identity][Index]
end

// Update TVAR

function TVAR.Update(Player, Index, Value)
	local Identity = Player:SteamID()
	
	// Store
	
	TVAR.Store[Identity] = TVAR.Store[Identity] or {}
	TVAR.Store[Identity][Index] = Value
end

// Reset TVARS

function TVAR.Reset(Player)
	local Identity = Player:SteamID()
	
	// Store
	
	TVAR.Store[Identity] = TVAR.Store[Identity] or {}
end

SS.Hooks.Add("TVAR.Reset", "PlayerInitialSpawn", TVAR.Reset)