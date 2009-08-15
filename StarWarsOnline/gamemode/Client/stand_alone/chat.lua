// this is A WIP chat by MGinshe.
// Im not sure how its gona go for lag.. but.. meh

SWO.Chat = {}
SWO.Chat.Chats = {}

function SWO.Chat:Init()
	// Sorry for the lack of comments.. Ill make some later
	
	self.MainFrame = vgui.Create( "DFrame" )
	self.MainFrame:SetPos( 0, ScrH() / 2 )
	self.MainFrame:SetSize( 500, 200 )
	self.MainFrame:SetDraggable( true )
	self.MainFrame:ShowCloseButton( true )
	self.MainFrame:SetSizable( true )
	self.MainFrame:SetTitle( "SWO Chat" )
	self.MainFrame.Paint = function()
		draw.RoundedBox( 4, 0, 0, self.MainFrame:GetWide(), 23, Color( 155, 100, 0, 155 ) )
	end
	
	self.ChatTabs = vgui.Create( "DPropertySheet", self.MainFrame )
	self.ChatTabs:SetPos( 0, 24 )
	self.ChatTabs:SetSize( self.MainFrame:GetWide(), self.MainFrame:GetTall() - 24 )
	
	//function self:AddChat( Name, Falgs, Description )
	//	SWO.Chat.Chats[ Name ] = vgui.Create( "DPanel", SWO.Chat.ChatTabs )
	//	SWO.Chat.Chats[ Name ]:SetPos( 5, 5 )
	//	SWO.Chat.Chats[ Name ]:SetSize( SWO.Chat.ChatTabs:GetWide() - 10, SWO.Chat.ChatTabs:GetTall() - 70 )
	//	SWO.Chat.ChatTabs:AddSheet( Name, SWO.Chat.Chats[ Name ], "gui/silkicons/comment", false, false, Description )
	//end
	self:ChatSettingsTab()
	self:ChatAddTab()
	self.AddChat( "Global", "Global Chat", { } )
	self.AddChat( "Team", "Team Chat", { } )
end
function SWO.Chat:AddChat( Name, Description, Flags )
	local self = SWO.Chat
	print( "Building "..Name.." Tab " )
	if( not self.Chats ) then self.Chats = {} end
	self.Chats[ Name ] = vgui.Create( "DPanel", self.ChatTabs )
	self.Chats[ Name ]:SetPos( 5, 5 )
	self.Chats[ Name ]:SetSize( self.ChatTabs:GetWide() - 10, self.ChatTabs:GetTall() - 60 )
	self.Chats[ Name ].Paint = function()
		
	end
	if( not self.Chats[ Name ].Data ) then self.Chats[ Name ].Data = {} end
	self.Chats[ Name ].Data.Text = vgui.Create( "DTextEntry", self.Chats[ Name ] )
	self.Chats[ Name ].Data.Text:SetSize( self.Chats[ Name ]:GetWide() - 4, 20 )
	self.Chats[ Name ].Data.Text:SetPos( 2, self.Chats[ Name ]:GetTall() - 0 )
	self.Chats[ Name ].Data.Text:SetEditable( false )
	
	self.Chats[ Name ].Data.Flags = Flags
	
	local CurrObj = self.Chats[ Name ]
	self.ChatTabs:AddSheet( Name, CurrObj, "gui/silkicons/comment", false, false, Description )
end
function SWO.Chat:ChatAddTab()
	self.ChatAddTab = vgui.Create( "DPanel", self.ChatTabs )
	self.ChatAddTab:SetPos( 5, 5 )
	self.ChatAddTab:SetSize( self.ChatTabs:GetWide() - 10, self.ChatTabs:GetTall() - 10 )
	self.ChatAddTab.Paint = function()
		
		
	end
	print( "Building Chat Adding Tab..." )
	self.ChatTabs:AddSheet( "", self.ChatAddTab, "gui/silkicons/comment_add", false, false, "Add Chat" )
	print( "Chat Adding Tab Built" )
end
function SWO.Chat:ChatSettingsTab()
	self.ChatSettingsTab = vgui.Create( "DPanel", self.ChatTabs )
	self.ChatSettingsTab:SetPos( 5, 5 )
	self.ChatSettingsTab:SetSize( self.ChatTabs:GetWide() - 10, self.ChatTabs:GetTall() - 10 )
	self.ChatSettingsTab.Paint = function()
		
		
	end
	print( "Building Chat Settings Tab..." )
	self.ChatTabs:AddSheet( "", self.ChatSettingsTab, "gui/silkicons/cog", false, false, "Chat Settings" )
	print( "Chat Settings Tab Built" )
end
concommand.Add( "StartSWOChat", SWO.Chat:Init() )

function GM:StartChat()
	SWO.ChatOpen = true
	gui.EnableScreenClicker( true )
	
end
function GM:FinishChat()
	SWO.ChatOpen = false
	gui.EnableScreenClicker( false )
	
	
end
function GM:ChatTextChanged()
	
	
end
function GM:ChatText()
	
	
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



	