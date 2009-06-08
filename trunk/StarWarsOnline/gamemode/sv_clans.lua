local Player = FindMetaTable("Player")

function Player:JoinClan(clan)
	local FilePath = "starwarsonline/"..self:UniqueID().."/chars.txt"
	if file.Exists(FilePath) then
		print(self:Nick().." joined: "..clan)
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