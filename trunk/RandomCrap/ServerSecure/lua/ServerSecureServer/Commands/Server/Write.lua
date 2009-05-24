// Write

local Write = SS.ChatCommands:New("Write")

// Branch flag

SS.Flags.Branch("Server", "Write")

// Write command

function Write.Command(Player, Args)
	local File = Args[1]
	
	// Remove
	
	table.remove(Args, 1)
	
	// Text
	
	local Text = table.concat(Args, " ")
	
	// Content
	
	local Content = ""
	
	// Exists
	
	if (file.Exists("ServerSecure/Text/"..File..".txt")) then
		Content = file.Read("ServerSecure/Text/"..File..".txt").."\n"
	end
	
	// Concatenate content
	
	Content = Content..Text
	
	// Write
	
	file.Write("ServerSecure/Text/"..File..".txt", Content)
	
	// Message
	
	SS.PlayerMessage(Player, "Text has been written to file: '"..File.."'!", 0)
end

Write:Create(Write.Command, {"Server", "Write"}, "Write text to a file in the Data/ServerSecure/Text/ directory", "<File> <Text>", 2, " ")

// Read

local Read = SS.ChatCommands:New("Read")

// Branch flag

SS.Flags.Branch("Server", "Read")

// Read command

function Read.Command(Player, Args)
	local File = Args[1]
	
	// Exists
	
	if (file.Exists("ServerSecure/Text/"..File)) then
		local Content = file.Read("ServerSecure/Text/"..File)
		
		// Explode
		
		local Explode = string.Explode("\n", Content)
		
		// Panel
		
		local Panel = SS.Panel:New(Player, File)
		
		// Loop
		
		for K, V in pairs(Explode) do
			Panel:Words(V)
		end
		
		// Send
		
		Panel:Send()
		
		// Message
		
		SS.PlayerMessage(Player, "'"..File.."' has been successfully opened!", 0)
	else
		SS.PlayerMessage(Player, "File does not exist: 'ServerSecure/Text/"..File.."'!", 0)
	end
end

Read:Create(Read.Command, {"Server", "Read"}, "Read a file from the Data/ServerSecure/Text/ directory", "<File>", 1, " ")