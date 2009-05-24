// Voteban

local Voteban = SS.ChatCommands:New("Voteban")

// Config

Voteban.Time = 60 // Time banned for
Voteban.Interval  = 60 // Seconds before can voteban again

// Variables

Voteban.Check  = {} // Leave this
Voteban.Player = "None" // Leave this

// Ban command

function Voteban.Command(Player, Args)
	local Time = RealTime()
	
	// Check last vote
	
	if (Voteban.Check[Player]) then
		if (Voteban.Check[Player] > Time) then
			SS.PlayerMessage(Player, "You cannot do another voteban so soon!", 1)
			
			// Return
			
			return
		end
	end
	
	// Find
	
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Person
	
	if (Person) then
		local Error = SS.Player.Immune(Player, Person, "Voteban")
		
		if (Error and Person != Player) then SS.PlayerMessage(Player, Error, 1) return end
		
		// Vote
		
		local Vote = SS.Voting:New("Ban", "Ban "..Person:Name(), false)
		
		// Menu
		
		if (Vote) then
			Voteban.Player = Person
			
			// Text
			
			Vote:Words("Yes")
			Vote:Words("No")
			
			// Send
			
			Vote:Send(20, Voteban.End)
		else
			SS.PlayerMessage(Player, "Voteban already in progress!", 1)
		end
		
		// Check
		
		Voteban.Check[Player] = Time + Voteban.Interval
		
		// Message
		
		SS.PlayerMessage(0, Player:Name().." has started a voteban against "..Person:Name().."!", 0)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

// End ban command

function Voteban.End(Winner, Number, Table)
	if (Winner == "" or Winner == " ") then SS.PlayerMessage(0, "Voteban - No result!", 0) return end
	
	// Winer was yes
	
	if (Winner == "Yes") then
		local Enough, Amount = SS.Lib.VotesNeeded(Number)
		
		// Enough
		
		if (Enough) then
			SS.Lib.PlayerBan(Voteban.Player, Voteban.Time, "Banned by vote")
		else
			SS.PlayerMessage(0, "Voteban - Not enough votes to ban "..Voteban.Player:Name()..", "..Number.."/"..Amount.."!", 1)
		end
	else
		SS.PlayerMessage(0, "Voteban - The winner was 'No'!", 0)
	end
end

// Create

Voteban:Create(Voteban.Command, {"Basic"}, "Start a voteban on a player", "<Player>", 1, " ")

// Advert

SS.Adverts.Add("You can start a voteban by typing "..SS.ChatCommands.Prefix().."voteban <Name>")