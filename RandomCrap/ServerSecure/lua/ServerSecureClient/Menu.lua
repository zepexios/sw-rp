local Version = 1.15

// Version

if (MM) then
	if (MM.Version and MM.Version > Version) then
		return
	end
	
	// Reset screen clicker
	
	gui.EnableScreenClicker = MM.Panel.Backup
end

// Locals

local User = LocalPlayer()

// Menu

MM               = {}
MM.Objects       = {}
MM.Objects.List  = {}
MM.Panel         = {}
MM.Panel.Current = {}
MM.Panel.Limit   = 6
MM.Panel.X       = 8
MM.Panel.Y       = 150
MM.Panel.Font    = "Verdana"

// Version

MM.Version = Version

// Add object

function MM.Objects.Register(ID, Table)
	MM.Objects.List[ID] = Table
end

// Text

local function DrawText(Table)
	MM.Panel.Text(Table.X, Table.Y + 5, Table.Text, Table.R, Table.G, Table.B)
end

MM.Objects.Register("Text", {OnDraw = DrawText})

// OnDraw Button

function OnDrawButton(Table)
	local Col = Color(Table.R, Table.G, Table.B, 255)
	
	// Check active
	
	if (Table.Active) then
		Col.r = math.Clamp(Col.r + 10, 0, 255)
		Col.g = math.Clamp(Col.r + 10, 0, 255)
		Col.b = math.Clamp(Col.r + 10, 0, 255)
	end
	
	// Draw
	
	MM.Panel.Box(Table.X, Table.Y, Table.W, Table.H, Col)
	MM.Panel.Text(Table.X + 6, Table.Y + 5, Table.Text, 255, 255, 255)
end

// OnMousePressed Button

function OnMousePressedButton(Table)
	if (gui.MouseX() > Table.X and gui.MouseX() < (Table.X + Table.W) and gui.MouseY() > Table.Y and gui.MouseY() < (Table.Y + Table.H)) then
		local Type = type(Table.Command)
		
		// Check type
		
		if (Type == "string") then
			MM.Panel.Hide()
			
			// Command
			
			LocalPlayer():ConCommand(Table.Command.."\n")
		else
			MM.Panel.Hide()
			
			// Command
			
			Table.Command()
		end
		
		// Sound
		
		surface.PlaySound("buttons/button24.wav")
		
		// Break
		
		return true
	end
end

// OnThink Button

function OnThinkButton(Table)
	if (gui.MouseX() > Table.X and gui.MouseX() < (Table.X + Table.W) and gui.MouseY() > Table.Y and gui.MouseY() < (Table.Y + Table.H)) then
		if not (Table.Active) then surface.PlaySound("common/talk.wav") end
		
		// Active
		
		Table.Active = true
	else
		Table.Active = false
	end
end

MM.Objects.Register("Button", {OnDraw = OnDrawButton, OnThink = OnThinkButton, OnMousePressed = OnMousePressedButton})

// OnMousePressed CheckBox

function OnMousePressedCheckBox(Table)
	if (gui.MouseX() > Table.X and gui.MouseX() < (Table.X + 8) and gui.MouseY() > (Table.Y + 4) and gui.MouseY() < (Table.Y + 12)) then
		local Type = type(Table.Command)
		
		// Toggle
		
		Table.Active = not Table.Active
		
		// Number
		
		local Number = 0
		
		if (Table.Active) then Number = 1 end
		
		// Check type
		
		if (Type == "string") then
			// Command
			
			LocalPlayer():ConCommand(Table.Command.." "..Number.."\n")
		else
			// Command
			
			Table.Command(Number)
		end
		
		// Sound
		
		surface.PlaySound("buttons/button24.wav")
	end
end

// Draw CheckBox

function OnDrawCheckBox(Table)
	MM.Panel.Box(Table.X, Table.Y, 8, 8, Color(200, 200, 200, 200), 0)
	MM.Panel.Text(Table.X + 15, Table.Y, Table.Text, Table.R, Table.G, Table.B)
	
	// Active
	
	if (Table.Active) then
		MM.Panel.Box(Table.X + 2, Table.Y + 6, 4, 4, Color(100, 255, 100, 225), 0)
	end
end

MM.Objects.Register("CheckBox", {OnDraw = OnDrawCheckBox, OnMousePressed = OnMousePressedCheckBox})

// OnMousePressed CheckBox

function OnMousePressedCheckBox(Table)
	if (gui.MouseX() > Table.X and gui.MouseX() < (Table.X + 8) and gui.MouseY() > (Table.Y + 4) and gui.MouseY() < (Table.Y + 12)) then
		local Type = type(Table.Command)
		
		// Toggle
		
		Table.Active = not Table.Active
		
		// Number
		
		local Number = 0
		
		if (Table.Active) then Number = 1 end
		
		// Check type
		
		if (Type == "string") then
			// Command
			
			LocalPlayer():ConCommand(Table.Command.." "..Number.."\n")
		else
			// Command
			
			Table.Command(Number)
		end
		
		// Sound
		
		surface.PlaySound("buttons/button24.wav")
	end
end

// OnThink Slider

function OnThinkSlider(Table)
	if (Table.Active) then
		// Position
		
		Table.Position = math.Clamp(gui.MouseX(), Table.X, Table.X + Table.W)
	end
end

// OnMousePressed Slider

function OnMousePressedSlider(Table)
	// Clamp
	
	local X = Table.Position
	
	// Check
	
	if (gui.MouseX() > X and gui.MouseX() < (X + 4) and gui.MouseY() > (Table.Y) and gui.MouseY() < (Table.Y + Table.H)) then
		Table.Active = true
		
		// Sound
		
		surface.PlaySound("buttons/button24.wav")
	end
end

// OnMouseReleased Slider

function OnMouseReleasedSlider(Table)
	if (Table.Active) then
		surface.PlaySound("buttons/button24.wav")
		
		// No longer active
		
		Table.Active = false
	end
end

// OnDraw Slider

function OnDrawSlider(Table)
	MM.Panel.Box(Table.X, Table.Y, Table.W, Table.H, Color(125, 125, 125, 255))
	
	// Check
	
	if (!Table.Position) then Table.Position = Table.X end
	
	// Value
	
	local Multiply = Table.Max / (Table.X + Table.W)
	
	Table.Value = math.floor(Table.Min + (Table.Position * Multiply))
	
	// Box
	
	local X = math.Clamp(Table.Position, Table.X, Table.X + (Table.W - 4))
	
	MM.Panel.Box(X, Table.Y, 4, Table.H, Color(50, 50, 50, 255), 0)
	
	// Text
	
	MM.Panel.Text(Table.X + 6, Table.Y + 5, Table.Text.." ("..Table.Value..")", 255, 255, 255)
end

MM.Objects.Register("Slider", {OnDraw = OnDrawSlider, OnMousePressed = OnMousePressedSlider, OnMouseReleased = OnMouseReleasedSlider, OnThink = OnThinkSlider})

// Font

surface.CreateFont("Verdana", 15, 600, true, false, "Verdana")

// Screen clicker

MM.Panel.Backup = gui.EnableScreenClicker

function gui.EnableScreenClicker(Bool)
	MM.Panel.Clicker = Bool
	
	// Backup
	
	MM.Panel.Backup(Bool)
end

// New

function MM.Panel:New(Title)
	MM.Panel.Current = {}
	
	// Table
	
	local Table = {}
	
	// Meta table
	
	setmetatable(Table, self)
	
	self.__index = self
	
	// Variables
	
	Table.Objects = {}
	Table.MoreObjects    = {}
	Table.Title   = Title
	Table.X       = MM.Panel.X
	Table.Y       = MM.Panel.Y
	Table.W       = 0
	Table.H       = 0
	
	// Closing
	
	Table.Closing = false
	
	// Close
	
	Table.Close           = {}
	Table.Close.Highlight = false
	Table.Close.Box       = {X = 0, Y = 0, W = 0, H = 0}
	
	// Active
	
	Table.Active = true
	
	// Return table
	
	return Table
end

// Create object

function MM.Panel:CreateObject(Table)
	Table.X, Table.Y, Table.W, Table.H = Table.X or 0, Table.Y or 0, Table.W or 0, Table.X or 0
	Table.R, Table.G, Table.B = Table.R or 255, Table.G or 255, Table.B or 255
	
	// Insert
	
	if (table.Count(self.Objects) > MM.Panel.Limit) and not (Table.Force) then
		table.insert(self.MoreObjects, Table)
	else
		table.insert(self.Objects, Table)
	end
end

// Create

function MM.Panel:Create()
	if (table.Count(self.MoreObjects) > 0) then
		local function More()
			local Panel = MM.Panel:New(self.Title)
			
			// More
			
			for K, V in pairs(self.MoreObjects) do
				if (V.Type) then
					Panel:CreateObject(V)
				end
			end
			
			// Previous
			
			local function Function()
				MM.Panel.Show(self)
			end
			
			Panel:CreateObject({Type = "Button", Text = "Previous", Command = Function, Force = true, R = 175, G = 175, B = 175})
			
			// Create
			
			Panel:Create()
		end
		
		// Next
		
		self:CreateObject({Type = "Button", Text = "Next", Command = More, Temp = true, Force = true, R = 175, G = 175, B = 175})
	end
	
	// Current
	
	MM.Panel.Current = self
	
	// Clicker
	
	gui.EnableScreenClicker(true)
end

// Show

function MM.Panel.Show(Table)
	local Panel = MM.Panel:New(Table.Title)
	
	// Loop
	
	for K, V in pairs(Table.Objects) do
		if (V.Type) then
			if not (V.Temp) then
				Panel:CreateObject(V)
			end
		end
	end
	
	// More
	
	Panel.MoreObjects = Table.MoreObjects
	
	// Create
	
	Panel:Create()
end

// Hide

function MM.Panel.Hide()
	MM.Panel.Current = {}
	
	// Hide
	
	gui.EnableScreenClicker(false)
end

// Draw

function MM.Panel.Box(X, Y, W, H, Colour, Rounded)
	Rounded = Rounded or 4
	
	// Rounded box
	
	draw.RoundedBox(Rounded, X, Y, W, H, Colour)
	
	// Return
	
	return {X = X, Y = Y, W = W, H = H}
end

// Text

function MM.Panel.Text(X, Y, Text, R, G, B, AX, AY)
	// Colour
	
	R = R or 255
	G = G or 255
	B = B or 255
	
	// Align
	
	AX = AX or 0
	AY = AY or 0
	
	// Draw
	
	draw.SimpleText(Text, MM.Panel.Font, X + 1, Y + 1, Color(0, 0, 0, 255), AX, AY)
	draw.SimpleText(Text, MM.Panel.Font, X, Y, Color(R, G, B, 255), AX, AY)
end

// Table

function MM.Panel.LargestText(Table)
	local Width = 0
	local Height = 1
	
	surface.SetFont(MM.Panel.Font)
	
	// X and Y
	
	local X, Y = surface.GetTextSize(Table.Title)
	
	if (X > Width) then
		Width = X
	end
	
	// Loop
	
	for K, V in pairs(Table.Objects) do
		if (V.Text) then
			local X, Y = surface.GetTextSize(V.Text)
			
			if (X > Width) then
				Width = X
			end
			
			Height = Height + 1
		end
	end
	
	// Height
	
	Height = 32 * Height
	
	// Return
	
	return Width, Height
end

// Draw

function MM.Panel.Draw()
	if (MM.Panel.Current.Active) then
		local Width, Height = MM.Panel.LargestText(MM.Panel.Current)
		
		// Adjust
		
		Width = Width + 64
		
		// W and H
		
		MM.Panel.Current.W = Width
		MM.Panel.Current.H = Height
		
		// Box
		
		MM.Panel.Box(MM.Panel.Current.X, MM.Panel.Current.Y, MM.Panel.Current.W, MM.Panel.Current.H, Color(25, 25, 25, 200))
		MM.Panel.Box(MM.Panel.Current.X + 4, MM.Panel.Current.Y + 4, MM.Panel.Current.W - 8, MM.Panel.Current.H - 8, Color(75, 75, 75, 100))
		
		local Colour = Color(100, 100, 100, 200)
		
		// Box and title
		
		MM.Panel.Box(MM.Panel.Current.X + 4, MM.Panel.Current.Y + 4, Width - 8, 24, Colour)
		MM.Panel.Text(MM.Panel.Current.X + 14, MM.Panel.Current.Y + 10, MM.Panel.Current.Title, 255, 255, 255)
		
		// Loop
		
		for B, J in pairs(MM.Panel.Current.Objects) do
			// X and Y
			
			MM.Panel.Current.Objects[B].X = MM.Panel.Current.X + 8
			MM.Panel.Current.Objects[B].Y = MM.Panel.Current.Y + (32 * B)
			MM.Panel.Current.Objects[B].W = Width - 16
			MM.Panel.Current.Objects[B].H = 24
			
			// Draw type
			
			if (MM.Objects.List[J.Type] and MM.Objects.List[J.Type].OnDraw) then
				if (MM.Panel.Current.Objects[B]) then
					MM.Objects.List[J.Type].OnDraw(MM.Panel.Current.Objects[B])
				end
			end
		end
		
		// Color
		
		Col = Color(255, 0, 0, 100)
		
		if (MM.Panel.Current.Close.Highlight) then
			Col = Color(255, 0, 0, 125)
		end
		
		// Close and text
		
		MM.Panel.Current.Close.Box = MM.Panel.Box((MM.Panel.Current.X + MM.Panel.Current.W) - 24, MM.Panel.Current.Y + 9, 15, 15, Col, 1)
		MM.Panel.Text(MM.Panel.Current.Close.Box.X + (15 / 2), MM.Panel.Current.Close.Box.Y + (15 / 2), "X", 255, 255, 255, 1, 1)
	end
end

hook.Add("HUDDrawScoreBoard", "MM.Panel.Draw", MM.Panel.Draw)

// Think

function MM.Panel.Think()
	if (MM.Panel.Current.Active) then
		if not (MM.Panel.Clicker) then
			gui.EnableScreenClicker(true)
		end
		
		// Close
		
		if (gui.MouseX() > MM.Panel.Current.Close.Box.X and gui.MouseX() < (MM.Panel.Current.Close.Box.X + MM.Panel.Current.Close.Box.W) and gui.MouseY() > MM.Panel.Current.Close.Box.Y and gui.MouseY() < (MM.Panel.Current.Close.Box.Y + MM.Panel.Current.Close.Box.H)) then
			if not (MM.Panel.Current.Close.Highlight) then
				surface.PlaySound("common/talk.wav")
			end
			
			// Highlight
			
			MM.Panel.Current.Close.Highlight = true
		else
			MM.Panel.Current.Close.Highlight = false
		end
		
		// Loop
		
		for B, J in pairs(MM.Panel.Current.Objects) do
			if (MM.Objects.List[J.Type] and MM.Objects.List[J.Type].OnThink) then
				if (MM.Panel.Current.Objects[B]) then
					MM.Objects.List[J.Type].OnThink(MM.Panel.Current.Objects[B])
				end
			end
		end
	end
end

hook.Add("Think", "MM.Panel.Think", MM.Panel.Think)

// Mouse pressed

function MM.Panel.MousePressed(Key)
	if (Key == MOUSE_LEFT) then
		if (MM.Panel.Current.Active) then
			if (gui.MouseX() > MM.Panel.Current.Close.Box.X and gui.MouseX() < (MM.Panel.Current.Close.Box.X + MM.Panel.Current.Close.Box.W)) and (gui.MouseY() > MM.Panel.Current.Close.Box.Y) and (gui.MouseY() < (MM.Panel.Current.Close.Box.Y + MM.Panel.Current.Close.Box.H)) then
				MM.Panel.Hide()
				
				// Sound
				
				surface.PlaySound("buttons/button24.wav")
				
				// Return
				
				return false
			end
			
			// Loop
			
			for B, J in pairs(MM.Panel.Current.Objects) do
				if (MM.Objects.List[J.Type] and MM.Objects.List[J.Type].OnMousePressed) then
					if (MM.Panel.Current.Objects[B]) then
						local Return = MM.Objects.List[J.Type].OnMousePressed(MM.Panel.Current.Objects[B])
						
						// Break
						
						if (Return) then break end
					end
				end
			end
		end
	end
end

hook.Add("GUIMousePressed", "MM.Panel.MousePressed", MM.Panel.MousePressed)

// Mouse released

function MM.Panel.MouseReleased(Key)
	if (Key == MOUSE_LEFT) then
		if (MM.Panel.Current.Active) then
			for B, J in pairs(MM.Panel.Current.Objects) do
				if (MM.Objects.List[J.Type] and MM.Objects.List[J.Type].OnMouseReleased) then
					if (MM.Panel.Current.Objects[B]) then
						local Return = MM.Objects.List[J.Type].OnMouseReleased(MM.Panel.Current.Objects[B])
						
						// Break
						
						if (Return) then break end
					end
				end
			end
		end
	end
end

hook.Add("GUIMouseReleased", "MM.Panel.MouseReleased", MM.Panel.MouseReleased)

// Hooks

MM.Panel.Building = {}
MM.Panel.Hooks = {}

// Start

function MM.Panel.Hooks.Start(Message)
	local Title = Message:ReadString()
	
	// Start it
	
	MM.Panel.Building = MM.Panel:New(Title)
end

usermessage.Hook("Panel.Create", MM.Panel.Hooks.Start)

// Button

function MM.Panel.Hooks.Button(Message)
	local Text    = Message:ReadString()
	local Command = Message:ReadString()
	local R       = Message:ReadShort()
	local G       = Message:ReadShort()
	local B       = Message:ReadShort()
	
	// Insert
	
	MM.Panel.Building:CreateObject({Type = "Button", Text = Text, Command = Command, R = R, G = G, B = B, Active = false})
end

usermessage.Hook("Panel.Button", MM.Panel.Hooks.Button)

// CheckBox

function MM.Panel.Hooks.CheckBox(Message)
	local Text    = Message:ReadString()
	local Command = Message:ReadString()
	
	// Insert
	
	MM.Panel.Building:CreateObject({Type = "CheckBox", Text = Text, Command = Command, Active = false})
end

usermessage.Hook("Panel.CheckBox", MM.Panel.Hooks.CheckBox)

// Text

function MM.Panel.Hooks.Text(Message)
	local Text = Message:ReadString()
	local R    = Message:ReadShort()
	local G    = Message:ReadShort()
	local B    = Message:ReadShort()
	
	// Insert
	
	MM.Panel.Building:CreateObject({Type = "Text", Text = Text, Type = "Text", R = R, G = G, B = B})
end

usermessage.Hook("Panel.Words", MM.Panel.Hooks.Text)

// Finish

function MM.Panel.Hooks.Finish(Message)
	MM.Panel.Building:Create()
end

usermessage.Hook("Panel.Finish", MM.Panel.Hooks.Finish)

// Test

function MM.Panel.Test(Player)
	local Panel = MM.Panel:New("Test")
	
	// Button
	
	Panel:CreateObject({Type = "Button", Text = "Button", Command = function() Msg("Yay\n") end, R = 125, G = 125, B = 125})
	
	// Text
	
	Panel:CreateObject({Type = "Text", Text = "Text", R = 255, G = 255, B = 255})
	
	// CheckBox
	
	Panel:CreateObject({Type = "CheckBox", Text = "CheckBox", Command = function(A) Msg(A.."\n") end})
	
	// CheckBox
	
	Panel:CreateObject({Type = "Slider", Text = "Slider", Min = 0, Max = 512})
	
	// Create
	
	Panel:Create()
end

concommand.Add("mm_test", MM.Panel.Test)