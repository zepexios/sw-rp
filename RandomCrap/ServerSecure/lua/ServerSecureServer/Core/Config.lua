// Config

SS.Config      = {}
SS.Config.List = {}

// New

function SS.Config.New(ID, ...)
	if (arg[2]) then
		local Table = {}
		
		// Loop
		
		for I = 1, table.getn(arg) do	
			Table[I] = arg[I]
		end
		
		// Insert
		
		SS.Config.List[ID] = Table
	else
		local String = tostring(arg[1])
		
		// Global string
		
		SetGlobalString("ServerSecure: "..ID, String)
		
		// List
		
		SS.Config.List[ID] = arg[1]
	end
end

// Request

function SS.Config.Request(ID)
	return SS.Config.List[ID]
end

// General

local Parse = SS.Parser:New("lua/ServerSecureServer/Config/General")

// Parse exists

local Exists = Parse:Exists()

// Check the parse exists

if (Exists) then
	local Results = Parse:Parse()
	
	// Loop
	
	for K, V in pairs(Results) do
		for B, J in pairs(V) do
			if (type(J) == "string") then
				local Explode = SS.Lib.StringExplode(J, ", ")
				
				// New config
				
				SS.Config.New(B, unpack(Explode))
			else
				SS.Config.New(B, J)
			end
		end
	end
end