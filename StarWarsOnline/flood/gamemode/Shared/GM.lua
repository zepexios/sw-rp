GM.Name 		= "Flood"
GM.Author 		= "iRzilla"
GM.TeamBased 	= false

TEAM_ALIVE = 2
TEAM_DEAD = 1

function GM:SetupTeams()
	team.SetUp(TEAM_ALIVE, "Alive", Color(20, 20, 200, 255))
	team.SetUp(TEAM_DEAD, "Dead", Color(125, 55, 145, 255))
end

function GM:GetGameDescription()
	return "Flood"
end

function GM:GetGamemodeDescription()
	return self:GetGameDescription()
end