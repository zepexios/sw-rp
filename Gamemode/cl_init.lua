include( 'shared.lua' )
include( 'cl_weather.lua' )
include( 'cl_hud.lua' )
include( 'login.lua' )
/************************NOTE!*********************************
 *
 *my login system is gona go thru a majour re-do (wont take long)
 *so that i can delete Characters, create character, and select Character.
 *sorry about the HUGE "NOTE!" abnner, but it looks cool and if any of you
 *edit this file you will surely see it :D Fell free to overwirte if everyone 
 *who needs to know, knows
 *
 *cya's on wednesday...:)
 * ..MGinshe..
 ***************************************************************/
function SWmenu()
local DermaPanel = vgui.Create( "DFrame" )
DermaPanel:SetPos( ScrH() - 20, ScrW() - 20 ) // you only have the Height value? ima change that...and testing placing soz ..MGinshe..
DermaPanel:SetSize( 150, 200 )  -- wonder what happens if we comment this out // baad things :D
DermaPanel:SetTitle( "Menu" )
DermaPanel:SetVisible( true )
DermaPanel:SetDraggable( true )
DermaPanel:ShowCloseButton( true )
DermaPanel:SetMouseInputEnabled(true)
DermaPanel:SetKeyboardInputEnabled(true)
DermaPanel:MakePopup()
end

function sw_menu() 
local MenuButton = vgui.Create("DButton")
MenuButton:SetParent( DermaPanel )
MenuButton:SetText( "Menu >" )
MenuButton:SetPos(ScrH() / 2, ScrW() / 2 )
MenuButton:SetSize( 100, 125 )
MenuButton.DoClick = function ( btn )
    local MenuButtonOptions = DermaMenu() -- Creates the menu
    MenuButtonOptions:AddOption("Quit", function() RunConsoleCommand("disconnect") end ) -- Add options to the menu
    MenuButtonOptions:AddOption("Skills", function() RunConsoleCommand("sw_skills") end ) //  chunk has too many syntax levels unsure why console is saying this//i think its because "SWSkills" is in like 5 Syntax lvls? ..MGinshe..
    MenuButtonOptions:AddOption("Attributes", function() RunConsoleCommand("Attributes") end )
    MenuButtonOptions:AddOption("Check Force Sensitivity", function() RunConsoleCommand("Check") end )
    MenuButtonOptions:AddOption("Bug Report", function() RunConsoleCommand("Reportbug") end )
    MenuButtonOptions:Open() -- Open the menu AFTER adding your options
end
end

function GM:SWAttributes( ply )
end

function GM:SWSkills( ply )
end

function force( ply )
end

function bug( ply )
end

function sw_start()
local StarwarsPanel = vgui.Create( "DFrame" ) -- creates the frame itself
StarwarsPanel:SetPos( 50, 50 ) -- Position on the players screen
StarwarsPanel:SetSize( 1000, 900 ) -- size of the frame
StarwarsPanel:SetTitle( "Welcome To SW Online!" ) -- title of the frame
StarwarsPanel:SetVisible( true ) -- whether we can see it or not
StarwarsPanel:SetDraggable( true ) -- can you drag the frame by mouse?
StarwarsPanel:ShowCloseButton( true ) -- Show the close button?
StarwarsPanel:MakePopup() -- Show the frame 

local StarwarsButton = vgui.Create( "DButton" )
StarwarsButton:SetParent( StarwarsPanel ) // set parent to our StarwarsPanel
StarwarsButton:SetText( "Create New Character" )
StarwarsButton:SetPos( 80, 80 )
StarwarsButton:SetSize( 50, 80 )
StarwarsButton.DoClick = function ( sw_character ) // MG you will have to write the function to go with your login screen. // kay kay ..Mginshe..

local StardelButton = vgui.Create( "DButton" )
StardelButton:SetParent( StarwarsPanel ) // set parent to our StarwarsPanel
StardelButton:SetText( "Delete Character" )
StarwarsButton:SetPos( 80, 120 )
StarwarsButton:SetSize( 50, 80 )
StarwarsButton.DoClick = function ( sw_delcharacter ) // again you will have to write the function to delete the character

local StarstartButton = vgui.Create( "DButton" )
StarstartButton:SetParent( StarwarsPanel ) // set parent to our StarwarsPanel
StarstartButton:SetText( "Play!" )
StarstartButton:SetPos( 100, 100 )
StarstartButton:SetSize( 50, 80 )
StarwarsButton.DoClick = function ( sw_selectcharacter ) // you will have to write the function this panel is designed to work with your login script if possible if needed make changes.
end
end // Ummm....are all these "end"s ment to be here...? that wont work, i think D: ..MGinshe..
end
end


function sw_character() 
end

function sw_delcharacter()
end

function sw_selectcharacter()
end
// design to come up if the player presses new character
concommand.Add("sw_menu", sw_menu)
concommand.Add("sw_start", sw_start)


















