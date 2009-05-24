// RCON

local RCON = SS.ChatCommands:New("RCON")

// Branch flag

SS.Flags.Branch("Server", "RCON")

// RCON command

function RCON.Command(Player, Args)
	Args = table.concat(Args, " ")
	
	// Console command
	
	game.ConsoleCommand(Args.."\n")
end

RCON:Create(RCON.Command, {"Server", "RCON"}, "Run a command on the server", "<Command>", 1, " ")