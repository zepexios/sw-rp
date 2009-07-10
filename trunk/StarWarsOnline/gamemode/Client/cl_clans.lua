SWO.Clans = {}

function SWO.LoadClans()

end

SWO.Clans.Banther.Image 				= "Banther's/Banther.vtf"
SWO.Clans.Banther.Name 					= "The Banther's"
SWO.Clans.Banther.ply:SteamID() 		= true
SWO.Clans.Banther.ply:SteamID().Rank 	= 1
SWO.Clans.Banther.ply:SteamI().Title	= "Master"

function QMenu(  )
	ply = LocalPlayer
	local QMenu = vgui.Create( "DPropertySheet" )
	QMenu:SetParent( DermaPanel )
	QMenu:SetPos( ScrH() - 50, ScrW() - 50 )
	QMenu:SetSize( ScrH() - 100, ScrW() - 100 )
 
	local User = vgui.Create( "DFrame" )
	User:SetText( "Use Props?" )
	User:SetConVar( "some_convar" )
	User:SetValue( 1 )
	User:SizeToContents()
	
	ClanPosW, ClanPosH = ScrW() - 110, ScrH() - 130
	ClanPosW1 = ScrW() - 210
 
	local Clan = vgui.Create( "DFrame" ) 		//Draws the Clans Graphic and Info.
	for k,v in pairs(SWO.Clans) do
		if(Clans.Members.ply:SteamID()) then
			local Name = vgui.Create("DImage", Clan)
			Name:SetPos( ClanPosW, ClanPosH )
			Name:SetImage( "VGUI/Clans/" ..SWO.Clans.k.Image )
			ClanPosH = ClanPosH - 100
			surface.SetFont( "default" )
			surface.SetTextColor( 255, 255, 255, 255 )
			surface.SetTextPos( ClanPosH1, ClanPosW - 85 )
			surface.DrawText(  "Clan Name:				" ..i.Name)
			surface.SetTextPos( ClanPosH1 - 5, ClanPosW - 85 )
			surface.DrawText(  "Clan Title:				" ..i.ply:SteamID().Title)
			surface.SetTextPos( ClanPosH1 - 10, ClanPosW - 85 )
			surface.DrawText(  "Clan Rank:				" ..i.ply:SteamID().Rank)
			
		end
	end
	PropertySheet:AddSheet( "User", User, "gui/silkicons/user", false, false, "Personal User Settings" )
	PropertySheet:AddSheet( "Clan", Clan, "gui/silkicons/group", false, false, "Clan Settings" )
	
end
concommand.Add( "SwoMenu", QMenu )