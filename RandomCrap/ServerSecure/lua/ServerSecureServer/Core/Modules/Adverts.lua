// Adverts

SS.Adverts = {} //Adverts table
SS.Adverts.List = {} // Adverts list

// Add advert

function SS.Adverts.Add(Text)
	table.insert(SS.Adverts.List, Text)
end

// Run adverts

function SS.Adverts.ServerMinute()
	if not (SS.Config.Request("Adverts Enabled")) then return end
	
	// Debug
	
	SS.Lib.Debug("Now showing all players a random advert!")
	
	// Check count
	
	if (table.Count(SS.Adverts.List) != 0) then
		if (SS.Config.Request("Enable Bar")) then
			SS.ServerTicker(0, SS.Config.Request("Adverts Prefix").." "..SS.Lib.RandomTableEntry(SS.Adverts.List), 10)
		else
			SS.PlayerMessage(0, SS.Lib.RandomTableEntry(SS.Adverts.List), 3)
		end
	end
end

// Hook into server minute

SS.Hooks.Add("SS.Adverts.ServerMinute", "ServerMinute", SS.Adverts.ServerMinute)