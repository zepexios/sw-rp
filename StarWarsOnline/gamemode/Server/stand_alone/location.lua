
/*
	Why location objects?
		1. Storage - The SQL server may not be able to handle vectors
		2. Planets - We need to know what planet the player is on
*/

SWO.vecToLocation(vec, planet)
	local loc = {}
	loc.x = vec.x
	loc.y = vec.y
	loc.z = vec.z
	loc.planet = planet
	return loc
end

SWO.locationToVec(loc)
	return Vector(loc.x, loc.y, loc.z)
end

SWO.updateLocation(loc, vec)
	loc.x = vec.x
	loc.y = vec.y
	loc.z = vec.z
	return loc
end