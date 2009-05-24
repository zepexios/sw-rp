// Voting

SS.Voting       = {} -- Voting
SS.Voting.Votes = {} -- Where votes are stored

// Start vote

function SS.Voting:New(ID, Title, Message)
	if (SS.Voting.Votes[ID]) then return false end
	
	// Table
	
	local Table = {}
	
	// Meta table
	
	setmetatable(Table, self)
	
	self.__index = self
	
	// Variables
	
	Table.ID = tostring(ID)
	Table.Title = Title
	Table.Message = Message
	Table.Votes = {}
	Table.Options = {}
	
	// Table
	
	return Table
end

// Add option

function SS.Voting:Words(Option)
	table.insert(self.Options, {Option, 0})
end

// Send

function SS.Voting:Send(Time, Callback)
	self.Time = Time
	
	// Function
	
	self.Function = Callback or function() end
	
	// Insert it
	
	SS.Voting.Votes[self.ID] = self
	
	// Timer
	
	timer.Create("SS.Voting.Finish: "..self.ID, self.Time, 1, SS.Voting.Finish, self.ID)
	
	// Players
	
	local Players = player.GetAll()
	
	// Loop
	
	for K, V in pairs(Players) do
		local Panel = SS.Panel:New(V, self.Title)
		
		// Options
		
		for B, J in pairs(self.Options) do
			Panel:Button(J[1], 'ss voteregister '..self.ID..', '..B..'')
		end
		
		// Send
		
		Panel:Send()
	end
end

// Vote

function SS.Voting.Register(Player, Args)
	local Vote = Args[1]
	
	// Check
	
	if not (SS.Voting.Votes[Vote]) then SS.PlayerMessage(Player, "There is no vote with that key active!", 1) return end
	
	// Loop
	
	for K, V in pairs(SS.Voting.Votes[Vote].Votes) do
		if (V[1] == Player) then
			SS.PlayerMessage(Player, "You have already voted!", 1)
			
			return
		end
	end
	
	// Key
	
	local Key = tonumber(Args[2])
	
	// Check key
	
	if not (Key) then SS.PlayerMessage(Player, "Please enter a valid voting key!", 1) return end
	
	// Check valid option
	
	if not (SS.Voting.Votes[Vote].Options[Key]) then SS.PlayerMessage(Player, "That is not a valid option!", 1) return end
	
	// Increase votes
	
	SS.Voting.Votes[Vote].Options[Key][2] = SS.Voting.Votes[Vote].Options[Key][2] + 1
	
	// Message
	
	SS.PlayerMessage(0, Player:Name().." voted for "..SS.Voting.Votes[Vote].Options[Key][1].."!", 0)
	
	// Insert
	
	table.insert(SS.Voting.Votes[Vote].Votes, {Player, Key, SS.Voting.Votes[Vote].Options[Key][1]})
end

SS.ConsoleCommands.Simple("voteregister", SS.Voting.Register, 2, ", ")

// Finish

function SS.Voting.Finish(ID)
	local Cur = 0
	local Winner = ""
	
	// Loop
	
	for K, V in pairs(SS.Voting.Votes[ID].Options) do
		if (V[2] > Cur) then
			Cur = V[2]
			
			// Winner
			
			Winner = V[1]
		end
	end
	
	// Message
	
	if (SS.Voting.Votes[ID].Message) then
		if (Winner == "") then
			SS.PlayerMessage(0, "Vote '"..SS.Voting.Votes[ID].Title.."': No winner!", 0)
		else
			SS.PlayerMessage(0, "Vote '"..SS.Voting.Votes[ID].Title.."': The winner was "..Winner.."!", 0)
		end
	end
	
	// Run hook
	
	SS.Hooks.Run("ServerVoteFinished", ID, Winner, Cur)
	
	// Function
	
	SS.Voting.Votes[ID].Function(Winner, Cur, SS.Voting.Votes[ID].Votes)
	
	// Nil it
	
	SS.Voting.Votes[ID] = nil
end
