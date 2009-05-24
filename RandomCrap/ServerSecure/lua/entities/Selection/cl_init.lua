// Shared

include("shared.lua")

// Best material

local Laser = Material("tripmine_laser")

// Draw text

function ENT:Text(Position, Text)
	// Angles
	
	local Ang = self.Entity:GetAngles()
	
	// Rot
	
	local Rot = Vector(-90, 90, -90)
	
	// Rotate
	
	Ang:RotateAroundAxis(Ang:Right(), Rot.x)
	Ang:RotateAroundAxis(Ang:Up(), Rot.y)
	Ang:RotateAroundAxis(Ang:Forward(), Rot.z)
	
	// Camera
	
	cam.Start3D2D(Position, Ang, 1)
		draw.SimpleText(Text, "TargetID", 0, 0, Color(255, 255, 255, 255), 1, 1)
	cam.End3D2D()
	
	// Angles
	
	local Ang = self.Entity:GetAngles()
	
	// Rot
	
	local Rot = Vector(-90, 90, 90)

	// Rotate
	
	Ang:RotateAroundAxis(Ang:Right(), Rot.x)
	Ang:RotateAroundAxis(Ang:Up(), Rot.y)
	Ang:RotateAroundAxis(Ang:Forward(), Rot.z)
	
	// Camera
	
	cam.Start3D2D(Position, Ang, 1)
		draw.SimpleText(Text, "TargetID", 0, 0, Color(255, 255, 255, 255), 1, 1)
	cam.End3D2D()
end

// Draw

function ENT:Draw()
	if not (self.Entity:IsValid()) then return end
	
	// Position
	
	local Position = self.Entity:GetPos()
	
	// X
	
	local End = Position + self.Entity:GetRight() * 128
	
	// Render
	
	render.SetMaterial(Laser)
	render.DrawBeam(Position, End, 8, 0.2, 0.8, Color(255, 0, 0, 200))
	
	// Text
	
	self:Text(Position + self.Entity:GetRight() * 80, "Left")
	
	// -X
	
	local End = Position + self.Entity:GetRight() * -128
	
	// Render
	
	render.SetMaterial(Laser)
	render.DrawBeam(Position, End, 8, 0.2, 0.8, Color(255, 0, 0, 200))
	
	// Text
	
	self:Text(Position + self.Entity:GetRight() * -80, "Right")
	
	// Y
	
	local End = Position + self.Entity:GetForward() * 128
	
	// Render
	
	render.SetMaterial(Laser)
	render.DrawBeam(Position, End, 8, 0.2, 0.8, Color(0, 255, 0, 200))
	
	// Text
	
	self:Text(Position + self.Entity:GetForward() * 80, "Backward")
	
	// -Y
	
	local End = Position + self.Entity:GetForward() * -128
	
	// Render
	
	render.SetMaterial(Laser)
	render.DrawBeam(Position, End, 8, 0.2, 0.8, Color(0, 255, 0, 200))
	
	// Text
	
	self:Text(Position + self.Entity:GetForward() * -80, "Forward")
	
	// Z
	
	local End = Position + self.Entity:GetUp() * 128
	
	// Render
	
	render.SetMaterial(Laser)
	render.DrawBeam(Position, End, 8, 0.2, 0.8, Color(0, 0, 255, 200))
	
	// Text
	
	self:Text(Position + self.Entity:GetUp() * 80, "Up")
	
	// -Z
	
	local End = Position + self.Entity:GetUp() * -128
	
	// Render
	
	render.SetMaterial(Laser)
	render.DrawBeam(Position, End, 8, 0.2, 0.8, Color(0, 0, 255, 200))
	
	// Text
	
	self:Text(Position + self.Entity:GetUp() * -80, "Down")
end