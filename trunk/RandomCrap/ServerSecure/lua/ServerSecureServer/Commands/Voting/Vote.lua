// Vote

local Vote = SS.ChatCommands:New("Vote")

// Votes allowed

Vote.Allowed = {
	"sbox_",
	"sv_"
}

// Acceptable vote

function Vote.Acceptable(Command)
	if (string.find(Command, ";")) then
		return false
	end
	
	// Loop
	
	for K, V in pairs(Vote.Allowed) do
		if string.find(string.lower(Command), string.lower(V)) then
			return true
		end
	end
	
	// Return false
	
	return false
end

// Vote command

function Vote.Command(Player, Args)
	if not Vote.Acceptable(Args[1]) then
		SS.PlayerMessage(Player, "That command is not acceptable!", 1)
		
		// Return
		
		return
	end
	
	// Command
	
	local Command = Args[1]
	
	// Remove
	
	table.remove(Args, 1)
	
	// Value
	
	local Value = table.concat(Args, " ")
	
	// Find
	
	if (string.find(Value, ";")) then
		SS.PlayerMessage(Player, "That command is not acceptable!", 1)
		
		// Return
		
		return
	end
	
	// Panel
	
	local Panel = SS.Voting:New("Vote", Command..": "..Value, false)
	
	// Panel already exists
	
	if not Panel then SS.PlayerMessage(Player, "A vote is already in progress!", 1) return end
	
	// Settings
	
	Vote.Command = Command
	Vote.Value = Value
	
	// Words
	
	Panel:Words("Yes")
	Panel:Words("No")
	
	// Send
	
	Panel:Send(20, Vote.Callback)
	
	// Message
	
	SS.PlayerMessage(Player, Player:Name().." started a vote for "..Command.." "..Value.."!", 0)
end

// Callback command

function Vote.Callback(Winner, Number, Table)
	if (Winner == "" or Winner == " ") then SS.PlayerMessage(0, "CVAR Vote: Not enough votes to win!", 0) return end
	
	// Winner
	
	if (Winner == "Yes") then
		SS.PlayerMessage(0, "CVAR Vote: "..Vote.Command.." changed to "..Vote.Value.."!", 0)
		
		// Console command
		
		SS.Lib.ConCommand(Vote.Command, Vote.Value)
	else
		SS.PlayerMessage(0, "CVAR Vote: Not enough votes to change "..Vote.Command.." to "..Vote.Value.."!", 0)
	end
end

Vote:Create(Vote.Command, {"Basic"}, "Vote for a console variable", "<Command>, <Value>", 2, ", ")