// SVAR

SVAR 	   = {} -- SVAR table
SVAR.Store = {} -- Where SVARS are stored

// New SVAR

function SVAR.New(Index, Value)
	SVAR.Store[Index] = SVAR.Store[Index] or Value
end

// Get an SVAR

function SVAR.Request(Index)
	if (SVAR.Store[Index]) then
		SVAR.Store[Index] = SS.Lib.StringValue(SVAR.Store[Index])
	end
	
	// Return
	
	return SVAR.Store[Index]
end

// Update an SVAR

function SVAR.Update(Index, Value)
	SVAR.Store[Index] = Value
end

// Save SVARS

function SVAR.Save()
	// Header
	
	local Header = {}
	
	Header[1] = "Type:ServerSecure File"
	
	// Contents
	
	local Contents = SS.Lib.TableToKeyValues(SVAR.Store)
	
	// Write it
	
	file.Write("ServerSecure/SVARS/SVARS.txt", Contents)
end

// Load SVARS

function SVAR.Load()
	if (file.Exists("ServerSecure/SVARS/SVARS.txt")) then
		local File = file.Read("ServerSecure/SVARS/SVARS.txt")
		
		// File
		
		if (File) then
			SVAR.Store = SS.Serialise.Deserialise(File)
			
			// Must be an old format, try the old way
			
			if not (SVAR.Store) then
				SVAR.Store = SS.Lib.KeyValuesToTable(File)
			end
		end
	end
end

// Load them

SVAR.Load()