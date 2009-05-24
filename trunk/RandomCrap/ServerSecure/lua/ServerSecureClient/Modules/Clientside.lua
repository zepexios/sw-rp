// Clientside

SS.Clientside = {}

// Initialize

function SS.Clientside.Initialize()
	local Files = file.FindInLua("ServerSecureServer/Core/Clientside/*.lua")
	
	// New line
	
	Msg("\n")
	
	// Loop
	
	for K, V in pairs(Files) do
		include("ServerSecureServer/Core/Clientside/"..V)
		
		Msg("\n[Clientside] File - "..V.." loaded!")
	end
	
	// New line
	
	Msg("\n")
end

hook.Add("Initialize", "SS.Clientside.Initialize", SS.Clientside.Initialize)