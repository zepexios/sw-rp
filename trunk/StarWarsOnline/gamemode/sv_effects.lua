function LevelUpEffect(playerpos)
	local vPoint = playerpos
	local effectdata = EffectData()
	effectdata:SetStart( vPoint ) // not sure if we need a start and origin (endpoint) for this effect, but whatever
	effectdata:SetOrigin( vPoint )
	effectdata:SetScale( 1 )
	util.Effect( "levelup", effectdata )	
end