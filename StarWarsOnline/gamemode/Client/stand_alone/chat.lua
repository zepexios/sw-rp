// this is A WIP chat by MGinshe.
// Im not sure how its gona go for lag.. but.. meh

SWO.Chat = {}
SWO.Chat.Chats = {}

SWO.Chat.Shortcuts = {} // Pretty simple realy; This next line will replace all instances of "Faggot" With "F***t". NOTE This IS case sensitive
SWO.Chat.Shortcuts["Faggot"] 	= "F***t"
SWO.Chat.Shortcuts["gay"]		= "homosexual"

SWO.Chat.Emotes = {}

SWO.Chat.Lines = {}
if( file.Read( "StarWarsOnline/ChatSettings" ) ) then
	SWO.Chat.Settings = util.KeyValuesToTable( file.Read( "StarWarsOnline/ChatSettings" ) )
else
	SWO.Chat.Settings = {}
end
SWO.Chat.Settings[ "TimeStamps" ] = true

local TEXT_TYPE_NONE	= 1
local TEXT_TYPE_COLOR	= 2
local TEXT_TYPE_EMOTE	= 3
function SWO.Chat:Init()
	// Sorry for the lack of comments.. Ill make some later
	
	self.MainFrame = vgui.Create( "DFrame" )
	self.MainFrame:SetPos( 0, ScrH() / 2 )
	self.MainFrame:SetSize( 500, 200 )
	self.MainFrame:SetDraggable( true )
	self.MainFrame:ShowCloseButton( true )
	self.MainFrame:SetSizable( true )
	self.MainFrame:SetTitle( "" )
	self.MainFrame.Paint = function()
		if( SWO.MouseActive ) then
			draw.RoundedBox( 1, self.MainFrame:GetWide() - 23, 23, 23, self.MainFrame:GetTall() - 23, Color( 195, 100, 0, 200 ) )
			surface.SetDrawColor( 0, 0, 0, 255 )
			surface.DrawRect( self.MainFrame:GetWide() - 26, 23, 3, self.MainFrame:GetTall() )
		end
	end
	
	self.ChatTabs = vgui.Create( "DPropertySheet", self.MainFrame )
	self.ChatTabs:SetPos( 0, 0 )
	self.ChatTabs:SetSize( self.MainFrame:GetWide() - 25, self.MainFrame:GetTall() )
	self.ChatTabs.Paint = function()
		if( !SWO.MouaseActive ) then
			surface.SetDrawColor( 55, 55, 55, 20 )
			surface.DrawRect( 2 + 1, 22 + 1, self.MainFrame:GetWide() - 4, self.ChatTabs:GetTall() - 23 )
		else
			
		end
	end
	
	self:ChatSettingsTab()
	self:ChatAddTab()
	self:AddChat( "Global", "Global Chat", { } )
	self:AddChat( "Team", "Team Chat", { "Team" } )
	self:AddChat( "PM", "Private Message", { "PM" } )
end
function SWO.Chat:AddChat( TabName, TabDescription, TabFlags )
	local self = SWO.Chat
	if( not self.Chats ) then self.Chats = {} end
	self.Chats[ TabName ] = vgui.Create( "DPanelList", self.ChatTabs )
	self.Chats[ TabName ]:SetPos( 5, 5 )
	self.Chats[ TabName ]:SetSize( self.ChatTabs:GetWide() - 10, self.ChatTabs:GetTall() - 5 )
	self.Chats[ TabName ]:EnableVerticalScrollbar( true )
	self.Chats[ TabName ].Paint = function()
		surface.SetFont( "ChatFont" )
		local _, lineHeight = surface.GetTextSize( "H" )
		local curX = 10
		local curY = 10
		for i = 0, SWO.Chat.MaxLines or 10 do
			local line = SWO.Chat.Lines[ #SWO.Chat.Lines - i ]
			if( line )then
				for k, v in pairs( self.Chats[ TabName ].Data.Flags ) do
					for e, a in pairs( line.Flags ) do
						if( v == a) then
							local RightFlags = true 
						end
					end
				end
			end
			RightFlags = true
			if( line and RightFlags )then
				curX = 10
				SWO.Chat:DrawLine( curX, curY, line )
				curY = curY + 10 + 5
			end
		end
	end
	self.Chats[ TabName ].Think = function()
		
	end
	self.Chats[ TabName ].Init = function()
		self.LastActiveTab = self.Chats[ TabName ]
	end
	if( not self.Chats[ TabName ].Data ) then self.Chats[ TabName ].Data = {} end
	self.Chats[ TabName ].Data.Text = vgui.Create( "DTextEntry", self.Chats[ TabName ] )
	self.Chats[ TabName ].Data.Text:SetSize( self.Chats[ TabName ]:GetWide() - 4, 20 )
	self.Chats[ TabName ].Data.Text:SetPos( 2, self.ChatTabs:GetTall() - 54 )
	self.Chats[ TabName ].Data.Text:SetEditable( false )
	self.Chats[ TabName ].Data.Text:SetVisible( false )
	self.Chats[ TabName ].Data.Text.OnEnter = function()
		print( "Entered " )
	end
	
	self.Chats[ TabName ].Data.Flags = TabFlags
	
	local CurrObj = self.Chats[ TabName ]
	self.ChatTabs:AddSheet( TabName, CurrObj, "gui/silkicons/comment", false, false, TabDescription )
end
function SWO.Chat:ChatAddTab()	
	self.ChatAddTab = vgui.Create( "DPanelList", self.ChatTabs )
	self.ChatAddTab:SetPos( 5, 5 )
	self.ChatAddTab:SetSize( self.ChatTabs:GetWide() - 10, self.ChatTabs:GetTall() - 10 )
	self.ChatAddTab:EnableVerticalScrollbar( true )
	self.ChatAddTab.Paint = function()
		
		
	end
	self.ChatAddTab.Data = {}
	self.ChatTabs:AddSheet( "", self.ChatAddTab, "gui/silkicons/comment_add", false, false, "Add Chat" )
end
function SWO.Chat:ChatSettingsTab()
	self.ChatSettingsTab = vgui.Create( "DPanelList", self.ChatTabs )
	self.ChatSettingsTab:SetPos( 5, 5 )
	self.ChatSettingsTab:SetSize( self.ChatTabs:GetWide() - 10, self.ChatTabs:GetTall() - 10 )
	self.ChatSettingsTab:EnableVerticalScrollbar( true )
	self.ChatSettingsTab.Paint = function()
		
		
	end
	self.ChatSettingsTab.Data = {}
	self.ChatSettingsTab.Data.NumSlider1 = vgui.Create( "DNumSlider", self.ChatSettingsTab )
	self.ChatSettingsTab.Data.NumSlider1:SetPos( 4, 4 )
	self.ChatSettingsTab.Data.NumSlider1:SetSize( 150, 50 )
	self.ChatSettingsTab.Data.NumSlider1:SetText( "Chat Width" )
	self.ChatSettingsTab.Data.NumSlider1:SetMin( 200 )
	self.ChatSettingsTab.Data.NumSlider1:SetMax( 800 )
	self.ChatSettingsTab.Data.NumSlider1:SetDecimals( 0 )
	self.ChatSettingsTab.Data.NumSlider1:SetValue( 500 )
	self.ChatSettingsTab.Data.NumSlider1.OnValueChanged = function()
		self.MainFrame:SetWide( self.ChatSettingsTab.Data.NumSlider1:GetValue() )
		SWO.Chat:UpdateSizes()
	end
	self.ChatSettingsTab.Data.NumSlider2 = vgui.Create( "DNumSlider", self.ChatSettingsTab )
	self.ChatSettingsTab.Data.NumSlider2:SetPos( 4, 59 )
	self.ChatSettingsTab.Data.NumSlider2:SetSize( 150, 50 )
	self.ChatSettingsTab.Data.NumSlider2:SetText( "Chat Height" )
	self.ChatSettingsTab.Data.NumSlider2:SetMin( 160 )
	self.ChatSettingsTab.Data.NumSlider2:SetMax( 400 )
	self.ChatSettingsTab.Data.NumSlider2:SetDecimals( 0 )
	self.ChatSettingsTab.Data.NumSlider2:SetValue( 200 )
	self.ChatSettingsTab.Data.NumSlider2.OnValueChanged = function()
		self.MainFrame:SetTall( self.ChatSettingsTab.Data.NumSlider2:GetValue() )
		SWO.Chat:UpdateSizes()
	end
	self.ChatSettingsTab.Data.Button1 = vgui.Create( "DButton", self.ChatSettingsTab )
	self.ChatSettingsTab.Data.Button1:SetText( "Reset Chat Size" )
	
	self.ChatSettingsTab.Data.Button1.DoClick = function()
		self.MainFrame:SetTall( 200 )
		self.ChatSettingsTab.Data.NumSlider2:SetValue( 200 )
		self.MainFrame:SetWide( 500 )
		self.ChatSettingsTab.Data.NumSlider1:SetValue( 500 )
		SWO.Chat:UpdateSizes()
	end
	self.ChatSettingsTab:AddItem( self.ChatSettingsTab.Data.NumSlider1 )
	self.ChatSettingsTab:AddItem( self.ChatSettingsTab.Data.NumSlider2 )
	self.ChatSettingsTab:AddItem( self.ChatSettingsTab.Data.Button1 )
	self.ChatTabs:AddSheet( "", self.ChatSettingsTab, "gui/silkicons/cog", false, false, "Chat Settings" )
end
function SWO.Chat:UpdateSizes()
	self.ChatTabs:SetSize( self.MainFrame:GetWide() - 25, self.MainFrame:GetTall() )
	for _, TheChat in pairs( self.Chats ) do
		TheChat:SetSize( self.ChatTabs:GetWide() - 10, self.ChatTabs:GetTall() - 55 )
		TheChat.Data.Text:SetSize( TheChat:GetWide() - 4, 20 )
		TheChat.Data.Text:SetPos( 2, self.ChatTabs:GetTall() - 54 )
	end
	self.ChatAddTab:SetSize( self.ChatTabs:GetWide() - 10, self.ChatTabs:GetTall() - 10 )
	self.ChatSettingsTab:SetSize( self.ChatTabs:GetWide() - 10, self.ChatTabs:GetTall() - 10 )
end
function SWO.Chat:ParseText( Text )
	surface.SetFont( "ChatFont" )
	local LineValues = {}
	LineValues.Type = {}
	LineValues.Value = {}
	LineValues.Text = {}
	LineValues.Width = {}
	LineValues.Flags = {}
	local id = 1
	local FlagStart, FlagEnd, FlagTag, Flag = string.find( Text, "(%[f=(%a*)%])" )
	local ColorStart, ColorEnd, ColorTag, ColorR, ColorG, ColorB, ColorA = string.find( Text, "(%[c=(%d+),(%d+),(%d+),(%d+)%])" )
	local EmoteStart, EmoteEnd, EmoteTag, Emote = string.find( Text, "(%[e=(%a*)%])" )
	local HasFlags = true
	local LolTimer = 1
	while( Text != "" ) do
		if( Flag ) then
			print( Flag )
		end
		while( Flag and HasFlags and LolTimer < 20 ) do
			print( "Has Flags: "..Flag )
			table.insert( LineValues.Flags, id, Flag )
			Text = string.Replace( Text, FlagTag, "" )
			local FlagStart, FlagEnd, FlagTag, Flag = string.find( Text, "(%[f=(%a*)%])" )
			if( !string.find( Text, "(%[f=(%a*)%])" ) ) then
				HasFlag = false
				print( Ended )
			end
			LolTimer = LolTimer + 1
		end
		if( ColorStart and EmoteStart ) then
			if( ColorStart < EmoteStart ) then
				if( ColorStart == 1 ) then
					ColorEndStart, ColorEndEnd, ColorEndTag = string.find( Text, "(%[/c%])" )
					if( ColorEndStart) then
						ColorEndStart = ColorEndStart - 1
					else
						ColorEndStart =  string.len( Text )
					end
					ColorEndEnd = ColorEndEnd or string.len( Text )
					local NewText = string.sub( Text, tonumber( ColorEnd ) + 1, ColorEndStart )
					local w, h = surface.GetTextSize( NewText )
					table.insert( LineValues.Type, id, TEXT_TYPE_COLOR )
					table.insert( LineValues.Value, id, Color( ColorR, ColorG, ColorB, COlorA ) )
					table.insert( LineValues.Text, id, NewText )
					table.insert( LineValues.Width, id, w )
					if( ColorEndEnd ) then 
						Text = string.sub( Text, ColorEndEnd + 1 )
					else 
						Text = "" 
					end
				elseif( ColorStart > 1 ) then
					local NewText = string.sub( Text, 1, ColorStart - 1 )
					local w, h = surface.GetTextSize( Text )
					table.insert( LineValues.Width, id, w )
					table.insert( LineValues.Type, id, TEXT_TYPE_NONE )
					table.insert( LineValues.Text, id, NewText )
					Text = string.sub( Text, ColorStart, string.len( Text ) )
				end
			elseif( EmoteStart < ColorStart ) then
				if( EmoteStart == 1 ) then
					for k, v in pairs( SWO.Chat.Emotes ) do
						if( k == Emote ) then
							table.insert( LineValues.Value, id, v )
							break
						else
							table.insert( LineValues.Value, id, SWO.Chat.Emotes["happy"] )
							break
						end
					end
					table.insert( LineValues.Type, id, TEXT_TYPE_EMOTE )
					table.insert( LineValues.Text, id, text )
					table.insert( LineValues.Width, id, 18 )
					Text = string.sub( Text, EmoteEnd + 1 )
				elseif( EmoteStart > 1 ) then
					local NewText = string.sub( Text, 1, EmoteStart - 1 )
					local w, h = surface.GetTextSize( NewText )
					table.insert( LineValues.Width, id, w )
					table.insert( LineValues.Type, id, TEXT_TYPE_NONE )
					table.insert( LineValues.Text, id, NewText )
					Text = string.sub( Text, EmoteStart, string.len( Text ) )
				end
			end
			local FlagStart, FlagEnd, FlagTag, Flag = string.find( Text, "(%[f=(%a*)%])" )
			local ColorStart, ColorEnd, ColorTag, ColorR, ColorG, ColorB, ColorA = string.find( Text, "(%[c=(%d+),(%d+),(%d+),(%d+)%])" )
			local EmoteStart, EmoteEnd, EmoteTag, Emote = string.find( Text, "(%[e=(%a*)%])" )
		elseif( ColoreStart and !EmoteStart ) then
			if( ColorStart == 1 ) then
				ColorEndStart, ColorEndEnd, ColorEnd = string.find( Text, "(%[/c%])" )
				if( ColorEndStart) then
					ColorEndStart = ColorEndStart - 1
				else
					ColorEndStart =  string.len( Text )
				end
				ColorEndEnd = ColorEndEnd or string.len( Text )
				local NewText = string.sub( Text, ColorEnd + 1, ColorEndStart )
				local w, h = surface.GetTextSize( NewText )
				table.insert( LineValues.Type, id, TEXT_TYPE_COLOR )
				table.insert( LineValues.Value, id, Color( ColorR, ColorG, ColorB, COlorA ) )
				table.insert( LineValues.Text, id, NewText )
				table.insert( LineValues.Width, id, w )
				if( ColorEndEnd ) then 
					Text = string.sub( Text, ColorEndEnd + 1 )
				else 
					Text = "" 
				end
			elseif( ColorStart > 1 ) then
				local NewText = string.sub( Text, 1, ColorStart - 1 )
				local w, h = surface.GetTextSize( Text )
				table.insert( LineValues.Width, id, w )
				table.insert( LineValues.Type, id, TEXT_TYPE_NONE )
				table.insert( LineValues.Text, id, NewText )
				Text = string.sub( Text, ColorStart, string.len( Text ) )
			end
		elseif( EmoteStart and !ColorStart ) then
			if( EmoteStart == 1 ) then
				for k, v in pairs( SWO.Chat.Emotes ) do
					if( k == Emote ) then
						table.insert( LineValues.Value, id, v )
						break
					else
						table.insert( LineValues.Value, id, SWO.Chat.Emotes["happy"] )
						break
					end
				end
				table.insert( LineValues.Type, id, TEXT_TYPE_EMOTE )
				table.insert( LineValues.Text, id, text )
				table.insert( LineValues.Width, id, 18 )
				Text = string.sub( Text, EmoteEnd + 1 )
			elseif( EmoteStart > 1 ) then
				local NewText = string.sub( Text, 1, EmoteStart - 1 )
				local w, h = surface.GetTextSize( NewText )
				table.insert( LineValues.Width, id, w )
				table.insert( LineValues.Type, id, TEXT_TYPE_NONE )
				table.insert( LineValues.Text, id, NewText )
				Text = string.sub( Text, EmoteStart, string.len( Text ) )
			end
		else
			local w, h = surface.GetTextSize( Text )
			table.insert( LineValues.Type, id, TEXT_TYPE_NONE )
			table.insert( LineValues.Text, id, Text )
			table.insert( LineValues.Width, id, w )
			Text = ""
			id = id + 1
		end	
		print( LineValues.Text[ 1 ] )
	end
	LineValues.Length = id
	table.insert( SWO.Chat.Lines, LineValues )
	Text = ""
end
function SWO.Chat:GetSetting( Setting )
	return SWO.Chat.Settings[ Setting ] or true
end
function SWO.Chat:DrawLine( x, y, TheLine )
	local StringLength = surface.GetTextSize( "h" ) * string.len( TheLine.Text[ 1 ] )
	local CharLength = math.floor( SWO.Chat.ChatTabs:GetActiveTab():GetPanel():GetWide() / surface.GetTextSize( "h" ) - 2 )
	local DrawNewLine = false
	if( StringLength > SWO.Chat.ChatTabs:GetActiveTab():GetPanel():GetWide() ) then
		local newLine = TheLine
		newLine.Text[ 1 ] = string.sub( newLine.Text[ 1 ], CharLength )
		DrawNewLine = true
	end
	local curX = x
	local curY = y
	local num = TheLine.Length
	for i = 1, TheLine.Length do
		local t = TheLine.Type[i]
		local w = TheLine.Width[i]
		local val = TheLine.Value[i]
		local text = TheLine.Text[i]
		if( t == TEXT_TYPE_NONE )then
			surface.SetTextColor( 255, 255, 255, 255 )
			surface.SetTextPos( curX, curY )
			surface.DrawText( text )
		elseif( t == TEXT_TYPE_COLOR )then
			surface.SetTextColor( val )
			surface.SetTextPos( curX, curY )
			surface.DrawText( text )
		elseif t == TEXT_TYPE_EMOTE then
			surface.SetTexture( surface.GetTextureID( val ) )
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.DrawTexturedRect( curX + 1, curY, 16, 16 )
		end
		if w then curX = curX + w or curX end
		if( DrawNewLine ) then
			SWO.Chat:DrawLine( x, y, newLine )
		end
	end
end
function GM:StartChat()
	SWO.ChatOpen = true
	gui.EnableScreenClicker( true )
	if( SWO.Chat.ChatTabs:GetActiveTab():GetPanel().Data.Text ) then
		SWO.Chat.ChatTabs:GetActiveTab():GetPanel().Data.Text:SetVisible( true )
	else
	end
	return true
end
function GM:FinishChat( Text )
	SWO.ChatOpen = false
	gui.EnableScreenClicker( false )
	if( SWO.Chat.ChatTabs:GetActiveTab():GetPanel().Data.Text ) then
		SWO.Chat.ChatTabs:GetActiveTab():GetPanel().Data.Text:SetVisible( false )
	else
	end
end
function GM:ChatTextChanged( Text )
	if( SWO.Chat.ChatTabs:GetActiveTab():GetPanel().Data.Text ) then
		SWO.Chat.ChatTabs:GetActiveTab():GetPanel().Data.Text:SetText( Text )
	else
	end
end
function GM:ChatText( plyInd, PlyName, Text, Type )
	if( Type == "chat" and !SWO.Chat.FilterChat ) then
		local TextColor = team.GetColor( player.GetByID( plyInd ):Team() ) or Color( 200, 200, 200, 255 )
		for k, v in pairs( SWO.Chat.Shortcuts ) do
			TheText = string.Replace( Text, k, v )
		end
		Time = ""
		//if( SWO.Chat:GetSetting( "TimeStamps" ) ) then
			local Time = string.lower( os.date( "%I:%M %p" ) )
			if( string.sub( Time, 1, 1 ) == "0" ) then
				Time = string.sub( Time, 2 )
			end
			Time = string.Replace( Time, "pm", "p.m." )
			Time = string.Replace( Time, "am", "a.m." )
			Time = Time.." "
		//end
		TheText = Time.."[c="..TextColor.r..","..TextColor.g..","..TextColor.b..","..TextColor.a.."]"..PlyName.."[/c]: "..TheText..""
		SWO.Chat:ParseText( TheText )
	elseif( Type == "none" and !SWO.Chat.FilterNone ) then
	
		SWO.Chat:ParseText( "[f=Global]"..Text )
	elseif( Type == "joinleave" and !SWO.Chat.FilterJoinLeave ) then
		SWO.Chat:ParseText( "[f=Global][c=200,200,200,255]"..Text.."[/c]" )
	end
end
function GM:OnPlayerChat( ply, Text, teamchat, alive )
	if( Type == "chat" and !SWO.Chat.FilterChat ) then
		local TextColor = team.GetColor( ply:Team() ) or Color( 200, 200, 200, 255 )
		for k, v in pairs( SWO.Chat.Shortcuts ) do
			if( k and v )then
				Text = string.Replace( Text, k, v )
			end
		end
		Text = "[c="..TextColor.r..","..TextColor.g..","..TextColor.b..","..TextColor.a.."]"..PlyName.."[/c]: "..Text..""
		SWO.Chat:ParseText( Text )
	elseif( Type == "none" and !SWO.Chat.FilterNone ) then
	
		SWO.Chat:ParseText( Text )
	elseif( Type == "joinleave" and !SWO.Chat.FilterJoinLeave ) then
		SWO.Chat:ParseText( "[c=200,200,200,255]"..Text.."[/c]" )
	end
end
concommand.Add( "StartSWOChat", SWO.Chat:Init() )







ffafasfafas = "any_1_on@hotmail.com"
















/*
function self:AddChat( Name, Description, Flags )
		SWO.Chat.Chats[ Name ] = vgui.Create( "DPanel", SWO.Chat.ChatTabs )
		SWO.Chat.Chats[ Name ]:SetPos( 5, 5 )
		SWO.Chat.Chats[ Name ]:SetSize( SWO.Chat.ChatTabs:GetWide() - 10, SWO.Chat.ChatTabs:GetTall() - 70 )
		SWO.Chat.ChatTabs:AddSheet( Name, SWO.Chat.Chats[ Name ], "gui/silkicons/comment", false, false, Description )
end

function self:AddChat( Name, Description, Flags )
		print( "Building "..Name.." Tab: "..Description )
		SWO.Chat.Chats[ Name ] = vgui.Create( "DPanel", SWO.Chat.ChatTabs )
		SWO.Chat.Chats[ Name ]:SetPos( 5, 5 )
		SWO.Chat.Chats[ Name ]:SetSize( SWO.Chat.ChatTabs:GetWide() - 10, SWO.Chat.ChatTabs:GetTall() - 170 )
		SWO.Chat.Chats[ Name ].Paint = function()
		
		end
		SWO.Chat.Chats[ Name ].Data.Text = vgui.Create( "DTextEntry", SWO.Chat.Chats[ Name ] )
		SWO.Chat.Chats[ Name ].Data.Text:SetSize( SWO.Chat.Chats[ Name ]:GetWide() - 4, 40 )
		SWO.Chat.Chats[ Name ].Data.Text:SetPos( 2, SWO.Chat.Chats[ Name ]:GetTall() - 44 )
		SWO.Chat.Chats[ Name ].Data.Text:SetEditable( false )
	
		SWO.Chat.Chats[ Name ].Data.Flags = Flags
	
		local CurrObj = SWO.Chat.Chats[ Name ]
		SWO.Chat.ChatTabs:AddSheet( Name, CurrObj, "gui/silkicons/comment", false, false, Description )
end
*/



	