// Notification

NOTIFY_GENERIC = 0
NOTIFY_ERROR   = 1
NOTIFY_UNDO	   = 2
NOTIFY_HINT	   = 3
NOTIFY_CLEANUP = 4

// Materials

local Materials = {}

// Texture ID

Materials[NOTIFY_GENERIC] = surface.GetTextureID("vgui/notices/generic")
Materials[NOTIFY_ERROR]   = surface.GetTextureID("vgui/notices/error")
Materials[NOTIFY_UNDO]    = surface.GetTextureID("vgui/notices/undo")
Materials[NOTIFY_HINT]    = surface.GetTextureID("vgui/notices/hint")
Materials[NOTIFY_CLEANUP] = surface.GetTextureID("vgui/notices/cleanup")

// Note

local Note = {}

// Variables

Note.C = 0
Note.I = 1
Note.H = {}

// New

function GAMEMODE:AddNotify(String, Type, Leng)
	local Tab = {}
	
	// Variables
	
	Tab.Text 	  = String
	Tab.Rec 	  = RealTime()
	Tab.Len 	  = Leng
	Tab.Type	  = Type
	Tab.X		  = ScrW() + 200
	Tab.Y		  = ScrH()
	Tab.A		  = 255
	Tab.VelocityX = -5
	Tab.VelocityY = 0
	
	// Insert
	
	table.insert(Note.H, Tab)
	
	// Increase
	
	Note.C = Note.C + 1
	Note.I = Note.I + 1
end

// Draw it

local function Create(self, K, V, I)
	local Border = 1
	
	// H, X and Y
	
	local H = ScrH() / 1024
	local X = V.X - 75 * H
	local Y = V.Y - 300 * H
	
	// Width
	
	if (!V.w) then
		surface.SetFont("ChatFont")
		
		// Width and height
		
		V.W, V.H = surface.GetTextSize(V.Text)
	end
	
	// Locals
	
	local W = V.W
	local H = V.H
	
	// Add 16 to them
	
	W = W + 16
	H = H + 16
	
	// X, Y, W and H
	
	local NX = X - W - H + 8
	local NY = Y - 8
	local NW = W + H
	local NH = H
	
	// Color
	
	local Col = Color(255, 255, 255, 255)

	// Box
	
	draw.RoundedBox(4, NX, NY, NW, NH, Color(0, 0, 0, 200))
	
	// Surface draw texture
	
	surface.SetDrawColor(0, 0, 0, 50)
	surface.SetTexture(Materials[V.Type])
	surface.DrawTexturedRect(X - W - H + 17, Y - 3, H - 8, H - 8)
	
	// Surface draw texture
	
	surface.SetDrawColor(255, 255, 255, V.A)
	surface.SetTexture(Materials[V.Type])
	surface.DrawTexturedRect(X - W - H + 16, Y - 4, H - 8, H - 8)
	
	// Text
	
	draw.SimpleText(V.Text, "ChatFont", X, Y, Color(255, 255, 255, V.A), TEXT_ALIGN_RIGHT)
	
	// Ideal Y and X
	
	local IdealY = ScrH() - (Note.C - I) * (H + 4)
	local IdealX = ScrW()
	
	// Timeleft
	
	local Timeleft = V.Len - (RealTime() - V.Rec)
	
	// Check timeleft
	
	if (Timeleft < 0.8) then
		IdealX = ScrW() - 50
	end
	
	// Check timeleft
	
	if (Timeleft < 0.5) then
		IdealX = ScrW() + W * 2
	end
	
	// Speed
	
	local Speed = FrameTime() * 15
	
	// Y and X
	
	V.Y = V.Y + V.VelocityY * Speed
	V.X = V.X + V.VelocityX * Speed
	
	// Distance Y
	
	local Dist = IdealY - V.Y
	
	// Velocity Y
	
	V.VelocityY = V.VelocityY + Dist * Speed * 1
	
	// Math absolute Y
	
	if (math.abs(Dist) < 2 and math.abs(V.VelocityY) < 0.1) then V.VelocityY = 0 end
	
	// Dist X
	
	local Dist = IdealX - V.X
	
	// Velocity X
	
	V.VelocityX = V.VelocityX + Dist * Speed * 1
	
	// Math absolute X
	
	if (math.abs(Dist) < 2 and math.abs(V.VelocityX) < 0.1) then V.VelocityX = 0 end
	
	// Velocity X and Y
	
	V.VelocityX = V.VelocityX * (0.95 - FrameTime() * 8)
	V.VelocityY = V.VelocityY * (0.95 - FrameTime() * 8)
end

// Paint them

function GAMEMODE:PaintNotes()
	if (!Note.H) then return end
	
	// Start I at 0
	
	local I = 0
	
	// Loop
	
	for K, V in pairs(Note.H) do
		if (V != 0) then
			I = I + 1
			
			// Create
			
			Create(self, K, V, I)		
		end
	end
	
	// Loop
	
	for K, V in pairs(Note.H) do
		if (V != 0 and V.Rec + V.Len < RealTime()) then
			Note.H[K] = 0
			
			// Note C take one
			
			Note.C = Note.C - 1
			
			// Check if note C is 0
			
			if (Note.C == 0) then Note.H = {} end
		end
	end
end