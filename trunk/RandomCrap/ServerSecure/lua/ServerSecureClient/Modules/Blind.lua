// Blind

SS.Blind = {}

// Usermessage

function SS.Blind.Usermessage(Message)
	local Bool = Message:ReadBool()
	
	// Bool
	
	if (Bool) then
		// New notice
		
		SS.Notice.New("Blind", "You have been blinded!", Color(255, 60, 60, 255))
		
		// Finish notice
		
		SS.Notice.Finish()
	else
		SS.Notice.Hide("Blind")
	end
end

usermessage.Hook("SS.Blind", SS.Blind.Usermessage)