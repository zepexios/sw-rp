// Points enabled

if (!SS.Config.Request("Points Enabled")) then return end

// Lottery

SS.Lottery = SS.Plugins:New("Lottery")

// Variables

SS.Lottery.Active = false

// Config

include("Config.lua")

// Function

function SS.Lottery.Timer()
	if (SS.Lottery.Ticket > 0) then
		SS.PlayerMessage(0, "Lottery has begun! Type "..SS.ChatCommands.Prefix().."lottery <0-9> <0-9> <0-9> ("..SS.Lottery.Ticket.." "..SS.Config.Request("Points Name")..")!", 0)
	else
		SS.PlayerMessage(0, "Lottery has begun! Type "..SS.ChatCommands.Prefix().."lottery <0-9> <0-9> <0-9>!", 0)
	end
	
	// Active
	
	SS.Lottery.Active = true
	
	// Timer
	
	timer.Simple(SS.Lottery.Time / 10, SS.Lottery.Winner)
end

timer.Create("SS.Lottery", SS.Lottery.Time, 0, SS.Lottery.Timer)

// Winner

function SS.Lottery.Winner()
	local Numbers = {}
	local Winners = {}
	
	//  Random
	
	for I = 1, 3 do
		Numbers[I] = math.random(9)
	end
	
	// Different
	
	while (Numbers[1] == Numbers[2] or Numbers[2] == Numbers[3] or Numbers[3] == Numbers[1]) do
		Numbers[1] = math.random(9)
		Numbers[2] = math.random(9)
		Numbers[3] = math.random(9)
	end
	
	// Players
	
	local Players = player.GetAll()
	
	// Loop
	
	for K, V in pairs(Players) do
		local Picked = TVAR.Request(V, "Lottery")
		
		// Picked
		
		if (Picked) then
			local Count = 0
			
			// Loop
			
			for I = 1, 3 do
				if (Picked[I] == Numbers[I]) then
					Count = Count + 1
				end
			end
			
			// Count
			
			if (Count > 0 and Count < 3) then
				SS.PlayerMessage(V, "You didn't win the lottery, but you got "..Count.."/3 numbers correct!", 0)
			elseif (Count == 3) then
				SS.PlayerMessage(V, "You have won the lottery! You win "..SS.Lottery.Prize.." "..SS.Config.Request("Points Name").."!", 0)
				
				// Player gain points
				
				SS.Points.PlayerGain(V, SS.Lottery.Prize)
				
				// Winners
				
				Winners[V] = V
			end
			
			// Update
			
			TVAR.Update(V, "Lottery", nil)
		end
	end
	
	// Winner
	
	local Winning = table.concat(Numbers, ", ")
	
	// Count table
	
	if (table.Count(Winners) == 0) then
		SS.PlayerMessage(0, "The lottery is over and nobody has won, the winning numbers were "..Winning.."!", 0)
	else
		local Names = {}
		
		// Loop
		
		for K, V in pairs(Winners) do
			local ID = V:Name()
			
			// Insert
			
			table.insert(Names, ID)
		end
		
		// Names
		
		Names = table.concat(Names, ", ")
		
		// Message
		
		SS.PlayerMessage(0, "The lottery is over, winners: "..Names, 0)
	end
	
	// Active
	
	SS.Lottery.Active = false
end

// Chat command

local Command = SS.ChatCommands:New("Lottery")

function Command.Command(Player, Args)
	if (TVAR.Request(Player, "Lottery")) then
		SS.PlayerMessage(Player, "You have already bought a lottery ticket!", 1)
		
		return
	end
	
	// Ticket
	
	if (SS.Lottery.Ticket > 0) then
		if (CVAR.Request(Player, "Points") < SS.Lottery.Ticket) then
			SS.PlayerMessage(Player, "You do not have enough for a lottery ticket, 1 ticket is "..SS.Lottery.Ticket.." "..SS.Config.Request("Points Name").."!", 1)
			
			return
		else
			CVAR.Update(Player, "Points", CVAR.Request(Player, "Points") - SS.Lottery.Ticket)
		end
	end
	
	if not (SS.Lottery.Active) then SS.PlayerMessage(Player, "The lottery is not currently on!", 1) return end
	
	// Floor
	
	for I = 1, 3 do
		Args[I] = math.floor(Args[I])
	end
	
	// Check
	
	for I = 1, 3 do
		for P = 1, 3 do
			if (I != P) then
				if (Args[I] == Args[P]) then
					SS.PlayerMessage(Player, "Two of your lottery numbers are the same, please make them unique!", 1)
					
					return
				end
			end
		end
	end
	
	// Check
	
	for I = 1, 3 do
		if (Args[I] > 9 or Args[I] < 0) then SS.PlayerMessage(Player, "The lottery numbers must be between 0 and 9!", 1) return end
	end
	
	// Stuff
	
	TVAR.New(Player, "Lottery", {})
	
	TVAR.Update(Player, "Lottery", {Args[1], Args[2], Args[3]})
	
	SS.PlayerMessage(0, Player:Name().." entered the lottery with "..table.concat(Args, ", ").."!", 0)
end

Command:Create(Command.Command, {"Basic"}, "Enter the lottery with 3 numbers between 0 and 9", "<0-9> <0-9> <0-9>", 3, " ")

// Create

SS.Lottery:Create()