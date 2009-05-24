AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

// Shared

include("shared.lua")     

// Initialize

function ENT:Initialize()     	
	local Model = SS.Config.Request("Points Model")
	
	// Valid
	
	if not (util.IsValidModel(Model)) then Model = "models/props_lab/jar01a.mdl" end
	
	// Settings
	
	self.Entity:SetModel(Model)  	
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	
	// Phys
	
	local Phys = self.Entity:GetPhysicsObject()  
	
	if (Phys:IsValid()) then  		
		Phys:Wake()  	
	end
	
	// Label
	
	self:SetEntityLabel()
end

// Think

function ENT:Think()
	self:SetEntityLabel()
	
	// Next think
	
	self.Entity:NextThink(RealTime() + 1)
	
	// Return true
	
	return true
end

// Use

function ENT:Use(Activator, Caller)
	if (SERVER) then
		local Player = Activator:IsPlayer()
		
		// Player
		
		if (Player) then
			SS.Points.PlayerGain(Activator, self.Entity.Amount)
			
			// Message
			
			SS.PlayerMessage(Activator, "You've scraped out "..self.Entity.Amount.." "..SS.Config.Request("Points Name").."!", 0)
			
			// Remove
			
			self.Entity:Remove()
		end
	end
end