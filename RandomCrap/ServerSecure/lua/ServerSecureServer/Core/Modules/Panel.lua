// Panel

SS.Panel           = {}
SS.Panel.Functions = {} // Functions list

// Function

function SS.Panel.Function(Player, Args)
	Args[1] = string.Replace(Args[1], " : ", ":")
	
	// Loop
	
	for K, V in pairs(SS.Panel.Functions) do
		if (K == Args[1]) then
			table.remove(Args, 1)
			
			// Loop
			
			for B, J in pairs(Args) do
				Args[B] = SS.Lib.StringValue(Args[B])
			end
			
			// Check it exists
			
			if (V) then
				V(Player, unpack(Args))
			end
			
			// Return
			
			return
		end
	end
end

SS.ConsoleCommands.Simple("panelcommand", SS.Panel.Function, 1, ", ")

// Start panel

function SS.Panel:New(Player, Title)
	local Table = {}
	
	// Meta table
	
	setmetatable(Table, self)
	
	self.__index  = self
	
	// Variables
	
	Table.Text    = {}
	Table.Buttons = {}
	Table.ID      = ID
	Table.Title   = Title
	Table.Player  = Player
	
	// Return
	
	return Table
end

// Add text

function SS.Panel:Words(Text, R, G, B)
	R = R or 255
	G = G or 255
	B = B or 255
	
	// Length
	
	if (string.len(Text) > 100) then
		local One = string.sub(Text, 0, 99)
		local Two = string.sub(Text, 100)
		
		// New
		
		self:Words(One, R, G, B)
		self:Words(Two, R, G, B)
	else
		table.insert(self.Text, {Button = false, Text = Text, R = R, G = G, B = B})
	end
end

// Add button

function SS.Panel:Button(Text, Command, R, G, B, Bool)
	local Type = type(Command)
	
	// Table
	
	if (Type == "table") then
		local Function = tostring(Command[1])
		
		// Functions
		
		SS.Panel.Functions[Function] = Command[1]
		
		// Loop
		
		for K, V in pairs(Command) do
			Command[K] = tostring(V)
		end
		
		// Args
		
		local Args = table.concat(Command, ", ")
		
		// Format
		
		Args = string.format("%q", Args)
		
		// Command
		
		Command = 'ss panelcommand '..Args
	end
	
	// Colors
	
	R = R or 125
	G = G or 125
	B = B or 125
	
	// Bool
	
	Bool = Bool or true
	
	// Insert
	
	table.insert(self.Text, {Button = true, Text = Text, Command = Command, R = R, G = G, B = B, Bool = Bool})
end

// Send

function SS.Panel:Send()
	if (self.Player:GetName() == "Console") then
		self.Player:ChatPrint("\n[Menu] "..self.Title.."\n")
		
		// Loop
		
		for K, V in pairs(self.Text) do
			if (V.Button) then
				self.Player:ChatPrint("[Button] "..V.Text)
				self.Player:ChatPrint("\t[Command] "..V.Command)
			else
				self.Player:ChatPrint("[Text] "..V.Text)
			end
		end
		
		// Print
		
		self.Player:ChatPrint("\n")
		
		// Return
		
		return
	end
	
	// Create
	
	umsg.Start("Panel.Create", self.Player)
		umsg.String(self.Title)
	umsg.End()
	
	// Text
	
	for K, V in pairs(self.Text) do
		if (V.Button) then
			umsg.Start("Panel.Button", self.Player)
				umsg.String(V.Text)
				umsg.String(V.Command)
				umsg.Short(V.R)
				umsg.Short(V.G)
				umsg.Short(V.B)
				umsg.Bool(V.Bool)
			umsg.End()
		else
			umsg.Start("Panel.Words", self.Player)
				umsg.String(V.Text)
				umsg.Short(V.R)
				umsg.Short(V.G)
				umsg.Short(V.B)
			umsg.End()
		end
	end
	
	// Finish
	
	umsg.Start("Panel.Finish", self.Player)
		umsg.Short(1)
	umsg.End()
end