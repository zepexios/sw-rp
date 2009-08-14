
--This alows me to add functions to the ply object
local ply = FindMetaTable("ply")

--This is only called at the begining so that the char sellection can display the name and such
function ply:LoadChars()
	local FilePath = "starwarsonline/"..self:UniqueID().."/chars.txt"
	if file.Exists(FilePath) then
		print("realy?")
		local contents = util.KeyValuesToTable(file.Read(FilePath))
		self.Chars = contents
		datastream.StreamToClients(self,"chardata",{Chars = contents})
	else

	end
end

function ply:SaveChars()
	local FilePath = "starwarsonline/"..self:UniqueID().."/chars.txt"
	if file.Exists(FilePath) then
		print("realy?")

		file.Write(FilePath,util.TableToKeyValues(self.Chars))
	else
		local CharsTable = {}
		table.Merge(CharsTable, CharTable)

		self.Chars = CharTable
		file.Write(FilePath,util.TableToKeyValues(CharTable))
		contents = CharTable
	end
end

function ply:MakeChar(CharTable)
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
datastream.Hook( "plyChar", IncomingHook );

function ply:Load(charkey)
	self:SetNWInt("char",charkey)
	self:Kill()
end

function LoadPlyCon(ply, cmd, args)
	local lol = string.lower(string.Implode(" ", args))
	PrintTable(args)
	print(lol)
	ply.Char = ply.Chars[lol]
end
concommand.Add("SWOLoadChar", LoadPlyCon)

function ply:GetClass()
	return self.Char.Class or "Unknown"
end
















