// Report

local Report = SS.ChatCommands:New("Report")

// Report command

function Report.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Check
	
	if (Person) then
		table.remove(Args, 1)
		
		// File and reason
		
		local Reason = table.concat(Args, " ")
		local File = ""
		
		// Check it exists
		
		if (file.Exists("ServerSecure/Reports.txt")) then
			File = file.Read("ServerSecure/Reports.txt").."\n"
		end
		
		// Update file
		
		File = File.."[Report] "..Player:Name().." ("..Player:SteamID()..") reported "..Person:Name().." ("..Person:SteamID().."), Reason: '"..Reason.."'"
		
		// Write file
		
		file.Write("ServerSecure/Reports.txt", File)
		
		// Message
		
		SS.PlayerMessage(Player, Person:Name().." has been reported!", 0)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

// Create

Report:Create(Report.Command, {"Basic"}, "Report a specific person", "<Player> <Reason>", 2, " ")

// Advert

SS.Adverts.Add("Report someone by typing "..SS.ChatCommands.Prefix().."report <Name> <Reason>")