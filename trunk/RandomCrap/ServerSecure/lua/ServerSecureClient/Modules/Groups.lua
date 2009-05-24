// Groups

SS.Groups      = {}
SS.Groups.List = {}

// Rank by index

function SS.Groups.GetGroupRank(ID)
	local Return = 0
	
	// Check if it exists
	
	if (SS.Groups.List[ID]) then
		Return = SS.Groups.List[ID][3]
	end
	
	// Return
	
	return Return
end

// Symbol by index

function SS.Groups.GetGroupSymbol(ID)
	// Check if it exists
	
	if (SS.Groups.List[ID]) then
		Return = SS.Groups.List[ID][4]
	end
	
	// Return empty string
	
	return ""
end

// Setup group

function SS.Groups.Setup(Message)
	local ID     = Message:ReadString()
	local Symbol = Message:ReadString()
	local Index  = Message:ReadShort()
	local R      = Message:ReadShort()
	local G      = Message:ReadShort()
	local B      = Message:ReadShort()
	local A      = Message:ReadShort()
	local Rank   = Message:ReadShort()
	
	// Color
	
	local Col = Color(R, G, B, A)
	
	// Team
	
	team.SetUp(Index, ID, Col)
	
	// Insert
	
	SS.Groups.List[Index] = {ID, Col, Rank, Symbol}
end

usermessage.Hook("SS.Groups.Setup", SS.Groups.Setup)