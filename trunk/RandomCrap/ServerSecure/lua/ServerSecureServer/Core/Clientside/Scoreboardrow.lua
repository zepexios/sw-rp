surface.CreateFont("coolvetica", 20, 500, true, false, "ScoreboardPlayerName")

local texGradient = surface.GetTextureID("gui/center_gradient")

surface.GetTextureID("gui/silkicons/emoticon_smile")

local PANEL = {}

// Paint

function PANEL:Paint()
	local Index = self.Player:Team()
	
	local color = team.GetColor(Index)
	
	if (Index == TEAM_CONNECTING) then
		color = Color(125, 125, 125, 255)
	end
	
	// Open
	
	if (self.Open || self.Size != self.TargetSize && color ) then
		draw.RoundedBox(4, 0, 16, self:GetWide(), self:GetTall() - 16, color)
		draw.RoundedBox(4, 2, 16, self:GetWide()-4, self:GetTall() - 16 - 2, Color(250, 250, 245, 255))
		
		surface.SetTexture(texGradient)
		surface.SetDrawColor(255, 255, 255, 225)
		surface.DrawTexturedRect(2, 16, self:GetWide()-4, self:GetTall() - 16 - 2) 
	end
	
	// Rounded
	if (color) then
		draw.RoundedBox(4, 0, 0, self:GetWide(), 36, color)
	end
	
	// Textures
	
	surface.SetTexture(texGradient)
	surface.SetDrawColor(255, 255, 255, 50)
	surface.DrawTexturedRect(0, 0, self:GetWide(), 36)
	return true

end

// Set player

function PANEL:SetPlayer(Player)
	self.Player = Player
	
	self.infoCard:SetPlayer(Player)
	
	self:UpdatePlayerData()
end

// Update player data

function PANEL:UpdatePlayerData()
	if (!self.Player) then return end
	if (!self.Player:IsValid()) then return end
	
	// Group
	
	local Index = self.Player:Team()

	// Text
	
	self.lblName:SetText(self.Player:Nick())
	self.lblFrags:SetText(self.Player:Frags())
	self.lblDeaths:SetText(self.Player:Deaths())
	self.lblPing:SetText(self.Player:Ping())
end

// Init

function PANEL:Init()
	self.Size = 36
	self:OpenInfo(false)
	
	self.infoCard	= vgui.Create("ScorePlayerInfoCard", self)
	
	// Info
	
	self.lblName 	= vgui.Create("Label", self)
	self.lblFrags 	= vgui.Create("Label", self)
	self.lblDeaths 	= vgui.Create("Label", self)
	self.lblPing 	= vgui.Create("Label", self)
	
	// If you don't do this it'll block your clicks
	
	self.lblName:SetMouseInputEnabled(false)
	self.lblFrags:SetMouseInputEnabled(false)
	self.lblDeaths:SetMouseInputEnabled(false)
	self.lblPing:SetMouseInputEnabled(false)
end

// Apply scheme settings

function PANEL:ApplySchemeSettings()
	self.lblName:SetFont("ScoreboardPlayerName")
	self.lblFrags:SetFont("ScoreboardPlayerName")
	self.lblDeaths:SetFont("ScoreboardPlayerName")
	self.lblPing:SetFont("ScoreboardPlayerName")
	
	self.lblName:SetFGColor(color_white)
	self.lblFrags:SetFGColor(color_white)
	self.lblDeaths:SetFGColor(color_white)
	self.lblPing:SetFGColor(color_white)
end

// Do click

function PANEL:DoClick()
	if (self.Open) then
		surface.PlaySound("ui/buttonclickrelease.wav")
	else
		surface.PlaySound("ui/buttonclick.wav")
	end

	self:OpenInfo(!self.Open)
end

// Perform layout

function PANEL:OpenInfo(bool)
	if (bool) then
		self.TargetSize = 175
	else
		self.TargetSize = 36
	end
	
	self.Open = bool
end

// Think

function PANEL:Think()
	if (self.Size != self.TargetSize) then
		self.Size = math.Approach(self.Size, self.TargetSize, (math.abs(self.Size - self.TargetSize) + 1) * 10 * FrameTime())
		self:PerformLayout()
		SCOREBOARD:InvalidateLayout()
	end
	
	if (!self.PlayerUpdate || self.PlayerUpdate < RealTime()) then
		self.PlayerUpdate = RealTime() + 0.5
		self:UpdatePlayerData()
	end
end

// Perform layout

function PANEL:PerformLayout()
	self:SetSize(self:GetWide(), self.Size)
	
	self.Avatar = vgui.Create("AvatarImage", self)
	self.Avatar:SetPlayer(self.Player)
	self.Avatar:SetPos(2, 2)
	self.Avatar:SetSize(32, 32)
	
	self.lblName:SizeToContents()
	self.lblName:SetPos(40, 9)
	
	local COLUMN_SIZE = 50
	
	self.lblPing:SetPos(self:GetWide() - COLUMN_SIZE * 1, 7)
	self.lblDeaths:SetPos(self:GetWide() - COLUMN_SIZE * 2, 7)
	self.lblFrags:SetPos(self:GetWide() - COLUMN_SIZE * 3, 7)
	
	if (self.Open || self.Size != self.TargetSize) then
		self.infoCard:SetVisible(true)
		self.infoCard:SetPos(4, self.lblName:GetTall() + 22)
		self.infoCard:SetSize(self:GetWide() - 8, self:GetTall() - self.lblName:GetTall() - 10)
	else
		self.infoCard:SetVisible(false)
	end
end

// Higher or lower

function PANEL:HigherOrLower(row)
	local Player = self.Player:Team()
	local Row    = row.Player:Team()
	
	if (Row == TEAM_CONNECTING) then
		return false
	end
	
	return (SS.Groups.GetGroupRank(Player) < SS.Groups.GetGroupRank(Row))
end

// Register

vgui.Register("ScorePlayerRow", PANEL, "Button")