-----------------------------
-- Flood By iRzilla
-----------------------------
-- Server/RoundTimes.lua

FL.CurrentPhase = 1
FL.BT = 30
FL.FT = 30
FL.RT = 30

function FL.Init_Timers()
	FL.CurrentPhase = 1
	
	umsg.Start( "FL.LiveTimer" )
		umsg.Long( FL.CurrentPhase )
	umsg.End()
	umsg.Start( "FL.BuildT" )
		umsg.Long( FL.BT )
	umsg.End()
	umsg.Start( "FL.FightT" )
		umsg.Long( FL.FT )
	umsg.End()
	umsg.Start( "FL.ReflectT" )
		umsg.Long( FL.RT )
	umsg.End()

	timer.Create("FL.TimeWarp", 1, 0, FL.TimeWarp)

end

hook.Add( "Initialize", "FL.Init_Timers", FL.Init_Timers)

function FL.TimeWarp()
	umsg.Start( "FL.LiveTimer" )
		umsg.Long( FL.CurrentPhase )
	umsg.End()
	umsg.Start( "FL.BuildT" )
		umsg.Long( FL.BT )
	umsg.End()
	umsg.Start( "FL.FightT" )
		umsg.Long( FL.FT )
	umsg.End()
	umsg.Start( "FL.ReflectT" )
		umsg.Long( FL.RT )
	umsg.End()
	
	if FL.CurrentPhase == 1 then
		FL.BuildT()
	elseif FL.CurrentPhase == 2 then
		FL.FightT()
	elseif FL.CurrentPhase == 3 then
		FL.ReflectT()
	end
end 

function FL.BuildT()
	if FL.BT <= 0 then
		FL.Msg("Build Round Finished")
		FL.Msg("Fight Round Started")
		FL.ToggleWater()
		FL.CurrentPhase = 2
		FL.BT = 30
	else
		FL.BT = (FL.BT - 1)
	end
end

function FL.FightT()
	if FL.FT <= 0 then
			FL.Msg("Fight Round Finished")
			FL.Msg("Reflect Round Started")
			FL.CurrentPhase = 3
			FL.ToggleWater()
			FL.FT = 30
	else  
		FL.FT = (FL.FT - 1)
	end
end

function FL.ReflectT()
	if FL.RT <= 0 then
		FL.Msg("Reflect Round Finished")
		FL.Msg("Build Round Started")
		FL.CurrentPhase = 1
		FL.RT = 30
	else  
		FL.RT = (FL.RT - 1)
	end	
end
