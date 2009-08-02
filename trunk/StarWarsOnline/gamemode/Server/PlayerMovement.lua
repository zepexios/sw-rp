function GM:KeyPress( ply, KEY )
	if( KEY == IN_JUMP ) then
		if( ply:GetClass() == CLASS_JEDI ) then
			if( ply:GetForce() >= 30 and ply:WaterLevel() <= 1 and ply:IsOnGround() ) then
			elseif( ply:GetForce() >= 30 ) then
				ply.NoFallDamage = true
				ply:TakeForce( 30 )
				ply:SetVelocity( ply:GetUp() * 700 )
				ply.LastForceJump = ply.LastForceJump + 84
			end
		end
	elseif( KEY == IN_SPEED ) then
		ply.ConstSprint = true
		if( ply:GetClass() == CLASS_JEDI ) then
			if( ply:GetForce() >= 10 and !ply:IsOnGround() ) then
			elseif( ply:GetForce() >= 10 and ply:IsOnGround() ) then
				print( "Lolwtf?" )
				timer.Create( "ForceSprintLengthTimer", 0.01, 0, function()
					if( ( ply:GetForce() < 5 ) or ( !ply.ConstSprint ) or ( !ply:IsOnGround() ) ) then
						ply:PrintMessage( HUD_PRINTCENTER, "No moar force :S" )
						ply:SetVelocity( Vector( 0, 0, 0 ) )
						print( "Ended" )
						timer.Destroy( "ForceSprintLengthTimer" )
						ply:TakeForce( 0 )
					end
					ply:TakeForce( 1, true )
					ply:SetVelocity( ply:GetForward() * 250 )
					ply.InSprint = true
				end )
			end
		end	
	end
end

function GM:KeyRelease( ply, KEY )
	if( KEY == IN_SPEED ) then
		ply.ConstSprint = false
	end
	if( KEY == IN_JUMP ) then
		ply.ConstJump = false
	end
end

function GM:EntityTakeDamage( ent, inflictor, attacker, amount, dmginfo )
	if( ent:IsPlayer() and dmginfo:IsFallDamage() and ent.NoFallDamage ) then
		return false
	end
end

function GM:OnPlayerHitGround( ply )
	ply.NoFallDamage = false
end




