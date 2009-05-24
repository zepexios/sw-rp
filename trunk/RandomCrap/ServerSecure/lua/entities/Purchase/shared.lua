// Basic stuff

ENT.Type = "anim"  
ENT.Base = "base_gmodentity"     
ENT.PrintName = "Purchase"  
ENT.Author	= "Sammi"  
ENT.Contact	= "Sammi_43_@hotmailc.om"  
ENT.Purpose	= "Get a new purchase!"  
ENT.Instructions = "Rip it out of it's packaging!"  

// Spawnable

ENT.Spawnable = false
ENT.AdminSpawnable = false

// Set label

function ENT:SetEntityLabel()
	local Label = "Purchase: "..self.Entity.Purchase[2]
	
	// Label
	
	Label = Label.."\nPress (USE)"
	
	// Text
	
	self:SetOverlayText(Label)
end