function GM:KeyPress( ply, KEY )
	ply.JumpedLocked = ply.JumpedLocked or false;
	 --lock jumping so players cant float
	if ply:GetForce() == ply:GetMaxForce() then ply.JumpedLocked = false; end
	ply.gravity = ply.gravity or 0
	if( KEY == IN_JUMP and not ply.JumpedLocked) then
		if( ply:GetClass() == CLASS_JEDI ) then
			ply.ConstJump = true
			if( ply:IsOnGround() ) then
			elseif( ply:GetForce() >= 25 ) then
				timer.Destroy( "ForceBackUpTimer" )
				ply.NoFallDamage = true
				ply:TakeForce( 25 , true)
				ply:SetVelocity( ply:GetUp() * 350 )
				ply:EmitSound( "SWO/force/jump.wav" ) --@meeces2911 Updated sound path
				timer.Create( "ForceJumpConstTimer", 0.1, 0, function()
					if( ( ply:GetForce() < 5 ) or !ply.ConstJump ) then
						ply.JumpedLocked = true
						ply:PrintMessage( HUD_PRINTCENTER, "No moar jump :C" )
						ply:SetVelocity( Vector( 0, 0, 0 ) )
						ply:TakeForce( 0 )
					else
						if ply.JumpedLocked then return end
						ply:SetVelocity( ply:GetUp() * 60 + Vector(0,0,5))
						ply:TakeForce( ply:GetTakeForce()+ply.gravity, true )
						ply.gravity = (ply.gravity+10)/2;
					end
				end )
			end
		end
	elseif( KEY == IN_SPEED and ply:KeyDown( IN_FORWARD ) ) then
		timer.Destroy( "ForceBackUpTimer" )
		ply.ConstSprint = true
		if( ply:GetClass() == CLASS_JEDI ) then
			if( ply:GetForce() >= 10 and !ply:IsOnGround() ) then
			elseif( ply:GetForce() >= 10 and ply:IsOnGround() ) then
				ply:EmitSound( "SWO/force/speed.wav" ) --@meeces2911 Updated sound path
				timer.Create( "ForceSprintConstTimer", 0.1, 0, function()
					if( ( ply:GetForce() < 5 ) or !ply.ConstSprint or !ply:IsOnGround() ) then
						ply:PrintMessage( HUD_PRINTCENTER, "No moar force :S" )
						ply:SetVelocity( Vector( 0, 0, 0 ) )
						ply:TakeForce( 0 )
					end
					ply:TakeForce( ply:GetTakeForce(), true )
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
		ply:SetVelocity( Vector( 0, 0, 0 ) )
		ply:TakeForce( 0 )
	end
	if( KEY == IN_JUMP ) then
		ply.ConstJump = false
		timer.Destroy( "ForceJumpConstTimer" );
		ply:SetVelocity( Vector( 0, 0, 0 ) );
		ply:TakeForce( 0 );
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
