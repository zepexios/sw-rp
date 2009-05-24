// Config

SS.Config = {}

// Request config

function SS.Config.Request(ID, Type, Replacement)
	local Request = GetGlobalString("ServerSecure: "..ID)
	
	// Lower the string
	
	local Lower = string.lower(Request)
	
	// Boolean
	
	if (Lower == "false") then Request = false end
	if (Lower == "true") then Request = true end
	
	// Number
	
	local Number = tonumber(Request)
	
	// Convert it to a number
	
	if (Number) then Request = Number end
	
	// Return
	
	if (Type) then
		if (string.lower(type(Request)) != string.lower(Type)) then
			return Replacement
		end
	end
	
	// Return the request
	
	return Request
end