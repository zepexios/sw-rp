function hidehud(name)
	for k, v in pairs{"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"} do
		if name == v then return false end
	end
end
hook.Add("HUDShouldDraw", "hidehud", hidehud)

function DrawHud()

	health = LocalPlayer():Health()
	draw.RoundedBox( 2, 3, 6, 300, 15, Color( 51, 50, 0, 150 ) )
	draw.RoundedBox( 2, 4, 7, health, 12, Color( 255, 0, 0, 255 ) )
	
end
hook.Add("HUDPaint", "DrawHud", DrawHud)

function DrawPlayerInfo( )

	for k, v in pairs( player.GetAll( ) ) do	
	
		if( v != LocalPlayer( ) ) then
		
			if( v:Alive( ) ) then
			
				local alpha = 0
				local position = v:GetPos( )
				local position = Vector( position.x, position.y, position.z + 75 )
				local screenpos = position:ToScreen( )
				local dist = position:Distance( LocalPlayer( ):GetPos( ) )
				local dist = dist / 2
				local dist = math.floor( dist )
				
				if( dist > 100 ) then
				
					alpha = 255 - ( dist - 100 )
					
				else
				
					alpha = 255
					
				end
				
				if( alpha > 255 ) then
				
					alpha = 255
					
				elseif( alpha < 0 ) then
				
					alpha = 0
					
				end
				
				draw.DrawText( v:Nick( ), "DefaultSmall", screenpos.x, screenpos.y, Color( 255, 255, 255, alpha ), 1 )
				draw.DrawText( team.GetName( v:Team( ) ), "DefaultSmall", screenpos.x, screenpos.y + 10, Color( 255, 255, 255, alpha ), 1 )
				draw.DrawText( v:GetNWString( "title" ), "DefaultSmall", screenpos.x, screenpos.y + 20, Color( 255, 255, 255, alpha ), 1 )
				
				if( v:GetNWInt( "chatopen" ) == 1 ) then
				
					draw.DrawText( "Typing..", "ChatFont", screenpos.x, screenpos.y - 50, Color( 255, 255, 255, alpha ), 1 )
					
				end
				
			end
			
		end
		
	end
	
end
