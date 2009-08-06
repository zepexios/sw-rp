
function EFFECT:Init( data )

	self.Pos = data:GetOrigin()
	self.Normal = data:GetNormal()
	
	local emitter = ParticleEmitter( self.Pos )
	for i=1,30 do
		local particle = emitter:Add( "effects/blueflare1", self.Pos )
		particle:SetStartSize( math.Rand(3,6) )
		particle:SetEndSize( 0 )
		particle:SetColor( 255, 255, 255 )
		particle:SetStartAlpha( 200 )
		particle:SetEndAlpha( 0 )
		particle:SetDieTime( 3 )
		particle:SetVelocity( VectorRand() * 25 )
		particle:SetRoll( math.Rand(0,360) )
		particle:SetRollDelta( math.Rand(-20,20) )
		
		particle:SetAirResistance( 50 )
		particle:SetGravity( self.Normal * math.Rand(-50,50) )
		particle:SetCollide( true )
		particle:SetBounce( 0.2 )
	end
	emitter:Finish( )
	
end

function EFFECT:Think( )
	return false
end

function EFFECT:Render( )

end

