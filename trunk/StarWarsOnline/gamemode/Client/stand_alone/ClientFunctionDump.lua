// If you have a more appropriate File Name/Place to put this, feel free to do so.
// Misc functions by MGinshe. SWO Functions ONLY! No Default GMod Func's
// Make sure you create the function is the global SWO table ( I.E. no "SWO.MyTable:FunctionName()" 
//Shit. Doing so will make the function un-accesable to any other files  )

SWO.FunctionDump = {}

function SWO:PopupWindow( Title, Text, Fade, Font )
	if( Font ) then
		if( Font == "_" ) then
		
		else
			TheFont = true 
		end
		if( TheFont ) then
			surface.SetFont( TheFont )
		end
	end
	local TheTextHeight = 0
	local TheTextWidth = )
	for _, LoopText in pairs( Text ) do
		local CurWidth, CurHeight = surface.GetTextSize( LoopText )
		TheTextHeight = TheTextHeight + CurHeight + 5
		if( CurWidth > TheTextWidth ) then
			TheTextWidth = CurWidth
		end
	end
	
	local MainHeight = 23 + TheTextHeight + 35 + 5 + 5 + 5 + 10	// Main Height = that little bar at the top + The Total Text Height + 35 ( Button Height ) + 5 + 5 + 5 ( Padding ) + 10 ( Text Padding )
	local MaingWidth = TheTextWidth + 5 + 5 + 10 			// Main Width = Total Text Width + 5 + 5 ( Padding ) + 10 ( Text Padding )
	
	SWO.FunctionDump.PopUp = vgui.Create( "DFrame" )
	SWO.FunctionDump.PopUp:SetTitle( Title )
	SWO.FunctionDump.PopUp:SetSize( MainWidth, MainHeight )
	SWO.FunctionDump.PopUp:Center()
	SWO.FunctionDump.PopUp:SetBackgroundBlur( true )
	SWO.FunctionDump.PopUp:SetVisible( true )
	SWO.FunctionDump.PopUp:SetDraggable( false )
	SWO.FunctionDump.PopUp:ShowCloseButton( false )
	
	SWO.FunctionDump.PopUpButton = vgui.Create( "DButton", SWO.FunctionDump.PopUp )
	SWO.FunctionDump.PopUpButton:SetPos( SWO.FunctionDump.PopUp:GetWide() - 75, SWO.FunctionDump.PopUp:GetTall() - 35 )
	SWO.FunctionDump.PopUpButton:SetSize( 70, 30 )
	SWO.FunctionDump.PopUpButton:SetText( " Ok " )
	SWO.FunctionDump.PopUpButton.DoClick = function()
		SWO.FunctionDump.PopUp:Close()
	end
	
	SWO.FunctionDump.PopUpPanel = vgui.Create( "DPanel", SWO.FunctionDump.PopUp )
	SWO.FunctionDump.PopUpPanel:SetPos( 5, 5 )
	SWO.FunctionDump.PopUpPanel:SetSize( TheTextWidth + 10, TheTextHeight + 10 )
	SWO.FunctionDump.PopUpPanel.Paint = function()
		local y = 5			// Y ( From top )
		for _, DrawText in pairs( Text ) do
			SWO.FunctionDump:DrawLine( 5, y, DrawText )
			local _, DrawTextHeight = surface.GetTextSize
			y = y + DrawTextHeight + 5
		end
	end
	
end
function SWO.FunctionDump:DrawLine( x, y, text )
	surface.SetTextPos( x, y )
	surface.SetTextColor( 255, 255, 255, 255 )
	surface.DrawText( text 0
end
local TestText = {
	"This is line one. Allso the first elemnt in the table",
	"This is line two. Line two is longer than line one, so the pop-up..",
	".. Will be the length of lines two ( This being line 3 )"
}
SWO:PopupWindow( "MGinshe's Test", TestText, true, "UiBold" )



