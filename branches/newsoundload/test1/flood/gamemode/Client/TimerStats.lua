-----------------------------
-- Flood By iRzilla
-----------------------------
-- Client/TimerStats.lua

usermessage.Hook( "FL.LiveTimer", function( um )
Start = um:ReadLong()
FL.NotifyBars.Strings[2] = false
FL.NotifyBars.Strings[0] = "Press F1 To Open The Help Guide"
end )

usermessage.Hook( "FL.BuildT", function( um )
BuildT = um:ReadLong()
if Start==1 then FL.NotifyBars.Strings[1] = "Build Time: "..string.ToMinutesSeconds(BuildT) end
end )

usermessage.Hook( "FL.FightT", function( um )
FightT = um:ReadLong()
if Start==2 then FL.NotifyBars.Strings[1] = "Fight Time: "..string.ToMinutesSeconds(FightT) end
end )

usermessage.Hook( "FL.ReflectT", function( um )
ReflectT = um:ReadLong()
if Start==3 then 
	FL.NotifyBars.Strings[1] = "Reflect Time: "..string.ToMinutesSeconds(ReflectTT)
	FL.NotifyBars.Strings[2] = "IRZILLA WINS!!"
end
end )