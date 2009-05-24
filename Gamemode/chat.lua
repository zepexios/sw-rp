whisp = 100
function Chatting(ply, text)
       if( string.sub( text, 1, 2 ) == "/w" ) then
             for k,v in pairs(player.GetAll()) do
                  if( v:GetPos():Distance( ply:GetPos() ) <= whisp ) then
                         v:PrintMessage(3, ply:Nick().."[Whisper]: "..string.sub(text, 3))
                  end
             end
        elseif( string.sub(text, 1, 2) == "/y" ) then
              for k,v in pairs(player.GetAll()) do
                     if( v:GetPos():Distance( ply:GetPos() ) <= whisp * 2 ) then
                        v:PrintMessage(3, ply:Nick().."[Yell]: "..string.sub(text, 3))
                     end
              end
         elseif( string.sub(text, 1, 4) == "/ooc" ) then
               return string.sub(text, 6 ) 
         else
               for k,v in pairs(player.GetAll()) do
                      v:PrintMessage(3, ply:Nick()..": "..text)
					  return "";
        end
end
hook.Add("PlayerSay", "ChatCommands", Chatting)
