AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

// Shared

include("shared.lua")     

// Initialize

function ENT:Initialize() 	
	self.Entity:PhysicsInitSphere(4, "metal_bouncy")
	self.Entity:SetMoveType(MOVETYPE_NONE)
	
	// Phys
	
	local Phys = self.Entity:GetPhysicsObject()  
	
	// Wake
	
	if (Phys:IsValid()) then
		Phys:EnableMotion(false)
		Phys:Wake()  	
	end
	
	// Shadow
	
	self.Entity:DrawShadow(false)
	
	// Collision bounds
	
	self.Entity:SetCollisionBounds(Vector(4, 4, 4), Vector(4, 4, 4))
end