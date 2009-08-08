function GM:HUDShouldDraw( name )											
	for k, v in pairs{"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"} do
		if name == v then return false end
	end
	return true
end 

GHud = {}

local Vars =
{
	Font = "TargetID",

	Padding = 10,
	Margin = 35,

	TextSpacing = 2,
	BarSpacing = 5,

	BarHeight = 16,

	Width = 0.25
}
local Colors =
{
	Background =
	{
		Border = Color( 190, 255, 128, 255 ),
		Background = Color( 120, 240, 0, 75 )
	},
	Text =
	{
		Shadow = Color( 0, 0, 0, 200 ),
		Text = Color( 255, 255, 255, 255 )
	},
	HealthBar =
	{
		Border = Color( 255, 255, 255, 255 ),
		Background = Color( 255, 255, 255, 200 ),
		Shade = Color( 225, 225, 225, 255 ),
		Fill = Color( 0, 0, 0, 255 )
	},
	SuitBar =
	{
		Border = Color( 255, 255, 255, 255 ),
		Background = Color( 255, 255, 255, 200 ),
		Shade = Color( 225, 225, 225, 255 ),
		Fill = Color( 0, 0, 0, 255 )
	}
}


local function clr( color ) 
	return color.r, color.g, color.b, color.a
end
function GHud:PaintBar( x, y, w, h, colors, value )
	surface.SetDrawColor( clr( colors.Border ) )		-- set border draw color
	surface.DrawOutlinedRect( x, y, w, h )				-- draw the border
 
	self:PaintPanel( x, y, w, h, colors )
 
	x = x + 1											-- fix our position and size
	y = y + 1											-- the border is about 1 px
	w = w - 2											-- thick
	h = h - 2
 
	surface.SetDrawColor( clr( colors.Background ) )	-- set background color
	surface.DrawRect( x, y, w, h )						-- draw background
 
	local width = w * math.Clamp( value, 0, 1 )			-- calc bar width
	local shade = 4										-- set the shade size constant
 
	surface.SetDrawColor( clr( colors.Shade ) )			-- set shade draw color( actually, instead of shade it should be fill )
	surface.DrawRect( x, y, width, shade )				-- draw shade
 
	surface.SetDrawColor( clr( colors.Fill ) )			-- set fill color( it should be shade instead of fill )
	surface.DrawRect( x, y + shade, width, h - shade )	-- draw fill
end
function GHud:PaintPanel( x, y, w, h, colors )
 
	surface.SetDrawColor( clr( colors.Border ) )		-- set border color
	surface.DrawOutlinedRect( x, y, w, h )				-- draw border
 
	x = x + 1											-- fix positions and sizes
	y = y + 1
	w = w - 2
	h = h - 2
 
	surface.SetDrawColor( clr( colors.Background ) )	-- set background color
	surface.DrawRect( x, y, w, h )						-- and paint background
 
end
function GHud:PaintText( x, y, text, font, colors )
 
	surface.SetFont( font )								-- set text font
 
	surface.SetTextPos( x + 1, y + 1 )					-- set shadow position
	surface.SetTextColor( clr( colors.Shadow ) )		-- set shadow color
	surface.DrawText( text )							-- draw shadow text
 
	surface.SetTextPos( x, y );							-- set text position
	surface.SetTextColor( clr( colors.Text ) )			-- set text color
	surface.DrawText( text )							-- draw text
 
end
function GHud:TextSize( text, font )
 
	surface.SetFont( font );
	return surface.GetTextSize( text );
 
end
function GHud:PaintTexture( Texture, x, y, width, height )
	surface.SetTexture( Texture )
	surface.DrawTexturedRect( x, y, width, height )
end
function GM:HUDPaint( )
 
	client = client or LocalPlayer( )							-- set a shortcut to the client
	if( !client:Alive( ) ) then return end						-- don't draw if the client is dead
 
	local _, th = GHud:TextSize( "TEXT", Vars.Font )		-- get text size( height in this case )
 
	local i = 2													-- shortcut to how many items( bars + text ) we have
 
	local Width = Vars.Width * ScrW( )							-- calculate width
	local BarWidth = Width - ( Vars.Padding * i )				-- calculate bar width and element height
	local Height = ( Vars.Padding * i ) + ( th * i ) + ( Vars.TextSpacing * i ) + ( Vars.BarHeight * i ) + Vars.BarSpacing
 
	local x = Vars.Margin;										-- get x position of element
	local y = ScrH( ) - Vars.Margin - Height;					-- get y position of element
 
	local cx = x + Vars.Padding;								-- get x and y of contents
	local cy = y + Vars.Padding;
 
	GHud:PaintPanel( x, y, Width, Height, Colors.Background )	-- paint the background panel
 
	local by = th + Vars.TextSpacing;							-- calc text position
 
	local text = string.format( "Health: %iHP", client:Health( ) )	-- get health text
	GHud:PaintText( cx, cy, text, Vars.Font, Colors.Text )	-- paint health text and health bar
	GHud:PaintBar( cx, cy + by, BarWidth, Vars.BarHeight, Colors.HealthBar, client:Health( ) / 100 )
 
	by = by + Vars.BarHeight + Vars.BarSpacing			-- increment text position
 
	local Text = string.format( "Force: %iFP", client:GetForce() )
	GHud:PaintText( cx, cy + by, Text, Vars.Font, Colors.Text )	-- paint suit text and suit bar
	GHud:PaintBar( cx, cy + by + th + Vars.TextSpacing, BarWidth, Vars.BarHeight, Colors.SuitBar, client:GetForce() / client:GetMaxForce() )
	
	local Text = string.format( "Current EXP: %i/%i", client:GetXP(), client:GetNeededXP() )
	GHud:PaintText( ScrW() - string.len(Text)*9, ScrH() / 10 * 9, Text, Vars.Font, Colors.Text )
	
	local Text = string.format( "Current Level: %i", client:GetLevel() )
	GHud:PaintText( ScrW() - string.len(Text)*9, ScrH() / 10 * 9+20, Text, Vars.Font, Colors.Text )
 
end





















/*
/*
function GM:HUDShouldDraw( name )											
	for k, v in pairs{ "CHudHealth" } do 
		if name == v then return false end
	end
end


print( "ROFLROFLR" )
function GM:HUDPaint()
	print( "ROFLROFLROFLROFLROFLROFLROFLROFLROFL" )
	GAMEMODE:HUDDrawTargetID() 
	//draw.RoundedBox( Number Bordersize, Number X, Number Y, Number Width, Number Height, Table Color )
	local Health = client:Health() //If you don't get it every frame, it will only show the value that was active when the script started running.
	local Armor = client:Armor() //Same for this.
	draw.RoundedBox( 4, 5, 5, 200, 130, Color(105, 105, 105, 255)) //Keep the rounding at a multiple of 2 (not an odd number) otherwise it shows up weird.
	draw.RoundedBox( 4, 10, 5, math.Clamp(Health, 0, 1000), 50, Color( 178, 34, 34, 255))
	draw.RoundedBox( 4, 10, 60, math.Clamp(Armor, 0, 1000), 50, Color( 0, 0, 205, 255))
	//draw.SimpleText( String Text, String Font, Number X, Number Y, Table Colour, Number Xalign, Number Yalign )
	draw.SimpleText( team.GetName( client:Team() ), "Arial", 10, 110, Color(100, 149, 237, 255), 0, 1 )
	
		client = client or LocalPlayer( )							-- set a shortcut to the client
	if( !client:Alive( ) ) then return end						-- don't draw if the client is dead
 
	local _, th = SWO.Hud:TextSize( "TEXT", Vars.Font )		-- get text size( height in this case )
 
	local i = 2													-- shortcut to how many items( bars + text ) we have
 
	local Width = Vars.Width * ScrW( )							-- calculate width
	local BarWidth = width - ( Vars.Padding * i )				-- calculate bar width and element height
	local Height = ( Vars.Padding * i ) + ( th * i ) + ( Vars.textSpacing * i ) + ( Vars.barHeight * i ) + Vars.barSpacing
 
	local x = Vars.Margin;										-- get x position of element
	local y = ScrH( ) - Vars.Margin - Deight;					-- get y position of element
 
	local cx = x + Vars.Padding;								-- get x and y of contents
	local cy = y + Vars.Padding;
 
	SWO.Hud:PaintPanel( x, y, Width, Height, Colors.Background )	-- paint the background panel
 
	local by = th + Vars.TextPacing;							-- calc text position
 
	local text = string.format( "Health: %iHP", client:Health( ) )	-- get health text
	SWO.Hud:PaintText( cx, cy, text, Vars.Font, Colors.Text )	-- paint health text and health bar
	SWO.Hud:PaintBar( cx, cy + by, BarWidth, Vars.BarHeight, Colors.HealthBar, client:Health( ) / 100 )
 
	by = by + Vars.BarHeight + Vars.BarSpacing			-- increment text position
 
	local Text = string.format( "Suit: %iSP", client:Armor( ) )	-- get suit text
	SWO.Hud:PaintText( cx, cy + by, Text, Vars.Font, Colors.Text )	-- paint suit text and suit bar
	SWO.Hud:PaintBar( cx, cy + by + th + Vars.TextSpacing, BarWidth, Vars.BarHeight, Colors.SuitBar, client:Armor( ) / 100 )
	
	SWO.Hud:PaintText( ScrW() / 10 * 9, ScrH() / 10 * 9, client:GetForce(), Vars.Font, Colors.Text )
end

function GM:HUDDrawTargetID()

	for k, v in pairs(player.GetAll()) do								//Gets ALL the players on the server
		if(v != LocalPlayer()) then										//If the player insnt you (LocalPlayer())
			if( v:Alive() ) then										//If they are alive
				local alpha = 0											//Defauly Alpha = 0
				local position = v:GetPos( )							//Where are they
				local position = Vector( position.x, position.y, position.z + 75 )
				local screenpos = position:ToScreen( ) 					//Puts the position of the hud element on the screen 
				local dist = position:Distance( LocalPlayer( ):GetPos( ) )	//how far away from you?
				local dist = dist / 2									//divide Distance by 2
				local dist = math.floor( dist )							//Floor Distance
				
				if( dist > 150 ) then									//If Distance is Greater than 100
					alpha = 255 - ( dist - 100 )						//Set our alpha to 255 - Dist - 100 (slowly fade them out after100 units)
				else
					alpha = 255											//Otherqise, set alpha to 255
				end
				if( alpha > 255 ) then									//If somehow we go over 255 Alpha, set it back to 255
					alpha = 255
				elseif( alpha < 0 ) then								//If somehow we go under 0 Alpha, set it back to 0
					alpha = 0
				end
																		//VV
				draw.DrawText( v:Nick( ), "DefaultSmall", screenpos.x, screenpos.y, Color( 255, 255, 255, alpha ), 1 )
				draw.DrawText( team.GetName( v:Team( ) ), "DefaultSmall", screenpos.x, screenpos.y + 10, Color( 255, 255, 255, alpha ), 1 )
				
				if( v:GetNWInt( "chatopen" ) == 1 ) then
					draw.DrawText( "Typing..", "ChatFont", screenpos.x, screenpos.y - 50, Color( 255, 255, 255, alpha ), 1 )
				end
				if( LocalPlayer():GetEyeTrace().Entity == v ) then
					// Draw stuff on the player you're looking at
					if( v:GetNWBool( "InfoEnabled" ) ) then
						print( "Lol" )
					else
						print( "Oh my jesus it works! :D" )
					end
				end
			end
		end
	end
end
SWO.Hud = {}

local Vars =
{
	Font = "TargetID",

	Padding = 10,
	Margin = 35,

	TextSpacing = 2,
	BarSpacing = 5,

	BarHeight = 16,

	Width = 0.25
}
local Colors =
{
	Background =
	{
		Border = Color( 190, 255, 128, 255 ),
		Background = Color( 120, 240, 0, 75 )
	},
	Text =
	{
		Shadow = Color( 0, 0, 0, 200 ),
		Text = Color( 255, 255, 255, 255 )
	},
	HealthBar =
	{
		Border = Color( 255, 255, 255, 255 ),
		Background = Color( 255, 255, 255, 200 ),
		Shade = Color( 225, 225, 225, 255 ),
		Fill = Color( 0, 0, 0, 255 )
	},
	SuitBar =
	{
		Border = Color( 255, 255, 255, 255 ),
		Background = Color( 255, 255, 255, 200 ),
		Shade = Color( 225, 225, 225, 255 ),
		Fill = Color( 0, 0, 0, 255 )
	}
}

local function clr( color ) 
	return color.r, color.g, color.b, color.a
end
function SWO.Hud:PaintBar( x, y, w, h, colors, value )
	surface.SetDrawColor( clr( colors.border ) )		-- set border draw color
	surface.DrawOutlinedRect( x, y, w, h )				-- draw the border
 
	self:PaintPanel( x, y, w, h, colors )
 
	x = x + 1											-- fix our position and size
	y = y + 1											-- the border is about 1 px
	w = w - 2											-- thick
	h = h - 2
 
	surface.SetDrawColor( clr( colors.background ) )	-- set background color
	surface.DrawRect( x, y, w, h )						-- draw background
 
	local width = w * math.Clamp( value, 0, 1 )			-- calc bar width
	local shade = 4										-- set the shade size constant
 
	surface.SetDrawColor( clr( colors.shade ) )			-- set shade draw color( actually, instead of shade it should be fill )
	surface.DrawRect( x, y, width, shade )				-- draw shade
 
	surface.SetDrawColor( clr( colors.fill ) )			-- set fill color( it should be shade instead of fill )
	surface.DrawRect( x, y + shade, width, h - shade )	-- draw fill
end
function SWO.Hud:PaintPanel( x, y, w, h, colors )
 
	surface.SetDrawColor( clr( colors.border ) )		-- set border color
	surface.DrawOutlinedRect( x, y, w, h )				-- draw border
 
	x = x + 1											-- fix positions and sizes
	y = y + 1
	w = w - 2
	h = h - 2
 
	surface.SetDrawColor( clr( colors.background ) )	-- set background color
	surface.DrawRect( x, y, w, h )						-- and paint background
 
end
function SWO.Hud:PaintText( x, y, text, font, colors )
 
	surface.SetFont( font )								-- set text font
 
	surface.SetTextPos( x + 1, y + 1 )					-- set shadow position
	surface.SetTextColor( clr( colors.shadow ) )		-- set shadow color
	surface.DrawText( text )							-- draw shadow text
 
	surface.SetTextPos( x, y );							-- set text position
	surface.SetTextColor( clr( colors.text ) )			-- set text color
	surface.DrawText( text )							-- draw text
 
end
function SWO.Hud:TextSize( text, font )
 
	surface.SetFont( font );
	return surface.GetTextSize( text );
 
end
function SWO.Hud:PaintTexture( Texture, x, y, width, height )
	surface.SetTexture( Texture )
	surface.DrawTexturedRect( x, y, width, height )
end
*/