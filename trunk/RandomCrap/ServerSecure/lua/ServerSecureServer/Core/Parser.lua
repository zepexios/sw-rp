// Parser

SS.Parser = {} -- Parser

// Load

function SS.Parser:New(File)
	local Table = {}
	
	setmetatable(Table, self)
	
	self.__index = self
	
	// Variables
	
	Table.File = file.Read("../"..File..".ini")
	Table.Results = {}

	// Return table
	
	return Table
end

// Check

function SS.Parser:Exists()
	if not (self.File) or (self.File == "") then
		return false
	end
	
	// Return true
	
	return true
end

// Strip comments

function SS.Parser:Comments(Line)
	local Find = string.find(Line, "#")
	
	// If found
	
	if (Find) then
		Line = string.sub(Line, 1, Find - 1)
	end
	
	// Return line
	
	return Line
end

// Strip quotes

function SS.Parser:Quotes(Line)
	return string.gsub(Line, "^[\"'](.+)[\"']$", "%1")
end

// Debug

function SS.Parser:Debug(Message)
	MsgAll("[Parser] - "..Message.."\n")
end

// Change

function SS.Parser:Change(String)
	if (tonumber(String)) then
		return tonumber(String)
	end
	
	// Return true
	
	if (string.lower(String) == "true") then
		return true
	end
	
	// Return false
	
	if (string.lower(String) == "false") then
		return false
	end
	
	// Return string
	
	return String
end

// Information from section

function SS.Parser:Info(Section, Key)
	local Results = self:Parse()
	
	// Loop
	
	for K, V in pairs(Results) do
		if (K == Section) then
			for B, J in pairs(V) do
				if (B == Key) then
					return J
				end
			end
		end
	end
	
	// Return empty string
	
	return ""
end

// Get a section

function SS.Parser:Section(Section)
	local Results = self:Parse()
	
	// Loop
	
	for K, V in pairs(Results) do
		if (K == Section) then
			return V
		end
	end
	
	// Return table
	
	return {}
end

// Get information

function SS.Parser:Parse()
	local Current = ""
	
	// Explode
	
	local Explode = string.Explode("\n", self.File)
	
	// Loop
	
	for K, V in pairs(Explode) do
		local Line = string.Trim(self:Comments(V))
		
		// Line
		
		if (Line != "") then
			if (string.sub(Line, 1, 1) == "[") then
				local End = string.find(Line, "%]")
				
				// End
				
				if (End) then
					local Block = string.sub(Line, 2, End - 1)
					
					// Results
					
					self.Results[Block] = self.Results[Block] or {}
					
					// Current
					
					Current = Block
				end
			else
				self.Results[Current] = self.Results[Current] or {}
				
				// Current
				
				if (Current != "") then
					local Data = string.Explode("=", Line)
					
					// Count
					
					if (table.Count(Data) == 2) then
						local Key   = self:Quotes(string.Trim(Data[1]))
						local Value = self:Quotes(string.Trim(Data[2]))
						
						// Value
						
						Value = self:Change(Value)
						
						// Results
						
						self.Results[Current][Key] = Value
					else
						if (table.Count(Data) == 1) then
							Value = self:Quotes(string.Trim(Line))
							Value = self:Change(Value)
							
							// Insert
							
							table.insert(self.Results[Current], Value)
						end
					end
				end
			end
		end
	end
	
	// Return results
	
	return self.Results
end