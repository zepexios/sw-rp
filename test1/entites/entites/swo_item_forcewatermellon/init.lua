AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')
 
function ENT:Initialize()
 
	self.Entity:SetModel( "models/props_junk/watermelon01.mdl" )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
 
    local phys = self.Entity:GetPhysicsObject()
	if ( phys:IsValid() ) then
		phys:Wake()
	end
end
 
function ENT:Use( ply, caller )
	local MaxForce = ply:GetMaxForce()
	local TakeForce = ply:GetTakeForce()
	ply.Char.MaxForce = MaxForce + 30
	ply.Char.TakeForce = TakeForce - 0.2
	timer.Create( "Item_Watermellon_ForceReset", 30, 1, function()
		ply.Char.MaxForce = MaxForce - 30
		ply.Char.TakeForce = TakeForce + 0
	end )
    self:Remove()
end

function ENT:SpawnFunction( ply, tr )
	local ent = ents.Create( "sent_billboard" ) 
    ent:SetPos( tr.Entity:GetPos() )  
    ent:SetAngles( tr.Entity:GetAngles() )  
    ent:Spawn()  
	ent:Activate()  
    local phys = ent:GetPhysicsObject()  
    if (phys:IsValid()) then  
        phys:EnableMotion(false)  
    end  
	return ent
end