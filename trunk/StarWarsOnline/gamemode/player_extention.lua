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
		SetNetwork( contents )
	else
		WasMenu = self:GetNWBool( "NewChar.WasCharMenu" )		//*Might* work :P
		if(WasMenu) then
			Data.Name = self:GetNWString( "NewChar.Name" )
			Data.Race = self:GetNWString( "NewChar.Race" )
			Data.Faction = self:GetNWString( "NewChar.Faction" )
			Data.Title = self:GetNWString( "NewChar.Title" )
			Data.Gender = self:GetNWString( "NewChar.Gender" )
			Data.OutFit = self:GetNWString( "NewChar.OutFit" )
		end
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
function SetNetwork( Table )
	for k,v in pairs(Table.String) do					//*Hopefilly* sets all the var's in the players "stuff" to global (this means the player table can only have 1 layer for each categoryE.g "String.Name" or "String.Player.Name" NOT "String.Player.Stuff.Name"!!)
		self:SetNWString( "String."..k, v )
		for i,h in pairs(Table.String.k) do
				self:SetNWString( "String." ..k.."."..i )
		end
	end
	for k,v in pairs(Table.Number) do
		self:SetNWFloat( "Number."..k, v )
		for i,h in pairs(Table.Number.k) do
				self:SetNWFloat( "Number." ..k.."."..i )
		end
	end
	for k,v in pairs(Table.Vector) do
		self:SetNWVector( "Vector."..k, v )
		for i,h in pairs(Table.Vector.k) do
				self:SetNWVector( "Vector." ..k.."."..i )
		end
	end
	for k,v in pairs(Table.Ent) do
		self:SetNWEntity( "Ent."..k, v )
		for i,h in pairs(Table.Ent.k) do
				self:SetNWEntity( "Ent." ..k.."."..i )
		end
	end
	for k,v in pairs(Table.Angle) do
		self:SetNWAngle( "Angle."..k, v )
		for i,h in pairs(Table.Angle.k) do
				self:SetNWAngle( "Angle." ..k.."."..i )
		end
	end
	for k,v in pairs(Table.Bool) do
		self:SetNWBool( "Bool."..k, v )
		for i,h in pairs(Bool.Angle.k) do
				self:SetNWBool( "Bool." ..k.."."..i )
		end
	end
end