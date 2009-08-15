// this is A WIP chat by MGinshe.
// Im not sure how its gona go for lag.. but.. meh

SWO.Chat = {}
SWO.Chat.Chats = {}

function SWO.Chat:Init()
	// Sorry for the lack of comments.. Ill make some later
	if( self.MainFrame ) then
		self.MainFrame = nil
	end
	self.Chats = {}
	function self:AddChat( Name, Falgs, Description )
	self.Chats[ Name ] = vgui.Create( "DPanel", self.ChatTabs )
	self.Chats[ Name ]:SetPos( 5, 5 )
	self.Chats[ Name ]:SetSize( self.ChatTabs:GetWide() - 10, self.ChatTabs:GetTall() - 70 )
	self.ChatTabs:AddSheet( Name, self.Chats[ Name ], "gui/silkicons/comment", false, false, Description )
	end

	self.MainFrame = vgui.Create( "DFrame" )
	self.MainFrame:SetPos( 0, ScrH() / 2 )
	self.MainFrame:SetSize( 500, 200 )
	self.MainFrame:SetDraggable( true )
	self.MainFrame:ShowCloseButton( false )
	self.MainFrame:SetSizable( true )
	self.MainFrame:SetTitle( "SWO Chat" )
	self.MainFrame.Paint = function()
		surface.SetDrawColor( 255, 100, 0, 155)
		surface.DrawRect( 0 , 0, self.MainFrame:GetWide(), 23 )
	end
	
	self.ChatTabs = vgui.Create( "DPropertySheet", self.MainFrame )
	self.ChatTabs:SetPos( 0, 24 )
	self.ChatTabs:SetSize( self.MainFrame:GetWide(), self.MainFrame:GetTall() - 30 )
	self.ChatTabs.Paint = function()
		
	end
	
	self.ChatTabs:AddSheet( "", self.ChatSettings, "gui/silkicons/cog", false, false, "Chat Settings" )
	self.ChatTabs:AddSheet( "", self.ChatAdd, "gui/silkicons/comment_add", false, false, "Add Chat" )
	self.AddChat( "Global", { }, "Global Chat" )
	
	
	
	self.ChatSettingsTab = vgui.Create( "DPanel", self.ChatTabs )
	self.ChatSettingsTab:SetPos( 5, 5 )
	self.ChatSettingsTab:SetSize( self.ChatTabs:GetWide() - 10, self.ChatTabs:GetTall() - 10 )
	self.ChatSettingsTab.Paint = function()
		
		
	end
	
	self.ChatAddTab = vgui.Create( "DPanel", self.ChatTabs )
	self.ChatAddTab:SetPos( 5, 5 )
	self.ChatAddTab:SetSize( self.ChatTabs:GetWide() - 10, self.ChatTabs:GetTall() - 10 )
	self.ChatAddTab.Paint = function()
		
		
	end
end
concommand.Add( "StartSWOChat", SWO.Chat:Init )

function GM:StartChat()
	
	
end
function GM:FinishChat()
	
	
end
function GM:ChatTextChanged()
	
	
end
function GM:ChatText()
	
	
end







	