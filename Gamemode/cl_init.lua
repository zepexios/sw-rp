include( 'shared.lua' )
include( 'cl_weather.lua' )
include( 'cl_hud.lua' )
include( 'login.lua' )
function sw_menu() 

local DermaPanel = vgui.Create( "DFrame" )
DermaPanel:SetPos( 50,50 )
DermaPanel:SetSize( 150, 200 )
DermaPanel:SetTitle( "Menu" )
DermaPanel:SetVisible( true )
DermaPanel:SetDraggable( true )
DermaPanel:ShowCloseButton( true )
DermaPanel:SetMouseInputEnabled(true)
DermaPanel:SetKeyboardInputEnabled(true)
DermaPanel:MakePopup()
end
 
local MenuButton = vgui.Create("DButton")
MenuButton:SetParent( DermaPanel )
MenuButton:SetText( "Menu >" )
MenuButton:SetPos(25, 50)
MenuButton:SetSize( 100, 125 )
MenuButton.DoClick = function ( btn )
    local MenuButtonOptions = DermaMenu() -- Creates the menu
    MenuButtonOptions:AddOption("Quit", function() RunConsoleCommand("disconnect") end ) -- Add options to the menu
    MenuButtonOptions:AddOption("Skills", function() RunConsoleCommand("sw_skills") end )
    MenuButtonOptions:AddOption("Attributes", function() RunConsoleCommand("Attributes") end )
    MenuButtonOptions:AddOption("Check Force Sensitivity", function() RunConsoleCommand("Check") end )
    MenuButtonOptions:AddOption("Bug Report", function() RunConsoleCommand("Reportbug") end )
    MenuButtonOptions:Open() -- Open the menu AFTER adding your options
end

function GM:SWAttributes( ply )
local DermaPanel = vgui.create( "DFrame" )
DermaPanel:SetPos( 50, 50 )
DermaPanel:SetSize( 250, 325 )
DermaPanel:SetTitle( "Attributes" )
DermaPanel:SetVisible( true )
DermaPanel:SetDraggable( true )
DermaPanel:ShowCloseButton( true )
DermaPanel:MakePopup()

local PropertySheet = vgui.Create ( "DPropertySheet" ) ////////////////////////////////////////////////////////////////
PropertySheet:SetParent( DermaPanel )                  // This is just a base for when the values actually get implemented not guranteed to work but is a start.
PropertySheet:SetPos ( 5, 30 )                         //////////////////////////////////////////////////////////////////////////////////////
PropertySheet:SetSize ( 500, 300 )

local SheetItemOne = vgui.Create( "DCheckBoxLabel" )
SheetItemOne:SetText( "Name" )
SheetItemOne:SizeToContents()

local SheetItemTwo = vgui.Create( "DCheckBoxLabel" )
SheetItemTwo:SetText( "Use SENTs?" )
SheetItemTwo:SetConVar( "some_convar" )
SheetItemTwo:SetValue( 1 )
SheetItemTwo:SizeToContents()

PropertySheet:AddSheet( "Main", SheetItemOne, false, false, false, "Main Page" )
PropertySheet:AddSheet( "Jobs", SheetItemTwo, false, false, false, "Jobs" ) 

Dlabel = vgui.Create("DLabel" , Main)
Dlabel:SetText( ply:Nick() )
Dlabel:SizeToContents()

Dlabel = vgui.Create("DLabel" , Jobs)
Dlabel:SetText( GM:Team() )
Dlabel:SizeToContents()
end

function GM:SWSkills( ply )
end

function force( ply )
end

function bug( ply )
end

concommand.Add("sw_menu", sw_menu)
concommand.Add("sw_skills", GM.SWSkills)

















