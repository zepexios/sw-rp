function GM:KeyPress( ply, KEY )
	if( KEY == IN_JUMP ) then
		if( ply:GetClass() == CLASS_JEDI ) then
			ply.ConstJump = true
			if( ply:IsOnGround() ) then
				ply.JumpPhase = 1
			elseif( ply:GetForce() >= 25 and ply.JumpPhase == 1 ) then
				ply.NoFallDamage = true
				ply:TakeForce( 25 )
				ply:SetVelocity( ply:GetUp() * 350 )
				ply:EmitSound( "force/jump.wav" )
				timer.Create( "ForceJumpConstTimer", 0.01, 0, function()
					if( ( ply:GetForce() < 5 ) or !ply.ConstJump ) then
						ply:PrintMessage( HUD_PRINTCENTER, "No moar jump :C" )
						ply:SetVelocity( Vector( 0, 0, 0 ) )
						timer.Destroy( "ForceJumpConstTimer" )
						ply:TakeForce( 0 )
						ply.JumpPhase = false
					end
					ply:TakeForce( ply.Char.TakeForce, true )
					ply:SetVelocity( ply:GetUp() * 10 )
				end )
				ply.JumpPhase = 2
			elseif( ply:GetForce() >= 5 and ply.JumpPhase == 2 ) then
				timer.Create( "ForceJumpConstTimer", 0.01, 0, function()
					if( ( ply:GetForce() < 5 ) or !ply.ConstJump ) then
						ply:PrintMessage( HUD_PRINTCENTER, "No moar jump :C" )
						ply:SetVelocity( Vector( 0, 0, 0 ) )
						timer.Destroy( "ForceJumpConstTimer" )
						ply:TakeForce( 0 )
					end
					ply:TakeForce( ply.Char.TakeForce, true )
					ply:SetVelocity( ply:GetUp() * 10 )
				end )
			end
		end
	elseif( KEY == IN_SPEED and ply:KeyDown( IN_FORWARD ) ) then
		ply.ConstSprint = true
		if( ply:GetClass() == CLASS_JEDI ) then
			if( ply:GetForce() >= 10 and !ply:IsOnGround() ) then
			elseif( ply:GetForce() >= 10 and ply:IsOnGround() ) then
				ply:EmitSound( "force/speed.wav" )
				timer.Create( "ForceSprintConstTimer", 0.01, 0, function()
					if( ( ply:GetForce() < 5 ) or !ply.ConstSprint or !ply:IsOnGround() ) then
						ply:PrintMessage( HUD_PRINTCENTER, "No moar force :S" )
						ply:SetVelocity( Vector( 0, 0, 0 ) )
						timer.Destroy( "ForceSprintConstTimer" )
						ply:TakeForce( 0 )
					end
					ply:TakeForce( ply.Char.TakeForce, true )
					ply:SetVelocity( ply:GetForward() * 200 )
				end )
			end
		end
	end
end

function GM:KeyRelease( ply, KEY )
	if( KEY == IN_SPEED ) then
		ply.ConstSprint = false
		timer.Destroy( "ForceSprintConstTimer" )
	end
	if( KEY == IN_JUMP ) then
		ply.ConstJump = false
		timer.Destroy( "ForceJumpConstTimer" )
	end
end

function GM:EntityTakeDamage( ent, inflictor, attacker, amount, dmginfo )
	if( ent:IsPlayer() and dmginfo:IsFallDamage() and ent.NoFallDamage ) then
		return true
	end
end

function GM:OnPlayerHitGround( ply )
	ply.NoFallDamage = false
end
