// Deselect

local Deselect = SS.ChatCommands:New("Deselect")

// Deselect command

function Deselect.Command(Player, Args)
	if not (TVAR.Request(Player, "Selected")) then
		SS.PlayerMessage(Player, "You have no entities selected!", 1)
		
		// Return
		
		return
	end
	
	// Number
	
	local Number = Player:DeselectEntities()
	
	// Message
	
	SS.PlayerMessage(Player, Number.." entities deselected!", 0)
end

Deselect:Create(Deselect.Command, {"Basic"}, "Deselect all selected entities")