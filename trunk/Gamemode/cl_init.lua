include( 'shared.lua' )
include( 'cl_weather.lua' )
include( 'cl_hud.lua' )

local DermaPanel = vgui.Create( "DFrame" )
DermaPanel:SetPos( 50,50 )
DermaPanel:SetSize( 150, 200 )
DermaPanel:SetTitle( "Menu" )
DermaPanel:SetVisible( true )
DermaPanel:SetDraggable( true )
DermaPanel:ShowCloseButton( false )
DermaPanel:SetMouseInputEnabled(true)
DermaPanel:SetKeyboardInputEnabled(true)
DermaPanel:MakePopup()
 
local MenuButton = vgui.Create("DButton")
MenuButton:SetParent( DermaPanel )
MenuButton:SetText( "Menu >" )
MenuButton:SetPos(25, 50)
MenuButton:SetSize( 100, 125 )
MenuButton.DoClick = function ( btn )
    local MenuButtonOptions = DermaMenu() -- Creates the menu
    MenuButtonOptions:AddOption("Quit", function() RunConsoleCommand("disconnect") end ) -- Add options to the menu
    MenuButtonOptions:AddOption("Skills", function() RunConsoleCommand("Skills") end )
    MenuButtonOptions:AddOption("Attributes", function() RunConsoleCommand("Attributes") end )
    MenuButtonOptions:AddOption("Check Force Sensitivity", function() RunConsoleCommand("Check") end )
    MenuButtonOptions:AddOption("Bug Report", function() RunConsoleCommand("Reportbug") end )
    MenuButtonOptions:Open() -- Open the menu AFTER adding your options
end

function login( ply )
end

function attributes( ply )
end

function skills( ply )
local DermaPanel = vgui.create( "DFrame" )
DermaPanel:SetPos( 50, 50 )
DermaPanel:SetSize( 200, 250 )
DermaPanel:SetTitle( "Skills" )
DermaPanel:SetVisible( true )
DermaPanel:SetDraggable( true )
DermaPanel:ShowCloseButton( true )
DermaPanel:MakePopup()

local PropertySheet = vgui.Create( "DPropertySheet" )         // console command does not work for some reason
PropertySheet:SetParent( DermaPanel )
PropertySheet:SetPos( 5, 30 )
PropertySheet:SetSize( 340, 315 )

local SheetItemOne = cgui.Create( "DListView" )
SheetItemOne:SetParent (DermaPanel)
SheetItemOne:AddColumn( "Current Rifle XP" )
SheetItemOne:AddColumn( "Rifle XP To Go Till Skill Point" )
concommand.Add("sw_skills", skills)
end

function force( ply )
end

function bug( ply )
end




