// Chat commands

SS.ChatCommands      = {} // Main chat table
SS.ChatCommands.List = {} // Where commands are stored

// Find a command

function SS.ChatCommands.Find(Index)
	Index = string.lower(Index)
	
	// Loop
	
	for K, V in pairs(SS.ChatCommands.List) do
		if (string.lower(V.Command) == Index) then
			return V
		end
	end
	
	// Return false
	
	return false
end

// Create a new chat command

function SS.ChatCommands:New(Index)
	local Table = {}
	
	// Meta table
	
	setmetatable(Table, self)
	
	self.__index = self
	
	// Name
	
	Table.Name = Index
	
	// Return the table
	
	return Table
end

// Create chat command

function SS.ChatCommands:Create(Function, Restrict, Help, Syntax, Args, Seperator)
	if (Syntax == "") then Syntax = "<None Specified>" end
	
	// Add it to the list
	
	SS.ChatCommands.Add(self.Name, Function, Help, Restrict, Syntax, Args, Seperator)
end

// When a player says something

function SS.ChatCommands.Say(Player, Text)
	SS.Hooks.Run("PlayerTypeText", Player, Text)
	
	// Command args
	
	local Command = ""
	local Args    = ""
	
	// Check if the prefix is the chat commands prefix
	
	if (string.sub(Text, 1, string.len(SS.Config.Request("Chat Commands Prefix"))) == SS.Config.Request("Chat Commands Prefix")) then
		local Find = string.Explode(" ", Text)
		
		// Find
		
		Find[1] = string.sub(Find[1], 2, string.len(Find[1]) + 1)
		
		// Loop
		
		for K, V in pairs(SS.ChatCommands.List) do
			if (string.lower(Find[1]) == string.lower(V.Command)) then
				Command = V.Command
				
				// Args
				
				if (Find[2]) then
					Args = table.concat(Find, " ", 2)
					
					// Check
					
					if (Args) then Args = string.Trim(Args) end
				end
			end
		end
		
		// Command
		
		if (Command == "") then
			SS.PlayerMessage(Player, 'There is no such command: "'..Find[1]..'"!', 1)
			
			// Return empty string
			
			return ""
		end
	end
	
	// Check if command is not nothing
	
	if (Command != "") then
		// Check if player is allowed
		
		local Allowed = SS.Allow.PlayerGetAllowed(Player, "Commands")
		
		// Allowed
		
		if (Allowed) then
			if (SS.ChatCommands.List[Command].Function) then
				if (SS.Flags.PlayerHas(Player, SS.ChatCommands.List[Command].Restrict)) then
					local Arguments = {}
					
					// Args
					
					if (Args != "") then
						Arguments = string.Explode(SS.ChatCommands.List[Command].Seperator, Args)
						
						// Loop
						
						for K, V in pairs(Arguments) do
							Arguments[K] = string.Trim(V)
							Arguments[K] = SS.Lib.StringValue(Arguments[K])
						end
					end
					
					// Count arguments
					
					if (table.Count(Arguments) < SS.ChatCommands.List[Command].Args) then
						Player:PrintMessage(3, "Syntax: "..SS.ChatCommands.List[Command].Syntax)
						
						return ""
					end
					
					// Run hook
					
					SS.Hooks.Run("PlayerTypedCommand", Player, Command, Arguments)
					
					// PCall the function
					
					local B, Retval = pcall(SS.ChatCommands.List[Command].Function, Player, Arguments)
					
					// Error
					
					if not (B) then
						SS.Lib.Error("Chat Command Error: "..tostring(Retval).."!")
					end
					
					// Return nothing
					
					return ""
				else
					local Access = {}
					
					// Loop
					
					for K, V in pairs(SS.ChatCommands.List[Command].Restrict) do
						if not (SS.Flags.PlayerHas(Player, V)) then
							table.insert(Access, V)
						end
					end
					
					// Access
					
					Access = table.concat(Access, " or ")
					
					// Message
					
					SS.PlayerMessage(Player, "You do not have access, you need "..Access.." flags!", 1)
				end
			end
		end
		
		// Return empty string
		
		return ""
	end

	// Run hook
	
	SS.Hooks.Run("PlayerTypedText", Player, Text)
	
	// Get text return value
	
	local Return = Player:GetTextReturn()
	
	if (Return) then
		Return = Return[1]
		
		// TVAR
		
		TVAR.Update(Player, "TextReturnValue", nil)
		
		// Return
		
		return Return
	end
	
	// Is player allowed
	
	local Allowed = SS.Allow.PlayerGetAllowed(Player, "Chat")
	
	// Allowed
	
	if not (Allowed) then return "" end
end

hook.Add("PlayerSay", "SS.ChatCommands.Say", SS.ChatCommands.Say)

// Add a new command

function SS.ChatCommands.Add(Command, Function, Help, Restrict, Syntax, Args, Seperator)
	SS.ChatCommands.List[Command]           = {}
	SS.ChatCommands.List[Command].Command   = Command
	SS.ChatCommands.List[Command].Function  = Function
	SS.ChatCommands.List[Command].Restrict  = Restrict  or {"Basic"}
	SS.ChatCommands.List[Command].Help      = Help      or "<None Specified>"
	SS.ChatCommands.List[Command].Syntax    = Syntax    or "<None Specified>"
	SS.ChatCommands.List[Command].Seperator = Seperator or " "
	SS.ChatCommands.List[Command].Args      = Args 		or 0
	
	// Add the console command
	
	SS.ConsoleCommands.Add(Command, Function, Restrict, Syntax, Args, Seperator)
end

// Get commands prefix

function SS.ChatCommands.Prefix()
	return SS.Config.Request("Chat Commands Prefix")
end