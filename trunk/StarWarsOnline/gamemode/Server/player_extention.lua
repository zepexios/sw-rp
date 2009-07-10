--[[
_________ _______  _______ _________ _        _        _______ 
\__   __/(  ____ )/ ___   )\__   __/( \      ( \      (  ___  )
   ) (   | (    )|\/   )  |   ) (   | (      | (      | (   ) |
   | |   | (____)|    /   )   | |   | |      | |      | (___) |
   | |   |     __)   /   /    | |   | |      | |      |  ___  |
   | |   | (\ (     /   /     | |   | |      | |      | (   ) |
___) (___| ) \ \__ /   (_/\___) (___| (____/\| (____/\| )   ( |
\_______/|/   \__/(_______/\_______/(_______/(_______/|/     \|

]]-- Copy and paste this into notepad.. it looks epic ..MGinshe..
		--------------------------------------
		--       player_extention.lua       --
		-- Made for SWO by iRzilla & Polkm  --
		--------------------------------------

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

	end
end

function Player:SaveChars()
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

function Player:Load(charkey)
	self:SetNWInt("char",charkey)
	self:Kill()
end

function LoadPlyCon(ply, cmd, args)
	local lol = string.Implode(" ", args)
	local lol = string.lower(lol)
	PrintTable(args)
	print(lol)
	ply.CurrentChar = ply.Chars[lol]
end

concommand.Add("SWOLoadChar", LoadPlyCon)