// Check it is the server

if (!SERVER) then return end

// ConVar

CreateConVar("serversecure_enabled", "1", FCVAR_NOTIFY)

// Check if it is enabled

if (GetConVarNumber("serversecure_enabled") == 1) then
	// Serverside

	include("ServerSecureServer/AutoRun.lua")
end