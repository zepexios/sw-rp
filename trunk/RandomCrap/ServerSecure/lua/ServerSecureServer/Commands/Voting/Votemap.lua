// Votemap

local Votemap = SS.ChatCommands:New("Votemap")

// Config

Votemap.Interval = 30

// Time

Votemap.Check = {}
Votemap.Time = 5

// Map command

function Votemap.Command(Player, Args)
	local Time = RealTime()
	
	// Check last vote
	
	if (Votemap.Check[Player]) then
		if (Votemap.Check[Player] > Time) then
			SS.PlayerMessage(Player, "You cannot do another votemap so soon!", 1)
			
			return
		end
	end
	
	// Vote
	
	local Vote = SS.Voting:New("Vote Map", "Vote Map", false)
	
	// Vote
	
	if not (Vote) then SS.PlayerMessage(Player, "Votemap already in progress!", 1) return end
	
	// Loop
	
	for K, V in pairs(Args) do
		V = string.gsub(V, ".bsp", "")
		
		// Text
		
		Vote:Words(V)
	end
	
	// Send
	
	Vote:Send(30, Votemap.End)
	
	// Update check
	
	Votemap.Check[Player] = Time + Votemap.Interval
	
	// Message
	
	SS.PlayerMessage(0, Player:Name().." has started a votemap!", 0)
end

// End map command

function Votemap.End(Winner, Number, Table)
	if (Winner == "" or Winner == " ") then SS.PlayerMessage(0, "Map Vote: Not enough votes for any map!", 0) return end
	
	// Amount needed
	
	local Enough, Amount = SS.Lib.VotesNeeded(Number)
	
	// Enough
	
	if (Enough) then
		// Message
		
		SS.PlayerMessage(0, "Votemap: Changing map to "..Winner.." in "..Votemap.Time.." seconds!", 0)
		
		// Timer
		
		timer.Create("SS.Votemap", Votemap.Time, 1, game.ConsoleCommand, "changelevel "..Winner.."\n")
	else
		SS.PlayerMessage(0, "Votemap: Not enough votes for "..Winner..", "..Number.."/"..Amount.."!", 0)
	end
end

// Create

Votemap:Create(Votemap.Command, {"Basic"}, "Start a votemap", "<Map>, <Map>, <Map>", 1, ", ")