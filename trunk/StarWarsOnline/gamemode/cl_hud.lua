--[[------------------------NOTE----------------------------------
	Polkm: This file is for functions that add huf elements to the screen
--------------------------NOTE----------------------------------]]

function hidehud(name)													//Hides the normal HUD
	for k, v in pairs{"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"} do
		if name == v then return false end
	end
end
function DrawHud()														//Draws our new HUD

	Health = LocalPlayer():Health()										//Gets the playerd Health
	draw.RoundedBox( 4, 3, 6, 100, 15, Color( 50, 205, 50, 100 ))		//position of box where the health goes  -- the hud is really basic I would like a custom chat and other features if possible.
	draw.RoundedBox( 4, 4, 7, Health, 12, Color( 255, 0, 0, 255 ))		//our health bar
    
	Armor = LocalPlayer():Armor()										//Gets the players Armour
	draw.RoundedBox( 4, 10, 20, 100, 15, Color( 50, 205, 50, 100))		//position of where armor goes
	draw.RoundedBox( 4, 11, 21, Armor, 12, Color( 65, 105, 225, 255))	//our armor bar
	DrawPlayerInfo( )													//Omg...if this was it...DAMN..Nvm ..MGinshe..

end
function DrawPlayerInfo( )												//Draws text above other players' heads ( Name, Faction, and Guild and Class if on your Faction)

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
				draw.DrawText( v:GetNWString( "title_"..v:SteamID() ), "DefaultSmall", screenpos.x, screenpos.y + 20, Color( 255, 255, 255, alpha ), 1 )
				
				if( v:GetNWInt( "chatopen" ) == 1 ) then
					draw.DrawText( "Typing..", "ChatFont", screenpos.x, screenpos.y - 50, Color( 255, 255, 255, alpha ), 1 )
				end
			end
		end
	end
end
hook.Add("HUDShouldDraw", "hidehud", hidehud)
hook.Add("HUDPaint", "DrawHud", DrawHud)
