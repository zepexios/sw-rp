// Me

local Me = SS.ChatCommands:New("Me")

// Me command

function Me.Command(Player, Args)
	Args = table.concat(Args, " ")
	
	// Players
	
	local Players = player.GetAll()
	
	// Loop
	
	for K, V in pairs(Players) do
		V:PrintMessage(3, Player:Name().." "..Args)
	end
end

Me:Create(Me.Command, {"Basic", "Me"}, "Create a message about yourself in the chat area", "<Message>", 1, " ")