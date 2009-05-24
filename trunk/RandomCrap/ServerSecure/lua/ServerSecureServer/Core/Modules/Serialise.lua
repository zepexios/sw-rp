// Serialise (DEADBEEF)

SS.Serialise = {}

// Serialise a chunk

function SS.Serialise.SerialiseChunk(Chunk, Tables, Table)
	// Get the data type
	
	local Type = type(Chunk)

	// See what data type this chunk represents and return the proper value
	
	if Type == "number"  then return 'N:'..Chunk
	elseif Type == "string"  then return string.format('S:%q', Chunk)
	elseif Type == "boolean" then return 'B:'..tostring(Chunk):sub(1, 1)
	elseif Type == "Entity"  then if Chunk == GetWorldEntity() then return 'E:W' elseif Chunk == NULL then return 'E:N' else return 'E:'..Chunk:EntIndex()  end
	elseif Type == "Vector"  then return string.format("V:%g,%g,%g", Chunk.x, Chunk.y, Chunk.z)
	elseif Type == "Angle"   then return string.format("A:%g,%g,%g", Chunk.pitch, Chunk.yaw, Chunk.roll)
	elseif Type == "Player"  then return 'P:'..Chunk:UniqueID()
	elseif Type == "table"	 then
		local ID = tostring(Chunk):sub(8)
		
		// Blah blah check
		
		if (!Tables[ID]) then Tables[ID] = true Tables[ID] = SS.Serialise.SerialiseTableKeyValues(Chunk, Tables, Table) end
		
		return 'T:'..ID
	end
end

// Deserialise a chunk

function SS.Serialise.DeserialiseChunk(Chunk, Tables, Table)
	// Get the data type and value
	
	local Type, Val = Chunk:match("(.):(.+)")
	
	// See what data type this chunk represents and return the proper value
	
	if Type == "N" then return tonumber(Val)
	elseif Type == "S" then return Val:sub(2, -2)
	elseif Type == "Z" then return Table[Val:sub(2, -2)]
	elseif Type == "B" then return Val == "t"
	elseif Type == "E" then if Val == "W" then return GetWorldEntity() elseif Val == "N" then return NULL else return Entity(Val)  end
	elseif Type == "V" then
		local A, B, C = Val:match("(.-),(.-),(.+)")
		
		return Vector(tonumber(A), tonumber(B), tonumber(C))
	elseif Type == "A" then
		local A, B, C = Val:match("(.-),(.-),(.+)")
		
		return Angle(tonumber(A), tonumber(B), tonumber(C))
	elseif Type == "P" then return player.GetByUniqueID(Val)
	elseif Type == "T" then 
		local T = {}
		
		// Value
		
		if (!Tables[Val]) then Tables[Val] = {} end
		
		// Insert
		
		table.insert(Tables[Val], T)
		
		// Return
		
		return T
	end
end

// Serialise table to key values

function SS.Serialise.SerialiseTableKeyValues(TBL, Tables, Table)
	local Temp = {}
	
	// Get if keys are sequential
	
	local Keys = !table.IsSequential(TBL)

	// Table
	
	for K, V in pairs(TBL) do
		local String = SS.Serialise.SerialiseChunk(V, Tables, Table)
		
		// Keys and string
		
		if (Keys) and (String) then String = SS.Serialise.SerialiseChunk(K, Tables, Table).."="..String end
		
		// Insert
		
		table.insert(Temp, String)
	end

	// Return the table
	
	return Temp
end

// Serialise

function SS.Serialise.Serialise(T, Len)
	local Tables	= {}
	local STR		= ""
	local Strings	= {}

	// HeadID and Head
	
	local HeadID = tostring(T):sub(8)
	local Head	 = SS.Serialise.SerialiseTableKeyValues(T, Tables)

	// Distinguish the main table from nested tables
	
	Tables[HeadID] = nil
	Tables["H"..HeadID] = Head
	
	// Loop
	
	for K, V in pairs(Tables) do
		// Concat key values for each table
		
		STR = STR..K.."{"..table.concat(V, ";")..";}"
		
		// If string is too long split it and start a new one
		
		if (Len and #STR >= Len) then
			table.insert(Strings, STR:sub(1, Len))
			
			// Sub
			
			STR = STR:sub(Len + 1)
		end
	end
	
	// Insert it into the strings table
	
	table.insert(Strings, STR)

	// Unpack strings and return them as seperate values
	
	return unpack(Strings)
end

// Pass this function the output from the previous one

function SS.Serialise.Deserialise(...)
	// Re-combine all strings we got passed
	
	local Block		= table.concat(arg)
	local Tables	= {}
	local Subtables	= {}
	local Head		= nil

	// I'm not too good at regex, so there's probably a more efficient way of doing lines 120, 127, 129
	
	for ID, Chunk in Block:gmatch('(%w+){(.-)}') do // Get each table chunk
		// Check if this table is the trunk
		
		if (ID:sub(1, 1)== "H") then ID = ID:sub(2) Head = ID end
		
		// Tables
		
		Tables[ID] = {}
		
		// Loop
		
		for KV in Chunk:gmatch('(.-);') do // Split each table block into k/v pairs
			local K, V = KV:match('(.-)=(.+)') // Deserialise each k/v pair and add to the new table
			
			// If the table keys are sequential digits they won't be included in the string, so check for that
			
			if (!K) then
				V = SS.Serialise.DeserialiseChunk(KV, Subtables)
				
				// Insert
				
				table.insert(Tables[ID], V)
			else
				K = SS.Serialise.DeserialiseChunk(K, Subtables)
				V = SS.Serialise.DeserialiseChunk(V, Subtables)
				
				// Tables
				
				Tables[ID][K] = V
			end
		end
	end

	// Restore table references
	
	for ID, TBLS in pairs(Subtables) do
		for _, TBL in pairs(TBLS) do
			table.Merge(TBL, Tables[ID])
		end
	end

	// Return the table
	
	return Tables[Head]
end