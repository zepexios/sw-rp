// CVAR

CVAR           = {} // CVAR table
CVAR.Store     = {} // Where CVARS are stored
CVAR.Functions = {} // Where CVAR functions are stored

// New CVAR

function CVAR.New(Player, Index, Value, Function)
	local Identity = Player:SteamID()
	
	// Ready
	
	local Ready = Player:IsPlayerReady()
	
	// Ready
	
	if not (Ready) then return end
	
	// Create the new CVAR
	
	CVAR.Store[Identity][Index] = CVAR.Store[Identity][Index] or Value
	
	// Function
	
	if (Function) then
		CVAR.Functions[Index] = Function
	end
end

// Create CVARS

function CVAR.Create(Player)
	local Identity = Player:SteamID()
	
	// Create it
	
	CVAR.Store[Identity] = CVAR.Store[Identity] or {}
end

// Get a CVAR

function CVAR.Request(Player, Index)
	local Identity = Player:SteamID()
	
	// Ready
	
	local Ready = Player:IsPlayerReady()
	
	// Ready
	
	if not (Ready) then return end
	
	// Request it
	
	if (CVAR.Store[Identity][Index]) then
		CVAR.Store[Identity][Index] = SS.Lib.StringValue(CVAR.Store[Identity][Index])
	end

	// Return it
	
	return CVAR.Store[Identity][Index]
end

// Update CVAR

function CVAR.Update(Player, Index, Value)
	local Identity = Player:SteamID()
	
	// Ready
	
	local Ready = Player:IsPlayerReady()
	
	// Ready
	
	if not (Ready) then return end
	
	// Update it
	
	CVAR.Store[Identity][Index] = Value
	
	// Update the player's GUI
	
	SS.Player.PlayerUpdateGUI(Player)
end

// Insert value into a CVAR

function CVAR.Insert(Player, Index, Value)
	local Identity = Player:SteamID()
	
	// Ready
	
	local Ready = Player:IsPlayerReady()
	
	// Ready
	
	if not (Ready) then return end
	
	// Insert into a CVAR table
	
	if (CVAR.Store[Identity][Index]) then
		table.insert(CVAR.Store[Identity][Index], Value)
	end
end

// Clear CVAR

function CVAR.Clear(Player)
	local Identity = Player:SteamID()
	
	// Store
	
	CVAR.Store[Identity] = nil
end

// Save CVARS

function CVAR.Save(Player)
	local Identity = Player:SteamID()
	
	// Ready
	
	local Ready = Player:IsPlayerReady()
	
	// Ready
	
	if not (Ready) then return end
	
	// Header
	
	local Header = {}
	
	Header[1] = "Type:ServerSecure File"
	Header[2] = "Player:"..string.format("%q", Player:Name())
	Header[3] = "Date:"..os.date("%m/%d/%y")
	
	// Contents
	
	local Contents = SS.Serialise.Serialise(CVAR.Store[Identity])
	
	// Write it to the file
	
	file.Write("ServerSecure/CVARS/"..string.gsub(Identity, ":", "-")..".txt", Contents)
	
	// Update the player's GUI
	
	SS.Player.PlayerUpdateGUI(Player)
	
	// Run the player data saved hook
	
	SS.Hooks.Run("PlayerDataSaved", Player)
end

// Load CVARS

function CVAR.Load(Player)
	local Identity = Player:SteamID()
	
	// Save
	
	local Save = string.gsub(Identity, ":", "-")
	
	// Check if it exists
	
	if (file.Exists("ServerSecure/CVARS/"..Save..".txt")) then
		local File = file.Read("ServerSecure/CVARS/"..Save..".txt")
		
		// File
		
		if (File) then
			local Table = SS.Serialise.Deserialise(File)
			
			// Set the player's CVAR store
			
			CVAR.Store[Identity] = Table
			
			// Try the old way
			
			if not (CVAR.Store[Identity]) then
				CVAR.Store[Identity] = SS.Lib.KeyValuesToTable(File)
			end
			
			// It still isn't working
			
			if not (CVAR.Store[Identity]) then
				CVAR.Store[Identity] = {}
			end
		end
	end
	
	// Run the player data loaded hook
	
	SS.Hooks.Run("PlayerDataLoaded", Player)
end