local PANEL = {}

function PANEL:Init()
	self:SetTitle("Star Wars Online - Untitled")
	gui.EnableScreenClicker(true)
end

function PANEL:ShowHide()
	if(self:IsVisible()) then
		self:Close()
	else
		self:Show()
	end
end

function PANEL:Show(Override)
	if(!self:IsVisible()) then
		if(!Override) then
			gui.EnableScreenClicker(true)
		end
		self:SetVisible(true)
	end
end

function PANEL:Close(Override)
	if(self:IsVisible()) then
		if(!Override) then
			gui.EnableScreenClicker(false)
		end
		self:SetVisible(false)
	end
end

function PANEL:SetTitle(text)
	self.lblTitle:SetText("Star Wars Online - "..text)
end

function PANEL:Paint()
    surface.SetDrawColor(16, 16, 16, 200)
    surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
	
    surface.SetDrawColor(255, 255, 0, 180)
    surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
end
vgui.Register("StarFrame", PANEL, "DFrame")