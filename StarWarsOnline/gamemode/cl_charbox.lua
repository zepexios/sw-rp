local PANEL = {}
CharButtons = {}

function PANEL:Init()
	--This is the panel it all goes on
	table.insert(CharButtons, self)
	
	self:SetSize(180,60)
	
	--This is the image
	self.image = vgui.Create("DImage", self)
	self.image:SetImage("")
	local tall = self:GetTall()-10
	self.image:SetSize(tall,tall)
	self.image:SetPos(5,5)
end

function PANEL:DoClick()
	for k, v in pairs(CharButtons) do
		v.Selected = false
	end

	self.Selected = true
end

function PANEL:Paint()

	if self.Selected then
		surface.SetDrawColor(235, 235, 16, 230)
		surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
		
		surface.SetDrawColor(235, 235, 235, 235)
		surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
	elseif self.Hovered then
		surface.SetDrawColor(64, 64, 64, 200)
		surface.DrawRect(0, 0, self:GetWide(), self:GetTall())

		surface.SetDrawColor(0, 0, 0, 180)
		surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
	end
	
	draw.SimpleText(self.Text, "small", self.image:GetWide() + 15, 5, Color(0, 0, 0, 255), 0,4)
	
	return true
end
function PANEL:HideUse()
	self.usebutton:SetVisible(false)
end
function PANEL:SetName(strng)
	self.Text = strng
	print(strng)
end
function PANEL:SetImage(image)
	self.image:SetImage(image)
end
vgui.Register("DCharbox",PANEL, "DButton")