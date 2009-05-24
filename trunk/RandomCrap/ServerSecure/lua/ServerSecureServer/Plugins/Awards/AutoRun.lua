// Awards

SS.Awards = SS.Plugins:New("Awards")

// Awards

SS.Awards.List = {}

// Add

function SS.Awards.Add(ID)
	SS.Awards.List[ID] = {ID, ""}
end

// Include

include("Config.lua")

// When players values get set

function SS.Awards.PlayerSetVariables(Player)
	CVAR.New(Player, "Awards", {})
end

// Award

function SS.Awards.Award(Player, ID, Award, Type)
	local Person, Error = SS.Lib.Find(ID)
	
	if (Person) then
		for K, V in pairs(SS.Awards.List) do
			if (Award == V[1]) then
				local Index = V[1]
				
				// Type
				
				if (Type == 1) then
					CVAR.Request(Person, "Awards")[Index] = CVAR.Request(Person, "Awards")[Index] or 0
					
					// CVAR
					
					CVAR.Request(Person, "Awards")[Index] = CVAR.Request(Person, "Awards")[Index] + 1
					
					// Message
					
					SS.PlayerMessage(0, Player:Name().." has given "..Person:Name().." the "..V[1].." award!", 0)
				elseif (Type == 0) then
					if not (CVAR.Request(Person, "Awards")[Index]) then
						SS.PlayerMessage(Player, Person:Name().." doesn't have the "..V[1].." award!", 1)
					else
						CVAR.Request(Person, "Awards")[Index] = CVAR.Request(Person, "Awards")[Index] - 1
						
						// CVAR
						
						if (CVAR.Request(Person, "Awards")[Index] <= 0) then
							CVAR.Request(Person, "Awards")[Index] = nil
						end
						
						// Message
						
						SS.PlayerMessage(0, Player:Name().." has taken one of "..Person:Name().."'s "..V[1].." awards!", 0)
					end
				end
				
				// Update GUI
				
				SS.Player.PlayerUpdateGUI(Person)
			end
		end
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

// Branch flag

SS.Flags.Branch("Administrator", "GiveAward")

// Chat command

local GiveAward = SS.ChatCommands:New("GiveAward")

function GiveAward.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	if (Person) then
		local ID = Person:Name()
		
		// Panel
		
		local Panel = SS.Panel:New(Player, "Give Award: "..ID)
		
		// Loop
		
		for K, V in pairs(SS.Awards.List) do
			Panel:Button(V[1], {SS.Awards.Award, Args[1], V[1], 1})
		end
		
		// Send
		
		Panel:Send()
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

GiveAward:Create(GiveAward.Command, {"Administrator", "GiveAward"}, "Give an award to somebody", "<Player>", 1, " ")

// Branch flag

SS.Flags.Branch("Administrator", "TakeAward")

// Chat command

local TakeAward = SS.ChatCommands:New("TakeAward")

function TakeAward.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	if (Person) then
		local ID = Person:Name()
		
		// Found
		
		local Found = false
		
		// Panel
		
		local Panel = SS.Panel:New(Player, "Take Award: "..ID)
		
		// Loop
		
		for K, V in pairs(CVAR.Request(Person, "Awards")) do
			local Award = K
			
			// Button
			
			Panel:Button(Award, {SS.Awards.Award, Args[1], Award, 0})
			
			// Found
			
			Found = true
		end
		
		// Found
		
		if not (Found) then
			Panel:Words("This player does not have any awards!")
		end
		
		// Send
		
		Panel:Send()
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

TakeAward:Create(TakeAward.Command, {"Administrator", "TakeAward"}, "Take an award from somebody", "<Player>", 1, " ")

// Create

SS.Awards:Create()