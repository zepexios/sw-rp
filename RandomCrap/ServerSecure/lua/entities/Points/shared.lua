// Basic stuff

ENT.Type = "anim"  
ENT.Base = "base_gmodentity"     
ENT.PrintName = "Points"  
ENT.Author	= "Sammi"  
ENT.Contact	= "Sammi_43_@hotmail.com"  
ENT.Purpose	= "Get some points!"  
ENT.Instructions = "Scrape them out of their box!"  

// Spawnable

ENT.Spawnable = false
ENT.AdminSpawnable = false

// Set label

function ENT:SetEntityLabel()
	local Label = SS.Config.Request("Points Name")..": "..self.Entity.Amount
	
	// Label
	
	Label = Label.."\nPress (USE)"
	
	// Text
	
	self:SetOverlayText(Label)
end