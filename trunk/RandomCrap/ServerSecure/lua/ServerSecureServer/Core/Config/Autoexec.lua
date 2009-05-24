// Autoexec

local Parse = SS.Parser:New("lua/ServerSecureServer/Config/Autoexec")

// Parse exists

local Exists = Parse:Exists()

// Check the parse exists

if (Exists) then
	local Results = Parse:Parse()
	
	// Loop
	
	for K, V in pairs(Results) do
		if (K == "All" or K == game.GetMap()) then
			for B, J in pairs(V) do
				SS.Lib.ConCommand(B, J)
			end
		end
	end
end
