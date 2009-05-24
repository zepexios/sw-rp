// Downloads

local Parse = SS.Parser:New("lua/ServerSecureServer/Config/Downloads")

// Parse exists

local Exists = Parse:Exists()

// Check the parse exists

if (Exists) then
	local Results = Parse:Parse()
	
	// Message
	
	Msg("\n")
	
	// Loop
	
	for K, V in pairs(Results) do
		for B, J in pairs(V) do
			if (file.IsDir("../"..J)) then
				SS.Lib.AddCustomContent(J)
			else
				if (file.Exists("../"..J)) then
					resource.AddFile(J)
				end
			end
		end
	end
end