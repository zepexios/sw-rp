// Lua run

local LuaRun = SS.ChatCommands:New("LuaRun")

// Branch flag

SS.Flags.Branch("Server", "LuaRun")

// RCON command

function LuaRun.Command(Player, Args)
	Args = table.concat(Args, " ")
	
	// Run the lua command
	
	game.ConsoleCommand("lua_run "..Args.."\n")
	
	// Message
	
	SS.PlayerMessage(Player, "Lua '"..Args.."' has been run on the server!", 0)
end

LuaRun:Create(LuaRun.Command, {"Server", "LuaRun"}, "Run a lua command on the server", "<Command>", 1, " ")