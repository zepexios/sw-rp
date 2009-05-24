// Rules

local Parse = SS.Parser:New("lua/ServerSecureServer/Config/Rules")

// Parse exists

local Exists = Parse:Exists()

// Check the parse exists

if (Exists) then
	local Results = Parse:Parse()
	
	// Loop
	
	for K, V in pairs(Results) do
		for B, J in pairs(V) do
			SS.Rules.Add(J)
		end
	end
end