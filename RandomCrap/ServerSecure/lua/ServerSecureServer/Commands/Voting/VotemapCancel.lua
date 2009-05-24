// Votemap cancel

local VotemapCancel = SS.ChatCommands:New("VotemapCancel")

// Branch flag

SS.Flags.Branch("Administrator", "VotemapCancel")

// Votemap cancel command

function VotemapCancel.Command(Player, Args)
	local Exists = timer.IsTimer("SS.Votemap")
	
	// Check exists
	
	if (Exists) then
		timer.Destroy("SS.Votemap")
		
		// Message
		
		SS.PlayerMessage(0, Player:Name().." has cancelled the map change!", 0)
	else
		SS.PlayerMessage(Player, "There is no votemap currently active!", 1)
	end
end

// Create

VotemapCancel:Create(VotemapCancel.Command, {"Administrator", "VotemapCancel"}, "Cancel a votemap")