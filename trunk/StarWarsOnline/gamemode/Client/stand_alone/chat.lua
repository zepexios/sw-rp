// this is A WIP chat by MGinshe.
// Im not sure how its gona go for lag.. but.. meh

SWO.Chat = {}
SWO.Chat.Chats = {}

SWO.Chat.Shortcuts = {}
SWO.Chat.Shortcuts["Hai"] = "Hai"

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
	self:AddChat( "Team", "TeamChat", { "Team" } )
end
function SWO.Chat:AddChat( TabName, TabDescription, Flags )
	local self = SWO.Chat
	if( not self.Chats ) then self.Chats = {} end
	self.Chats[ TabName ] = vgui.Create( "DPanel", self.ChatTabs )
	self.Chats[ TabName ]:SetPos( 5, 5 )
	self.Chats[ TabName ]:SetSize( self.ChatTabs:GetWide() - 10, self.ChatTabs:GetTall() - 5 )
	self.Chats[ TabName ].Paint = function()
		
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
	
	self.Chats[ TabName ].Data.Flags = Flags
	
	local CurrObj = self.Chats[ TabName ]
	self.ChatTabs:AddSheet( TabName, CurrObj, "gui/silkicons/comment", false, false, TabDescription )
end
function SWO.Chat:ChatAddTab()	
	self.ChatAddTab = vgui.Create( "DPanel", self.ChatTabs )
	self.ChatAddTab:SetPos( 5, 5 )
	self.ChatAddTab:SetSize( self.ChatTabs:GetWide() - 10, self.ChatTabs:GetTall() - 10 )
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
	print( Text )
	local FlagStart, FlagEnd, FlagTag, Flag = string.find( Text, "(%[f=(%a*)%])" )
	local ColorStart, ColorEnd, ColorTag, ColorR, ColorG, ColorB, ColorA = string.find( Text, "(%[c=(%d+),(%d+),(%d+),(%d+)%])" )
	print( FlagStart.." "..FlagEnd.." "..FlagTag.." "..Falg )
	print( ColorStart.." "..ColorEnd.." "..ColorTag.." "..ColorR.." "..ColorG.." "..ColorB.." "..ColorA )
	
	
end
concommand.Add( "StartSWOChat", SWO.Chat:Init() )
function GM:StartChat()
	SWO.ChatOpen = true
	gui.EnableScreenClicker( true )
	if( SWO.Chat.ChatTabs:GetActiveTab():GetPanel().Data.Text ) then
		SWO.Chat.ChatTabs:GetActiveTab():GetPanel().Data.Text:SetVisible( true )
	else
	end
	//return true
end
function GM:FinishChat()
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
		TheText = "[c="..TextColor.r..","..TextColor.g..","..TextColor.b..","..TextColor.a.."]"..PlyName.."[/c]: "..TheText..""
		SWO.Chat:ParseText( TheText )
	elseif( Type == "none" and !SWO.Chat.FilterNone ) then
	
		SWO.Chat:ParseText( Text )
	elseif( Type == "joinleave" and !SWO.Chat.FilterJoinLeave ) then
		SWO.Chat:ParseText( "[c=200,200,200,255]"..Text.."[/c]" )
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



	