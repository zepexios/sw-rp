// Points enabled

if (!SS.Config.Request("Points Enabled")) then return end

// Take points

local Command = SS.ChatCommands:New("TakePoints")

// Branch flag

SS.Flags.Branch("Server", "TakePoints")

// Take command

function Command.Command(Player, Args)
	local Amount = Args[2]
	
	// Valid
	
	if not (Amount) then SS.PlayerMessage(Player, "That isn't a valid amount!", 1) return end
	
	// Floor
	
	Amount = math.floor(Amount)
	
	// Small
	
	if (Amount <= 0) then SS.PlayerMessage(Player, "That amount is too small!", 1) return end
	
	// Person and error
	
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Person
	
	if (Person) then
		SS.Points.PlayerTake(Person, Args[2])
		
		// Message
		
		SS.PlayerMessage(0, Player:Name().." has taken "..Args[2].." "..SS.Config.Request("Points Name").." from "..Person:Name().."!", 0)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

Command:Create(Command.Command, {"TakePoints", "Server"}, "Take points from somebody", "<Player> <Amount>", 2, " ")