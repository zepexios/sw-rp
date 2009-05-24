// CEXEC

local CEXEC = SS.ChatCommands:New("CEXEC")

// Branch flag

SS.Flags.Branch("Administrator", "CEXEC")

// CEXEC command

function CEXEC.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	if (Person) then
		local Error = SS.Player.Immune(Player, Person, "CEXEC")
		
		if (Error and Person != Player) then SS.PlayerMessage(Player, Error, 1) return end
		
		// Replace command
		
		local Command = table.concat(Args, " ", 2)
		
		// Replace colon with a quote
		
		Command = string.Replace(Command, ":", "\"")
		
		// Run command
		
		Person:ConCommand(Command.."\n")
		
		// Message
		
		SS.PlayerMessage(Player, Command.." executed on "..Person:Name().."!", 0)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

CEXEC:Create(CEXEC.Command, {"Administrator", "CEXEC"}, "Run a command on somebody", "<Player> <Command>", 2, " ")

// CEXECALL command

local CEXECALL = SS.ChatCommands:New("CEXECALL")

// Branch flag

SS.Flags.Branch("Administrator", "CEXECALL")

function CEXECALL.Command(Player, Args)
	// Replace command
	
	local Command = table.concat(Args, " ")
	
	// Replace colon with a quote
	
	Command = string.Replace(Command, ":", "\"")
	
	// Loop
	
	local Players = player.GetAll()
	
	for K, V in pairs(Players) do
		local Error = SS.Player.Immune(Player, V)
		
		// Run command
		
		if not (Error) then
			V:ConCommand(Command.."\n")
		end
	end
	
	SS.PlayerMessage(Player, Command.." executed on everybody!", 0)
end

// Create

CEXECALL:Create(CEXECALL.Command, {"Administrator", "CEXECALL"}, "Run a command on everybody", "<Command>", 1, " ")