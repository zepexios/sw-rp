include( 'init.lua' )
include( 'cl_init.lua' )
 
function SWLightSaberDeflect( ply )						//most of this is self-explantory
	local UserData = GM:SWReadPlayerData( ply )			//reads the users data from a function (see login.lua)
	local SaberLvl = UserData.SaberLvl					//gets the players SaberLvl from the data store Table
		function GM:PlayerHurt( player, SaberAttacker ) 
			if(SaberAttacker:GetWeapon() != (LightSaber or Hands or and ply:GetWeapon() = LightSaber)
			end
		end
	if(ply:GetWeapon() == LightSaber and ply:OnPlayerDamage( victim, killer, weapon)) then
	
	end
end

// chat such as ooc etc stated below
	

whisp = 100   
function Chatting(ply, text)   
       if( string.sub( text, 1, 2 ) == "/w" ) then   
             for k,v in pairs(player.GetAll()) do   
                  if( v:GetPos():Distance( ply:GetPos() ) <= whisp ) then   
                         v:PrintMessage(3, ply:Nick().."[Whisper]: "..string.sub(text, 3))   
                         return "";
                  end   
             end   
        elseif( string.sub(text, 1, 2) == "/y" ) then   
              for k,v in pairs(player.GetAll()) do   
                     if( v:GetPos():Distance( ply:GetPos() ) <= whisp * 2 ) then   
                        v:PrintMessage(3, ply:Nick().."[Yell]: "..string.sub(text, 3))   
                        return "";
                     end   
              end   
         elseif( string.sub(text, 1, 4) == "/ooc" ) then   
               return text   
         else   
               for k,v in pairs(player.GetAll()) do   
                      v:PrintMessage(3, ply:Nick()..": "..text)   
                      return "";
        end   
	end   
end
hook.Add("PlayerSay", "ChatCommands", Chatting) 
function ScaleDamage( ply, hitgroup, dmginfo )

	if ( hitgroup == HITGROUP_HEAD ) then
		dmginfo:ScaleDamage( 2 )
	end
	if (hitgroup == HITGROUP_LEFTARM or
		hitgroup == HITGROUP_RIGHTARM or 
		hitgroup == HITGROUP_LEFTLEG or
		hitgroup == HITGROUP_LEFTLEG or
		hitgroup == HITGROUP_GEAR ) then
 
		dmginfo:ScaleDamage( 0.25 )
 
	end
 
end 
hook.Add("ScalePlayerDamage","ScaleDamage",ScaleDamage)	
function GM:KeyPress( Ply, key )
	if(key == "q") then
		RunConsoleCommand( "+SW_menu" )
	end
	if(key == "f") then		//can be overrited by changing the flashlighty key, will fix this after Login.lua si done
		SWInventory( Flashlight )
	end
end
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	