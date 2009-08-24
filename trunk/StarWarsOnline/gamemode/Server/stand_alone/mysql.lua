
--MySQL Testing file.
SWO.MySQL = SWO.MySQL or {};

local db, error = mysql.connect("page81.no-ip.org", "swo_gmod", "swotesting", "swo_gmod_main")
--local db, error = mysql.connect("192.168.1.10", "swo_gmod", "swotesting", "swo_gmod_main")
if (db == 0) then SWO.MySQL.Error = tostring(error) return end 