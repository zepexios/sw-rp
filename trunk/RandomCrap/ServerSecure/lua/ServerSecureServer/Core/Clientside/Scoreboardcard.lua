local PANEL = {}

// Init

function PANEL:Init()
	self.InfoLabels    = {}
	self.InfoLabels[1] = {}
	self.InfoLabels[2] = {}
	
	// Admin buttons
	
	self.btnKick = vgui.Create("PlayerKickButton", self)
	self.btnBan  = vgui.Create("PlayerBanButton", self)
	self.btnPBan = vgui.Create("PlayerPermBanButton", self)
	
	// Vote buttons
	
	self.VoteButtons = {}
	
	self.VoteButtons[1] = vgui.Create("SpawnMenuVoteButton", self)
	self.VoteButtons[1]:SetUp("exclamation", "bad", "This player is naughty!")
	
	self.VoteButtons[2] = vgui.Create("SpawnMenuVoteButton", self)
	self.VoteButtons[2]:SetUp("emoticon_smile", "smile", "I like this player!")

	self.VoteButtons[3] = vgui.Create("SpawnMenuVoteButton", self)
	self.VoteButtons[3]:SetUp("heart", "love", "I love this player!")
	
	self.VoteButtons[4] = vgui.Create("SpawnMenuVoteButton", self)
	self.VoteButtons[4]:SetUp("palette", "artistic", "This player is artistic!")
	
	self.VoteButtons[5] = vgui.Create("SpawnMenuVoteButton", self)
	self.VoteButtons[5]:SetUp("star", "star", "Wow! Gold star for you!")
	
	self.VoteButtons[6] = vgui.Create("SpawnMenuVoteButton", self)
	self.VoteButtons[6]:SetUp("wrench", "builder", "Good at building!")
end

// Set info

function PANEL:SetInfo(column, k, v)
	--if (!v || v == "") then v = "N/A" end
	
	if (!self.InfoLabels[column][k]) then

		self.InfoLabels[column][k] = {}
		self.InfoLabels[column][k].Key 	= vgui.Create("Label", self)
		self.InfoLabels[column][k].Value 	= vgui.Create("Label", self)
		self.InfoLabels[column][k].Value:SetText("")
		self:InvalidateLayout()
	
	end
	
	self.InfoLabels[column][k].Key:SetText(v)
	
	return true
	
end

// Set player

function PANEL:SetPlayer(Player)
	self.Player = Player
	
	self:UpdatePlayerData()
end

// Update player data

function PANEL:UpdatePlayerData()
	if (!self.Player) then return end
	if (!self.Player:IsValid()) then return end
	local Index = self.Player:Team()
	
	// Hover data
	
	local Data = SS.Parts.Request(self.Player, "Hover")
	
	if (Data) then
		for B, J in pairs(Data) do
			if (J != "") then
				self:SetInfo(1, B, J)
			end
		end
	end
	
	// Set the info
	
	self:SetInfo(1, "group", "Group: "..team.GetName(Index))
	self:SetInfo(2, "props", "Props: "..self.Player:GetCount("props") + self.Player:GetCount("ragdolls") + self.Player:GetCount("effects"))
	self:SetInfo(2, "hoverballs", "HoverBalls: "..self.Player:GetCount("hoverballs"))
	self:SetInfo(2, "thrusters", "Thrusters: "..self.Player:GetCount("thrusters"))
	self:SetInfo(2, "balloons", "Balloons: "..self.Player:GetCount("balloons"))
	self:SetInfo(2, "buttons", "Buttons: "..self.Player:GetCount("buttons"))
	self:SetInfo(2, "dynamite", "Dynamite: "..self.Player:GetCount("dynamite"))
	self:SetInfo(2, "sents", "SENTs: "..self.Player:GetCount("sents"))
	
	// Invalidate the layout
	
	self:InvalidateLayout()
end

// Apply scheme settings

function PANEL:ApplySchemeSettings()
	for _k, column in pairs(self.InfoLabels) do
		for k, v in pairs(column) do
			v.Key:SetFGColor(0, 0, 0, 200)
			v.Value:SetFGColor(0, 70, 0, 200)
		end
	end
end

// Think

function PANEL:Think()
	if (self.PlayerUpdate && self.PlayerUpdate > RealTime()) then return end
	self.PlayerUpdate = RealTime() + 0.25
	
	self:UpdatePlayerData()
end

// Perform layout

function PANEL:PerformLayout()	
	local x = 5

	for colnum, column in pairs(self.InfoLabels) do
		local y = 0
		local RightMost = 0
		
		for k, v in pairs(column) do
			v.Key:SetPos(x, y)
			v.Key:SizeToContents()
			
			v.Value:SetPos(x + 100 , y)
			v.Value:SizeToContents()
			
			y = y + v.Key:GetTall() + 2
			
			RightMost = math.max(RightMost, v.Value.x + v.Value:GetWide())
		end
		
		x = x + 300
	end
	
	if (!self.Player ||
		self.Player == LocalPlayer() ||
		
		!LocalPlayer():IsAdmin()) then 
		
		self.btnKick:SetVisible(false)
		self.btnBan:SetVisible(false)
		self.btnPBan:SetVisible(false)
	else
		self.btnKick:SetVisible(true)
		self.btnBan:SetVisible(true)
		self.btnPBan:SetVisible(true)
		
		self.btnKick:SetPos(self:GetWide() - 52 * 3, 115)
		self.btnKick:SetSize(48, 20)
		
		self.btnBan:SetPos(self:GetWide() - 52 * 2, 115)
		self.btnBan:SetSize(48, 20)
		
		self.btnPBan:SetPos(self:GetWide() - 52 * 1, 115)
		self.btnPBan:SetSize(48, 20)	
	end
	
	for k, v in ipairs(self.VoteButtons) do
		v:InvalidateLayout()
		v:SetPos(self:GetWide() -  k * 25, 0)
		v:SetSize(20, 32)
	end
end

// Paint

function PANEL:Paint()
	return true
end

// Register

vgui.Register("ScorePlayerInfoCard", PANEL, "Panel")