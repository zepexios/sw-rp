--[[------------------------NOTE----------------------------------
	Polkm: This file is for functions that add huf elements to the screen
--------------------------NOTE----------------------------------]]



function GM:HUDShouldDraw( name )											
	for k, v in pairs{ "CHudHealth" } do 
		if name == v then return false end
	end
end

function GM:HUDPaint()
GAMEMODE:HUDDrawTargetID() 
	//draw.RoundedBox( Number Bordersize, Number X, Number Y, Number Width, Number Height, Table Color )
	local Health = client:Health() //If you don't get it every frame, it will only show the value that was active when the script started running.
	local Armor = client:Armor() //Same for this.
	draw.RoundedBox( 4, 5, 5, 200, 130, Color(105, 105, 105, 255)) //Keep the rounding at a multiple of 2 (not an odd number) otherwise it shows up weird.
	draw.RoundedBox( 4, 10, 5, math.Clamp(Health, 0, 1000), 50, Color( 178, 34, 34, 255))
	draw.RoundedBox( 4, 10, 60, math.Clamp(Armor, 0, 1000), 50, Color( 0, 0, 205, 255))
	//draw.SimpleText( String Text, String Font, Number X, Number Y, Table Colour, Number Xalign, Number Yalign )
	draw.SimpleText( team.GetName( client:Team() ), "Arial", 10, 110, Color(100, 149, 237, 255), 0, 1 )
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
				if( LocalPlayer():GetEyeTrace().Entity = v ) then
					// Draw stuff on the player you're looking at
					
				end
			end
		end
	end
end

hook.Add("HUDShouldDraw", "hidehud", hidehud)
hook.Add("HUDPaint", "DrawHud", DrawHud)
