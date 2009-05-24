// Shared

include("shared.lua")

// Draw

function ENT:Draw()
	if (LocalPlayer():GetEyeTrace().Entity == self.Entity && EyePos():Distance(self.Entity:GetPos()) < 512) then
		self:DrawEntityOutline(1.0)
		
		// Draw
		
		self.Entity:DrawModel()
		
		// Overlay
		
		if (self:GetOverlayText() != "") then
			AddWorldTip(self.Entity:EntIndex(), self:GetOverlayText(), 0.5, self.Entity:GetPos(), self.Entity)
		end
		
		// Return
		
		return
	end

	// Draw
	
	self.Entity:DrawModel()
end