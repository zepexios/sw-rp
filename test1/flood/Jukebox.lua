-----------------------------
-- Jukebox
-----------------------------

Jukebox = {}
Jukebox.Current = {}
Jukebox.RefreshQueue = {}
Jukebox.Panel = false
Jukebox.Loading = false
Jukebox.TimeEndMap = "N/A"
Jukebox.Width = 0
Jukebox.Queue = {}
Jukebox.SharedKey = "dr"

function math.AdvRound(Number, Decimal) 
	local Decimal = Decimal or 0; 
	return math.Round(Number * (10 ^ Decimal)) / (10 ^ Decimal)
end

function SecondsToFormat(Seconds)
	if(!Seconds) then
		return "N/A"
	end
	local Original 	= tonumber(Seconds)
	if(!Original) then
		return "N/A"
	end
	local Hours 	= math.floor(Seconds / 60 / 60)
	local Minutes 	= math.floor(Seconds / 60)
	local Seconds 	= math.floor(Seconds - (Minutes * 60))
	local Timeleft 	= ""
	if(Hours > 0) then
		Timeleft = Hours..":"
	end
	if(Minutes > 0) then
		Timeleft = Timeleft..Minutes..":"
	end
	if(Seconds >= 10) then
		Timeleft = Timeleft..Seconds
	elseif(Minutes > 0) then
		Timeleft = Timeleft.."0"..Seconds
	else
		Timeleft = Timeleft..Seconds
	end
	return Timeleft, Original
end


function Jukebox.HUDPaint()
	Jukebox.Width = 0
	
	local Table = Jukebox.Current
	if(!Table or !Table.ID) then
		return
	end
	
	local ScreenWidth = ScrW()
	local ScreenHeight = ScrH()
	
	local Name = Table.Name
	local Time = Table.Time
	local TimeStart = Table.TimeStart
	local TimeEnd = Table.TimeEnd
	
	if(TimeEnd and TimeEnd <= CurTime()) then
		Jukebox.Current = false
		return
	end
	
	if(TimeStart and TimeEnd) then
		Time = math.Round(CurTime() - TimeStart)
	end
	Time = SecondsToFormat(Time)
	
	surface.SetFont("MenuLarge")
	
	local TWidth1, THeight1 = surface.GetTextSize(Name)
	local TWidth2, THeight2 = surface.GetTextSize(Time)
	TWidth1 = TWidth1 + 5
	
	local Height = 44
	local X = 5
	local Y = ScreenHeight - Height
	local BoxX = 5
	local BoxY = ScreenHeight - 20
	local BoxHeight = 15
	local DotWidth = 3
	local DotHeight = 13
	
	surface.SetDrawColor(60, 60, 60, 255)
	surface.DrawRect(X, BoxY, BoxWidth, BoxHeight)
	
	local Value = CurTime() - TimeStart
	local MaxValue = TimeEnd - TimeStart
	
	local Start = "0"
	local TStartWidth, TStartHeight = surface.GetTextSize(Start)
	TStartWidth= TStartWidth + 5
	
	local End = SecondsToFormat(MaxValue)
	local TEndWidth, TEndHeight = surface.GetTextSize(End)
	TEndWidth = TEndWidth + 5
	
	local Width = math.Max(100 + TStartWidth + TEndWidth, TWidth1, TWidth2)
	local BoxWidth = Width - TStartWidth - TEndWidth
	
	local Pos = ((BoxWidth / MaxValue) * Value)
	local DotX = BoxX + Pos
	local NewBoxWidth = BoxX + Pos
	
	if(DotX >= (X + BoxWidth - 5)) then
		DotX = X + BoxWidth - 5
	end
	
	draw.RoundedBox(16, -20, Y, Width + 35, Height + 20, Color(16, 16, 16, 180))
	
	Jukebox.Width = Width + 15
	
	surface.SetTextColor(255, 255, 255, 255)
	
    surface.SetTextPos(X + (Width / 2) - (TWidth1 / 2), ScreenHeight - 40)
	surface.DrawText(Name)
	
	------------------------------------------------------------------------------------------
	
	surface.SetDrawColor(200, 20, 20, 255)
	surface.DrawRect(TStartWidth + DotX, BoxY + 1, DotWidth, DotHeight)
	
	surface.SetDrawColor(0, 255, 0, 255)
	surface.DrawOutlinedRect(TStartWidth + DotX, BoxY + 1, DotWidth, DotHeight)
	
	surface.SetDrawColor(0, 0, 255, 255)
	surface.DrawOutlinedRect(TStartWidth + X, BoxY, BoxWidth, BoxHeight)
	
	------------------------------------------------------------------------------------------
	
	local TY = BoxY + 0.5
    surface.SetTextPos(X, TY)
	surface.DrawText(Start)
	
    surface.SetTextPos(TStartWidth + X + (BoxWidth / 2) - (TWidth2 / 2), TY)
	surface.DrawText(Time)
	
    surface.SetTextPos(TStartWidth + X + BoxWidth + 5, TY)
	surface.DrawText(End)
end
hook.Add("HUDPaint", "Jukebox.HUDPaint", Jukebox.HUDPaint)

function Jukebox.UserMessagePanel(um)
	local ID = um:ReadLong()
	local Name = um:ReadString()
	local Time = tonumber(um:ReadString())
	if(!Jukebox.Panel or !Jukebox.Panel:IsValid()) then
		Jukebox.Panel = vgui.Create("FL.Jukebox")
		Jukebox.Panel:SetVisible(false)
		gui.EnableScreenClicker(false)
	end
	if(ID == -1) then
		Jukebox.Panel:Show()
		Jukebox.Panel:MakePopup()
	else
		Jukebox.Panel:Select(ID, Name, Time)
	end
end
usermessage.Hook("Jukebox.Panel", Jukebox.UserMessagePanel)

function Jukebox.UserMessageAddQueue(um)
	local Table = Jukebox.Music[um:ReadLong()]
	if(!Table) then
		return
	end
	table.insert(Jukebox.Queue, Table)
	if(Jukebox.Panel and Jukebox.Panel:IsValid()) then
		Jukebox.Panel:UpdateQueue()
	end
end
usermessage.Hook("Jukebox.AddQueue", Jukebox.UserMessageAddQueue)

function Jukebox.UserMessageStop(um)
	if(Jukebox.Panel and Jukebox.Panel:IsValid()) then
		Jukebox.Panel:Stop()
	end
end
usermessage.Hook("Jukebox.Stop", Jukebox.UserMessageStop)

function Jukebox.UserMessageTimeEndMap(um)
	Jukebox.TimeEndMap = um:ReadLong()
end
usermessage.Hook("Jukebox.TimeEndMap", Jukebox.UserMessageTimeEndMap)

function Jukebox:AddMusic(ID, Name, Time, Genre)
	self.Music[tonumber(ID)] = {
		Name = Name,
		Time = tonumber(Time),
		Genre = Genre
	}
end

local Line
local Limit = 1
function Jukebox.Think()
	if(!Jukebox.Panel or !Jukebox.Panel:IsValid() or table.Count(Jukebox.RefreshQueue) == 0) then
		return
	end
	Limit = 1
	for k,v in pairs(Jukebox.RefreshQueue) do
		if(Limit >= 400) then
			return
		end
		if(v.Name and v.Genre and v.Time) then
			Line = Jukebox.Panel.Music:AddLine(base64:dec(v.Name), base64:dec(v.Genre), SecondsToFormat(v.Time))
			Line.ID = k
			Line.Name = v.Name
			Line.Time = v.Time
		end
		Jukebox.RefreshQueue[k] = nil
		Limit = Limit + 1
	end
	if(Jukebox.RefreshQueueFunc) then
		Jukebox.RefreshQueueFunc()
	end
end
hook.Add("Think", "Jukebox.Think", Jukebox.Think)

function Jukebox:RefreshLists(Table, Func)
	Jukebox.RefreshQueue = table.Copy(Table)
	Jukebox.RefreshQueueFunc = Func or false
end

function Jukebox:RefreshMusic(OnRefresh)
	self.Music = {}
	self.Loading = true
	http.Get("http://sassilization.com/jukebox/?p=List", "", function(Content)
		self.Loading = false
		for k,v in pairs(string.Explode("\n", Content)) do
			local Explode = string.Explode("\t", v)
			if(Explode and table.Count(Explode) >= 3) then
				local ID = string.Trim(Explode[1])
				local Name = string.Trim(Explode[2])
				local Time = string.Trim(Explode[3])
				local Genre = string.Trim(Explode[4] or "Ti9B")
				if(ID != "" and Name != "" and Time != "" and Genre != "") then
					Jukebox:AddMusic(ID, Name, Time, Genre)
				end
			end
		end
		if(OnRefresh) then
			OnRefresh()
		end
	end)
end

Jukebox:RefreshMusic()