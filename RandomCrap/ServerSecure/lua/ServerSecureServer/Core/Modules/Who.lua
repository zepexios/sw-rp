// Who

SS.Who      = {} // Who table
SS.Who.List = {} // Who list

// New who module

function SS.Who.Module(Index, Function)
	SS.Who.List[Index] = Function
end

// Driving

function SS.Who.Driving(Player)
	if (Player:InVehicle()) then
		return true
	end
	
	// Return false
	
	return false
end

SS.Who.Module("Driving", SS.Who.Driving)

// Swimming

function SS.Who.Swimming(Player)
	if (Player:WaterLevel() > 2) then
		return true
	end
	
	// Return false
	
	return false
end

SS.Who.Module("Swimming", SS.Who.Swimming)