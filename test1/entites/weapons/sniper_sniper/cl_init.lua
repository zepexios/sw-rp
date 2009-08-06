include('shared.lua')

function SWEP:DrawHUD()

	if(Zoom > 1) then
			local ScW, ScH, ScopeId
			
			ScW = surface.ScreenWidth()
			ScH = surface.ScreenHeight()
			
			
			ScopeId = surface.GetTextureID("gmod/scope")
			surface.SetTexture(ScopeId)
			
			QuadTable = {}
			
			QuadTable.texture 	= ScopeId
			QuadTable.color		= Color( 255, 255, 255, 255 )
			
			QuadTable.x = 0
			QuadTable.y = 0
			QuadTable.w = ScW
			QuadTable.h = ScH	
			draw.TexturedQuad( QuadTable )
	end
		
end