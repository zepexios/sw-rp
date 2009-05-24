// Client

SS.Parts.Add("AFK", "Name")

// Locals

local User = LocalPlayer()

// AFK

SS.AFK = {}

// Usermessage

function SS.AFK.Usermessage(Message)
	local Bool = Message:ReadBool()
	
	if (Bool) then
		// Alpha
		
		local Alpha = 255
		
		// Vehicle
		
		if (User:InVehicle()) then
			Alpha = 50
		end
		
		// Start notice
		
		SS.Notice.New("AFK", "You are currently AFK!", Color(255, 60, 60, Alpha), Color(0, 0, 0, Alpha))
		
		// Content
		
		SS.Notice.Content("Move to become active again", Color(255, 255, 255, Alpha))
		
		// Finish notice
		
		SS.Notice.Finish()
	else
		SS.Notice.Hide("AFK")
	end
end

usermessage.Hook("SS.AFK", SS.AFK.Usermessage)