-----------------------------
-- Jukebox By Spacetech
-----------------------------

local PANEL = {}
PANEL.LastThink = CurTime()
PANEL.DisableJukebox = file.Exists("Jukebox.txt")

function PANEL:Init()
	self:SetTitle("Jukebox - "..tostring(table.Count(Jukebox.Music)).." Songs")
	
	local X = 7.5
	local Y = 25
	local Spacing = 5
	local ButtonWidth = 65
	local ButtonHeight = 25
	local MainWide = 340
	
	self.HTML = vgui.Create("HTML", self)
	self.HTML:SetVisible(false)
	self.HTML:SetPos(X, Y)
	self.HTML:SetSize(0, 0)
	function self.HTML.OpeningURL()
		if(self.Playing and !self.DisableJukebox) then
			timer.Simple(0.5, function()
				if(!self.DisableJukebox) then
					LocalPlayer():ChatPrint("Loading Music...")
				end
			end)
		end
	end
	function self.HTML.FinishedURL()
		if(self.Playing and !self.DisableJukebox) then
			timer.Simple(3, function()
				if(!self.DisableJukebox) then
					LocalPlayer():ChatPrint("Music Loaded Successfully!")
				end
			end)
		end
	end
	
	if(LocalPlayer():IsValid()) then
		self.Queue = vgui.Create("DListView", self)
		self.Queue:SetPos(X, Y)
		self.Queue:SetSize(MainWide, 102)
		self.Queue:SetMultiSelect(false)
		self.Queue:OnRequestResize(self.Queue:AddColumn("Name"), 200)
		self.Queue:OnRequestResize(self.Queue:AddColumn("Genre"), MainWide - 200 - 38)
		self.Queue:OnRequestResize(self.Queue:AddColumn("Time"), 38)
		for k,v in pairs(Jukebox.Queue) do
			self.Queue:AddLine(base64:dec(v.Name), base64:dec(v.Genre), SecondsToFormat(v.Time))
		end
		function self.Queue:SortByColumn()
		end
		Y = Y + self.Queue:GetTall() + Spacing
	end
	
	self.Music = vgui.Create("DListView", self)
	self.Music:SetPos(X, Y)
	self.Music:SetSize(MainWide, 391)
	self.Music:SetMultiSelect(false)
	self.Music:OnRequestResize(self.Music:AddColumn("Name"), 200)
	self.Music:OnRequestResize(self.Music:AddColumn("Genre"), MainWide - 200 - 38)
	self.Music:OnRequestResize(self.Music:AddColumn("Time"), 38)
	self:DoJukeboxRefresh()
	function self.Music:DataLayout()
		local Y = 0
		local Height = self.m_iDataHeight
		for k, Line in pairs(self.Sorted) do
			Line:SetPos(0, Y)
			Line:SetWide(self:GetWide())
			if(Line.Hidden) then
				Line:SetTall(0)
			else
				Line:SetTall(Height)
			end
			Line:DataLayout(self) 
			Line:SetAltLine(k % 2 == 1)
			Y = Y + Line:GetTall()
		end
		return Y
	end
	Y = Y + self.Music:GetTall() + Spacing
	
	self.Search = vgui.Create("DTextEntry", self)
	self.Search:SetPos(X, Y)
	self.Search:SetWide(MainWide)
	self.Search:SetFocusTopLevel(true)
	self.Search:RequestFocus()
	function self.Search.Think()
		local Value = self.Search:GetValue()
		if(self.Search.Value != Value) then
			self.Search.Value = Value
			if(string.Trim(Value) == "") then
				for k, v in pairs(self.Music.Lines) do
					if(v.Hidden) then
						v.Hidden = false
					end
				end
			else
				for k, v in pairs(self.Music.Lines) do
					local Hide = true
					if(string.find(string.Trim(string.lower(v:GetColumnText(1))), string.Trim(string.lower(Value)))) then
						Hide = false
					end
					if(v.Hidden != Hide) then
						v.Hidden = Hide
					end
				end
			end
			self.Music:SetDirty(true)
			self.Music:InvalidateLayout(true)
		end
	end
	
	Y = Y + self.Search:GetTall() + Spacing
	
	if(LocalPlayer():IsValid()) then
		self.AddSong = vgui.Create("DButton", self)
		self.AddSong:SetText("Add Song")
		self.AddSong:SetPos(X, Y)
		self.AddSong:SetSize(ButtonWidth, ButtonHeight)
		function self.AddSong.DoClick()
			local Selected = self.Music:GetSelected()
			if(Selected) then
				local Panel = Selected[1]
				if(Panel) then
					Derma_Query("Are you sure you want to add '"..Panel:GetColumnText(1).."' to the queue", "Confirmation",
						"Add",
						function()
							RunConsoleCommand("jukebox_addsong", Panel.ID, Panel.Name, Panel.Time)
						end, 
						"Cancel",
						function()
						end
					)
				end
			end
		end
		X = X + self.AddSong:GetWide() + Spacing
		
		self.VoteSong = vgui.Create("DButton", self)
		self.VoteSong:SetText("Vote")
		self.VoteSong:SetPos(X, Y)
		self.VoteSong:SetSize(ButtonWidth, ButtonHeight)
		function self.VoteSong.DoClick()
			local Selected = self.Music:GetSelected()
			if(Selected) then
				local Panel = Selected[1]
				if(Panel) then
					Derma_Query("Are you sure you want to start a vote to add '"..Panel:GetColumnText(1).."' to the queue", "Confirmation",
						"Add",
						function()
							RunConsoleCommand("jukebox_votesong", Panel.ID, Panel.Name, Panel.Time)
						end, 
						"Cancel",
						function()
						end
					)
				end
			end
		end
		X = X + self.VoteSong:GetWide() + Spacing
	end
	
	self.RefreshMusic = vgui.Create("DButton", self)
	self.RefreshMusic:SetText("Refresh")
	self.RefreshMusic:SetPos(X, Y)
	self.RefreshMusic:SetSize(ButtonWidth, ButtonHeight)
	function self.RefreshMusic.DoClick()
		if(!Jukebox.Loading and !Jukebox.Recaching) then
			self.Music:Clear()
			self.Music:AddLine("Loading...")
			Jukebox:RefreshMusic(function()
				self.Music:Clear()
				self.Search:SetText("")
				self:DoJukeboxRefresh()
			end)
		end
	end
	X = X + self.RefreshMusic:GetWide() + Spacing
	
	if(LocalPlayer():IsValid()) then
		self.RecacheMusic = vgui.Create("DButton", self)
		self.RecacheMusic:SetText("X")
		self.RecacheMusic:SetPos(X, Y)
		self.RecacheMusic:SetSize(ButtonWidth / 4, ButtonHeight)
		function self.RecacheMusic.DoClick()
			if(!Jukebox.Recaching) then
				self.Music:Clear()
				self.Music:AddLine("Recaching...")
				Jukebox.Recaching = true
				http.Get("http://sassilization.com/jukebox/?p=Recache", "", function()
					Jukebox.Recaching = false
					self.RefreshMusic:DoClick()
				end)
			end
		end
		X = X + self.RecacheMusic:GetWide() + Spacing
	end
	
	if(LocalPlayer():IsValid()) then
		self.Timeleft = vgui.Create("DLabel", self)
		self.Timeleft:SetPos(X, Y + 2)
		self.Timeleft.Timeleft = ""
		
		local Timeleft = "N/A"
		self.Timeleft.Think = function()
			Timeleft = Jukebox.TimeEndMap
			if(tonumber(Timeleft) != nil) then
				Timeleft = SecondsToFormat(math.Round(Timeleft - CurTime()))
			end
			if(self.Timeleft.Timeleft != Timeleft) then
				self.Timeleft:SetText("Timeleft: "..tostring(Timeleft))
				self.Timeleft:SizeToContents()
				self.Timeleft.Timeleft = Timeleft
			end
		end
	end
	if(!LocalPlayer():IsValid()) then
		self.RequestSong = vgui.Create("DButton", self)
		self.RequestSong:SetText("Request")
		self.RequestSong:SetPos(X, Y)
		self.RequestSong:SetSize(ButtonWidth, ButtonHeight)
		function self.RequestSong.DoClick()
			local Selected = self.Music:GetSelected()
			if(Selected) then
				local Panel = Selected[1]
				if(Panel) then
					Derma_Query("Are you sure you want to request '"..Panel:GetColumnText(1).."'", "Confirmation",
						"Request",
						function()
							RunConsoleCommand("jukebox_requestsong", Panel:GetColumnText(1))
						end, 
						"Cancel",
						function()
						end
					)
				end
			end
		end
		X = X + self.RequestSong:GetWide() + Spacing

	else
		X = 7.5
		Y = Y + self.RefreshMusic:GetTall() + Spacing
	end
	
	self.StopMusic = vgui.Create("DButton", self)
	self.StopMusic:SetPos(X, Y)
	self.StopMusic:SetSize(ButtonWidth, ButtonHeight)
	self.StopMusic:SetText("Stop Song")
	function self.StopMusic.DoClick()
		self:Stop()
		LocalPlayer():ChatPrint("Jukebox: Stopped the Current Song")
	end
	X = X + self.StopMusic:GetWide() + Spacing
	
	Y = Y + 5
	
	self.Mute = vgui.Create("DCheckBoxLabel", self)
	self.Mute:SetPos(X, Y)
	self.Mute:SetWide(135)
	self.Mute:SetText("Mute Music")
	self.Mute:SetValue(self.DisableJukebox)
	function self.Mute.OnChange()
		self.DisableJukebox = self.Mute:GetChecked()
		if(self.DisableJukebox) then
			self:Stop()
			file.Write("Jukebox.txt", "")
			LocalPlayer():ChatPrint("Jukebox: Disabled")
		else
			file.Delete("Jukebox.txt")
			LocalPlayer():ChatPrint("Jukebox: Enabled. You will start hearing music on the next song change.")
		end
	end
	
	X = X + self.Mute:GetWide() + Spacing
	Y = Y + self.Mute:GetTall() + Spacing
	
	self:SetWide(math.Max(X, MainWide + 10))
	self:SetTall(Y + 10)
	
	self:Center()
end

function PANEL:DoJukeboxRefresh()
	Jukebox:RefreshLists(Jukebox.Music, function()
		self.Music:SortByColumn(1)
		self.Music:SetDirty(true)
		self.Music:InvalidateLayout(true)
		self:SetTitle("Jukebox - "..tostring(table.Count(Jukebox.Music)).." Songs")
	end)
end

function PANEL:Stop(Delete)
	self.Playing = false
	self.HTML:Stop()
	self.HTML:SetHTML("")
	if(Delete) then
		self.HTML:Remove()
	end
end

function PANEL:Select(ID, Name, Time)
	if(!Jukebox.Music[ID]) then
		Jukebox.Music[ID] = {
			Name = Name,
			Time = Time
		}
	end
	self.Playing = true
	Jukebox.Current = {
		ID = ID,
		Name = base64:dec(Name),
		Time = Time,
		TimeStart = CurTime(),
		TimeEnd = CurTime() + Time
	}
	if(table.Count(Jukebox.Queue) > 0) then
		table.remove(Jukebox.Queue, 1)
		self:UpdateQueue()
	end
	if(!self.DisableJukebox) then
		self.HTML:OpenURL("http://sassilization.com/jukebox/?s="..ID.."&fol="..Jukebox.SharedKey)
	end
end

function PANEL:UpdateQueue()
	if(!self.Queue) then
		return
	end
	self.Queue:Clear()
	for k,v in pairs(Jukebox.Queue) do
		self.Queue:AddLine(base64:dec(v.Name), base64:dec(v.Genre), SecondsToFormat(v.Time))
	end
	self.Queue:SetDirty(true)
	self.Queue:InvalidateLayout(true)
end

local base = "FL.VGUI.Base"

vgui.Register("FL.Jukebox", PANEL, base)