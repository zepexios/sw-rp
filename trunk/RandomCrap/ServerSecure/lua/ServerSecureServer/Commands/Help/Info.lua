// Info

local Info = SS.ChatCommands:New("Info")

// View table of info

function Info.Table(Player, Args)
	local Players = player.GetAll()
	
	// Unique
	
	local Unique = tostring(Args[1])
	
	// Person
	
	local Person = player.GetByUniqueID(Unique)
	
	// Person
	
	if (Person) then
		if (CVAR.Request(Person, Args[2])) then
			local Panel = SS.Panel:New(Player, Person:Name()..": "..Args[2])
			
			// Count the information
			
			local Count = table.Count(CVAR.Request(Person, Args[2]))
			
			// Count is not 0
			
			if (Count != 0) then
				for K, V in pairs(CVAR.Request(Person, Args[2])) do
					local Type = type(V)
					
					// Table
					
					if (Type != "table") then
						if (V == "") then V = "None" end
						
						// Text
						
						if (K == V) then
							Panel:Words(K)
						else
							Panel:Words(K..": "..tostring(V))
						end
					end
				end
			else
				Panel:Words(Person:Name().." has no CVARS in this category")
			end
			
			// Send
			
			Panel:Send()
		else
			SS.PlayerMessage(Player, "Couldn't find the information: '"..Args[2].."'!", 1)
		end
	else
		SS.PlayerMessage(Player, "Couldn't find any matches for '"..Args[1].."'!", 1)
	end
end

SS.ConsoleCommands.Simple("infocommand", Info.Table, 2, ", ")

// View command

function Info.Command(Player, Args)
	local Person, Error = SS.Lib.Find(Args[1])
	
	// Person
	
	if (Person) then
		local Panel = SS.Panel:New(Player, Person:Name())
		
		// Identity
		
		local Identity = Person:SteamID()
		
		// Table
		
		local Table = CVAR.Store[Identity]
		
		// Sort
		
		table.sort(Table, function(A, B) return (A < B) end)
		
		// Loop
		
		for K, V in pairs(Table) do
			local Type = type(V)
			
			// Table
			
			if (Type != "table") then
				local Text = K
				
				// Function
				
				if (CVAR.Functions[Text]) then
					Text = CVAR.Functions[Text]()
				end
				
				// V is none
				
				if (V == "") then V = "None" end
				
				// Text
				
				if (Text == V) then
					Panel:Words(Text)
				else
					Panel:Words(Text..": "..tostring(V))
				end
			end
		end
		
		// Loop
		
		for K, V in pairs(Table) do
			local Type = type(V)
			
			// Table
			
			if (Type == "table") then
				Panel:Button(K, 'ss infocommand '..Person:UniqueID()..', '..K..'')
			end
		end
		
		// Send
		
		Panel:Send()
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

Info:Create(Info.Command, {"Basic"}, "View information about a specific player", "<Player>", 1, " ")

// Advert

SS.Adverts.Add("Type "..SS.ChatCommands.Prefix().."info <Player> to view information about a specific player!")