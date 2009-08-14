
/*
	Advancement Boxes are to be considered their own objects
	
	The boxes are passed players in their functions so that they're not unique to players, they're universal
		-The only data stored on the player regarding the box is whether or not they have it unlocked
*/

local advBoxes = {}

function SWO.createAdvBox(name, dname, requires, XP, gives)
	local box = {}
	box["dname"] = dname //The display name
	//Requires is a table filled with the names of all other boxes that must be unlocked for this to be available
	box["requires"] = requires
	//XP is a table which has the type of XP required as indexes and the amount required as the value
	box["XP"] = XP
	/*
		Gives is a table of all of the unlocks that are granted when this box is granted
		gives.stats
		gives.skills
		gives.certs
		gives.titles
		must all be present in this table - regardless of whether or not they contain any data!
	*/
	box["gives"] = gives
	
	box.setLocked = function(ply, val) //NEVER CALL OUTSIDE OF THIS FILE
		if ply.swo.boxes[self.name] == val then //Don't stack the alterations of the values
			return
		end
	
		if not val then //Unlock
			ply.swo.boxes[self.name] = false
			
			for i, stat in pairs gives.stats do
				if not ply.swo.stats[i] then
					ply.swo.stats[i] = 0
				end
				ply.swo.stats[i] = ply.swo.stats[i] + stat
			end
			for i, skill in pairs gives.skills do
				ply.swo.skills[i] = true
			end
			for i, cert in pairs gives.certs do
				ply.swo.certs[i] = true
			end
		else //Relock
			ply.swo.boxes[self.name] = true
			
			for i, stat in pairs gives.stats do
				ply.swo.stats[i] = ply.swo.stats[i] - stat
			end
			for i, skill in pairs gives.skills do
				ply.swo.skills[i] = false
			end
			for i, cert in pairs gives.certs do
				ply.swo.certs[cert] = false
			end
		end
	end
	
	box.xpreq = function(ply)
		for typ, val in pairs(self["XP"]) do
			if ply.swo.xp[typ] < val then
			return false
		end
		return true
	end
	
	box.boxreq = function(ply)
		for i, req in pairs(self["requires"]) do
			if not ply.swo.boxes[req] then
				break
			end
			return true
		end
		return false
	end
	
	box.prereqs = function(ply)
		return xpreq & boxreq
	end
	
	box.unlock = function(ply) //CALLED BY A TRAINER
		if self.prereqs(ply) then
			self.setLocked(ply, false)
			return true
		else
			return false
		end
	end
	
	advBoxes[name] = box
end