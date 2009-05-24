// Votekick

local Votekick = SS.ChatCommands:New("VoteKick")

// Config

Votekick.Interval = 60 // Seconds before can votekick again

// Variables

Votekick.Check  = {} // Leave this
Votekick.Player = "None" // Leave this

// Kick command

function Votekick.Command(Player, Args)
	local Time = RealTime()
	
	// Check last vote
	
	if (Votekick.Check[Player]) then
		if (Votekick.Check[Player] > Time) then
			SS.PlayerMessage(Player, "You cannot do another votekick so soon!", 1)
			
			// Return
			
			return
		end
	end
	
	// Find
	
	local Person, Error = SS.Lib.Find(Args[1])
	
	if (Person) then
		local Error = SS.Player.Immune(Player, Person, "Votekick")
		
		if (Error and Person != Player) then SS.PlayerMessage(Player, Error, 1) return end
		
		// Vote
		
		local Vote = SS.Voting:New("Kick", "Kick "..Person:Name(), false)
		
		// Menu
		
		if (Vote) then
			Votekick.Player = Person
			
			// Words
			
			Vote:Words("Yes")
			Vote:Words("No")
			
			// Send
			
			Vote:Send(20, Votekick.End)
		else
			SS.PlayerMessage(Player, "Votekick already in progress!", 1)
		end
		
		// Check
		
		Votekick.Check[Player] = Time + Votekick.Interval
		
		// Message
		
		SS.PlayerMessage(0, Player:Name().." has started a votekick against "..Person:Name().."!", 0)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

// End kick command

function Votekick.End(Winner, Number, Table)
	if (Winner == "" or Winner == " ") then SS.PlayerMessage(0, "Votekick - No result!", 0) return end
	
	// Winner was yes
	
	if (Winner == "Yes") then
		SS.PlayerMessage(0, "Votekick - "..Votekick.Player:Name().." kicked by vote!", 0)
		
		// Command
		
		game.ConsoleCommand("kickid "..Votekick.Player:SteamID().." Kicked by vote\n")
	else
		SS.PlayerMessage(0, "Votekick: Not enough votes to kick "..Votekick.Player:Name(), 0)
	end
end

// Create

Votekick:Create(Votekick.Command, {"Basic"}, "Start a vote to kick a player", "<Player>", 1, " ")

// Advert

SS.Adverts.Add("You can start a votekick by typing "..SS.ChatCommands.Prefix().."votekick <Name>")