// Points enabled

if (!SS.Config.Request("Points Enabled")) then return end

// Give

local Command = SS.ChatCommands:New("Give")

// Give command

function Command.Command(Player, Args)
	local Amount = Args[2]
	
	// Amount
	
	if not (Amount) then SS.PlayerMessage(Player, "That isn't a valid amount!", 1) return end
	
	// Floor
	
	Amount = math.floor(Amount)
	
	// Amount is too small
	
	if (Amount <= 0) then SS.PlayerMessage(Player, "That amount is too small!", 1) return end
	
	// Person
	
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Person
	
	if (Person) then
		if (CVAR.Request(Player, "Points") >= Amount) then
			SS.Points.PlayerGain(Person, Amount)
			SS.Points.PlayerTake(Player, Amount)
			
			// Message
			
			SS.PlayerMessage(Person, Player:Name().." gave you "..Amount.." "..SS.Config.Request("Points Name").."!", 0)
			SS.PlayerMessage(Player, "You gave "..Person:Name().." "..Amount.." "..SS.Config.Request("Points Name").."!", 0)
		else
			SS.PlayerMessage(Player, "You do not have enough "..SS.Config.Request("Points Name").."!", 1)
		end
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

Command:Create(Command.Command, {"Basic"}, "Give somebody points", "<Player> <Amount>", 2, " ")