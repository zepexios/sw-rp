local PANEL = {}
function PANEL:Init()
	--This is the panel it all goes on
	self.panel = vgui.Create("DPanel",self)
	self.panel:SetPos(0,0)
	self.panel:SetSize(180,60)
	
	--This is the image
	self.image = vgui.Create("DImage",self.panel)
	self.image:SetImage("")
	local tall = self.panel:GetTall()-10
	self.image:SetSize(tall,tall)
	self.image:SetPos(5,5)
	
	--This is the list of info  on the right
	self.Infolist = vgui.Create("DPanelList",self.panel)
	self.Infolist:SetPos(self.image:GetWide()+10,5)
	self.Infolist:SetSize(self.panel:GetWide()-(self.image:GetWide()+15),self.panel:GetTall()-10)
	self.Infolist:EnableHorizontal(true)
	self.Infolist:SetPadding(2)
	self.Infolist:SetSpacing(1)
	
	--This is the name label
	self.namelabel = vgui.Create("DLabel")
	self.namelabel:SetText("LOL STUPID NO NAME <.<")
	self.namelabel:SizeToContents()
	self.Infolist:AddItem(self.namelabel)
	
	self.usebutton = vgui.Create("DButton")
	self.usebutton:SetSize(self.Infolist:GetWide()-10,15)
	self.usebutton:SetText("Use")
	local button = self.usebutton
	button.DoClick = function(button)
		self:GetParent():GetParent():Close()
	end
	self.Infolist:AddItem(self.usebutton)
end
function PANEL:Paint()
	return true
end
function PANEL:HideUse()
	self.usebutton:SetVisible(false)
end
function PANEL:SetName(strng)
	self.namelabel:SetText(strng)
	self.namelabel:SizeToContents()
	print(strng)
end
function PANEL:SetImage(image)
	self.image:SetImage(image)
end
vgui.Register("DCharbox",PANEL)