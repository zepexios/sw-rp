// Radar

local Plugin = SS.Plugins:New("Radar")

// Chat command

local Command = SS.ChatCommands:New("Radar")

function Command.Command(Player, Args)
	local TR = util.GetPlayerTrace(Player)
	
	local Trace = util.TraceLine(TR)
	
	if not (Trace.Entity) then
		SS.PlayerMessage(Player, "You must aim at a valid entity!", 1)
		
		return
	end
	
	local ID = table.concat(Args, " ")
	
	SS.PlayerMessage(Player, "Entity has been added to radar!", 0)
	
	Player:ConCommand('serversecure_radarentity "'..ID..'"\n')
end

Command:Create(Command.Command, {"Basic"}, "Add an entity to your radar", "<Name>", 1, " ")

// Advert

SS.Adverts.Add("To see the radar type serversecure_showradar 1!")

// Create

Plugin:Create()