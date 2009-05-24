// Group

local Group = SS.ChatCommands:New("Group")

// Branch flag

SS.Flags.Branch("Server", "Group")

// Group command

function Group.Command(Player, Args)
	local ID = Args[1]
	
	// Level
	
	local Level = table.concat(Args, " ", 2)
	
	// Group
	
	local Group = ""
	
	// Found
	
	local Found = false
	
	// Loop
	
	for K, V in pairs(SS.Groups.List) do
		if (string.lower(Level) == string.lower(V[1])) then
			Group = V[1]
			
			// Found
			
			Found = true
		end
	end
	
	// Not found the group
	
	if not (Found) then
		SS.PlayerMessage(Player, "No such group: '"..Level.."'!", 1)
		
		// Return
		
		return
	end
	
	// Check ranks
	
	if (SS.Groups.GetGroupRank(Level) < SS.Groups.GetGroupRank(SS.Player.Rank(Player))) then
		SS.PlayerMessage(Player, "You cannot change this person's group, because it is ranked higher than yours!", 1)
		
		// Return
		
		return
	end
	
	// Person and error
	
	local Person, Error = SS.Lib.Find(ID)
	
	// Person
	
	if (Person) then
		if (Person == Player) then SS.PlayerMessage(Player, "Cannot change your own group!", 1) return end
		
		// Message
		
		SS.PlayerMessage(0, Person:Name().."'s group has been changed to "..Group, 0)
		
		// Change
		
		SS.Groups.Change(Person, Group)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

Group:Create(Group.Command, {"Group", "Server"}, "Change somebodies group", "<Player> <Group>", 2, " ")