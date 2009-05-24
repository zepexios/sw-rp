Limit = SS.Plugins:New("Limit")

// Tables

Limit.List = {}

// Limit

function Limit.Add(Type, Group, Amount)
	Group = SS.Groups.Find(Group)
	
	// Group
	
	if (Group) then
		Type = string.lower(Type)
		
		// Add it to the table
		
		Limit.List[Group] = Limit.List[Group] or {}
		Limit.List[Group][Type] = Amount
	end
end

// The old proccess

function Limit.Reached(Player, Type)
	local Max = server_settings.Int("sbox_max"..Type, 0)
	
	// Get count
	
	if (Player:GetCount(Type) < Max or Max < 0) then return true end 
	
	// Limit hit
	
	Player:LimitHit(Type) 
end

// Command

local Command = SS.ChatCommands:New("Limit")

function Command.Command(Player, Args)
	local Group, Error = SS.Groups.Find(Args[1])
	
	// Check group
	
	if (Group) then
		for K, V in pairs(Limit.Types) do
			if (string.lower(Args[2]) == string.lower(V)) then
				if (SS.Lib.StringNumber(Args[3])) then
					Limit.Add(Args[2], Group, Args[3])
					
					// Message
					
					SS.PlayerMessage(0, Group.."'s "..Args[2].." limit set to "..Args[3].."!", 0)
				else
					SS.PlayerMessage(Player, "The amount must be a valid number!", 1)
				end
				
				// Return
				
				return
			end
		end
		
		// Message
		
		SS.PlayerMessage(Player, "That is not a valid entity type!", 1)
	else
		SS.PlayerMessage(Player, Error, 1)
	end
end

Command:Create(Command.Command, {"Server", "Limit"}, "Set limit of entities allowed for a group", "<Group> <Type> <Amount>", 3, " ")

// New process

function Limit.Check(Player, Type)
	Type = string.lower(Type)
	
	// Loop
	
	for K, V in pairs(Limit.List) do
		if (SS.Player.Rank(Player) == K) then
			for B, J in pairs(V) do
				if (Type == B) then
					if (Player:GetCount(Type) < J or J == -1) then
						return true
					else
						local Message = SS.Player.Rank(Player).."'s can only only spawn "..J.." "..B.."!"
						
						// J is 0
						
						if (J == 0) then
							Message = SS.Player.Rank(Player).."'s aren't allowed to spawn any "..B.."!"
						end
						
						// Message
						
						SS.PlayerMessage(Player, Message, 1)
						
						// Return false
						
						return false
					end
				end
			end
		end
	end
	
	// Return limit reached
	
	return Limit.Reached(Player, Type)
end

// When player spawns prop

function Limit.PlayerSpawnProp(Player, Model)
	local Check = Limit.Check(Player, "Props")
end

hook.Add("PlayerSpawnProp", "Limit.PlayerSpawnProp", Limit.PlayerSpawnProp)

// When player spawns npc

function Limit.PlayerSpawnNPC(Player, Type, Weapon)
	return Limit.Check(Player, "NPCS")
end

hook.Add("PlayerSpawnNPC", "Limit.PlayerSpawnNPC", Limit.PlayerSpawnNPC)

// When player spawns ragdoll

function Limit.PlayerSpawnRagdoll(Player, Model)
	return Limit.Check(Player, "Ragdolls")
end

hook.Add("PlayerSpawnRagdoll", "Limit.PlayerSpawnRagdoll", Limit.PlayerSpawnRagdoll)

// When player spawns vehicle

function Limit.PlayerSpawnVehicle(Player, Model)
	return Limit.Check(Player, "Vehicles")
end

hook.Add("PlayerSpawnVehicle", "Limit.PlayerSpawnVehicle", Limit.PlayerSpawnVehicle)

// When player spawns sent

function Limit.PlayerSpawnSENT(Player, ID)
	return Limit.Check(Player, "SENTS")
end

hook.Add("PlayerSpawnSENT", "Limit.PlayerSpawnSENT", Limit.PlayerSpawnSENT)

// When player spawns effect

function Limit.PlayerSpawnEffect(Player, Model)
	return Limit.Check(Player, "Effects")
end

hook.Add("PlayerSpawnEffect", "Limit.PlayerSpawnEffect", Limit.PlayerSpawnEffect)

// Config

include("Config.lua")

// Finish plugin

Limit:Create()