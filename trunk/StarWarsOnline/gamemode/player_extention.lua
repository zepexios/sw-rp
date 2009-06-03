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
		--[[local CharTable = {}
		CharTable["billy"] = {}
		CharTable["billy"].name = "Trooper Billy"
		CharTable["billy"].image = "VGUI/entities/npc_barney"
		CharTable["lolcat"] = {}
		CharTable["lolcat"].name = "Jedi Lolcat"
		CharTable["lolcat"].image = "VGUI/entities/alyx"
		
		self.Chars = CharTable
		file.Write(FilePath,util.TableToKeyValues(CharTable))
		datastream.StreamToClients(self,"chardata",{Chars = CharTable})
		--]]
	end
end

function Player:MakeChar(CharTable)
	local FilePath = "starwarsonline/"..self:UniqueID().."/chars.txt"
	if file.Exists(FilePath) then
		print("realy?")
		local contents = util.KeyValuesToTable(file.Read(FilePath))

		table.Merge(contents, CharTable)
		self.Chars = contents
		file.Write(FilePath,util.TableToKeyValues(contents))
	else
		local CharsTable = {}
		table.Merge(CharsTable, CharTable)

		self.Chars = CharTable
		file.Write(FilePath,util.TableToKeyValues(CharTable))
		contents = CharTable
	end
	
	datastream.StreamToClients(self,"chardata",{Chars = self.Chars})
end

function IncomingHook( pl, handler, id, encoded, decoded )

	print( "GLON Encoded: " .. encoded );
	print( "Decoded:" );
	PrintTable( decoded );
	
	pl:MakeChar(decoded)
 
end
datastream.Hook( "PlayerChar", IncomingHook );

function Player:Load(sellectedchar)
	self:SetNWInt("name",CharTable)
	self:SetNWInt("money",contents["money"])
--[[ for k,v in pairs(WeaponsClasses) do
		self:SetNWInt(k,contents[k])
	end --]]
end
