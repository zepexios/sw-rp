--[[------------------------NOTE----------------------------------
	Polkm: This file is for functions that add to the player object
--------------------------NOTE----------------------------------]]

--This alows me to add functions to the player object
local Player = FindMetaTable("Player")

--This is only called at the begining so that the char sellection can display the name and such
function Player:LoadChars()
	local FilePath = "starwarsonline/"..self:UniqueID().."/chars.txt"
	if file.Exists(FilePath) then
		print("realy?")
		local contents = util.KeyValuesToTable(file.Read(FilePath))
		self.Chars = contents
		datastream.StreamToClients(self,"chardata",{Chars = contents})
	else
		local CharTable = {}
		CharTable["billy"] = {"name" = "B.illy","image" = "nah"}
		self.Chars = CharTable
		file.Write(FilePath,util.TableToKeyValues(CharTable))
		datastream.StreamToClients(self,"chardata",{Chars = CharTable})
	end
end

function Player:Load(sellectedchar)
	local FilePath = "starwarsonline/"..self:UniqueID().."/"..sellectedchar.."/data.txt"
	if file.Exists(FilePath) then
		local contents = util.KeyValuesToTable(file.Read(FilePath))
		self:SetNWInt("name",contents["name"])
		self:SetNWInt("money",contents["money"])
		for k,v in pairs(WeaponsClasses) do
			self:SetNWInt(k,contents[k])
		end
	else
		
	end
end