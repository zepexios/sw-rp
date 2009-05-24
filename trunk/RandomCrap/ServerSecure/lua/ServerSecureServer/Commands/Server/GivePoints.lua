// Points enabled

if (!SS.Config.Request("Points Enabled")) then return end

// Give points

local Command = SS.ChatCommands:New("GivePoints")

// Branch flag

SS.Flags.Branch("Server", "GivePoints")

// Take command

function Command.Command(Player, Args)
	local Amount = Args[2]
	
	// Valid
	
	if not (Amount) then SS.PlayerMessage(Player, "That isn't a valid amount!", 1) return end
	
	// Floor
	
	Amount = math.floor(Amount)
	
	// Too small
	
	if (Amount <= 0) then SS.PlayerMessage(Player, "That amount is too small!", 1) return end
	
	// Person and error
	
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Person
	
	if (Person) then
		SS.Points.PlayerGain(Person, Amount)
		
		// Message
		
		SS.PlayerMessage(0, Player:Name().." gave "..Amount.." "..SS.Config.Request("Points Name").." to "..Person:Name().."!", 0)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

Command:Create(Command.Command, {"GivePoints", "Server"}, "Give points to somebody", "<Player> <Amount>", 2, " ")