// Openscript

local Openscript = SS.ChatCommands:New("Openscript")

// Branch flag

SS.Flags.Branch("Server", "Openscript")

// Openscript command

function Openscript.Command(Player, Args)
	local File = table.concat(Args, " ")
	
	// Exists
	
	if not (file.Exists("../lua/ServerSecureServer/"..File)) then
		SS.PlayerMessage(Player, "No such file ServerSecure/"..File, 1)
		
		// Return
		
		return
	end
	
	// Command
	
	SS.Lib.ConCommand("lua_openscript", "ServerSecureServer/"..File)
	
	// Message
	
	SS.PlayerMessage(Player, "ServerSecure/"..File.." opened", 0)
end

Openscript:Create(Openscript.Command, {"Server", "Openscript"}, "Open a script relative to the ServerSecure folder", "<File>", 1, " ")