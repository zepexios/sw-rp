// Votestart

local Votestart = SS.ChatCommands:New("Votestart")

// Branch flag

SS.Flags.Branch("Administrator", "Votestart")

// Start vote command

function Votestart.Command(Player, Args)
	local Panel = SS.Voting:New("Vote", Args[1], true)
	
	if not (Panel) then SS.PlayerMessage(Player, "There is already a vote active!", 1) return end
	
	// Remove
	
	table.remove(Args, 1)
	
	// Loop
	
	for K, V in pairs(Args) do
		Panel:Words(V)
	end
	
	// Send
	
	Panel:Send(30)
	
	// Message
	
	SS.PlayerMessage(0, Player:Name().." has started a vote!", 0)
end

// Create

Votestart:Create(Votestart.Command, {"Moderator", "Votestart"}, "Start a vote", "<Title>, <Option>", 2, ", ")